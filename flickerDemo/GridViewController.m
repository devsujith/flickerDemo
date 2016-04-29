//
//  GridViewController.m
//  flickerDemo
//
//  Created by Sujith Chandran on 28/04/16.
//  Copyright © 2016 Sujith. All rights reserved.
//

#import "GridViewController.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "PhotoDetailViewController.h"
#import "LocationManagerInstance.h"

@interface GridViewController ()

@property(strong,nonatomic) UICollectionView *thumbnailCollection;
@property(strong,nonatomic) UILabel *emptyLabel;
@property(strong,nonatomic) NSMutableArray *photos;
@property(strong,nonatomic) NSDictionary *responseDictionary;
@property CGFloat cellSize;
@property(strong,nonatomic) NSString *currentPage;
@property(strong,nonatomic) NSString *searchTerm;
@property BOOL location;





@end

@implementation GridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    //defaults
    self.title = @"Birthday Photos";
    self.searchTerm = @"Birthday";
    self.location = false;
    
    [self setupViews];
    [self getPhotos];

}


-(void)setupViews{
    
    
    
    //add bar button
    
    UIBarButtonItem *rightbarbutton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(actionBarButton)];
    
    self.navigationItem.rightBarButtonItem = rightbarbutton;
    
    //empty Label
    self.emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
    self.emptyLabel.center = self.view.center;
    self.emptyLabel.text = @"Oops..Seems there is no result to show , choose some other option";
    self.emptyLabel.hidden = true;
    self.emptyLabel.numberOfLines = 0;
    [self.view addSubview:self.emptyLabel];
   
    //collection view
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];

    
    self.thumbnailCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:layout];
    self.thumbnailCollection.dataSource = self;
    self.thumbnailCollection.delegate = self;
    [self.thumbnailCollection registerClass:[thumbCollectionViewCell class ] forCellWithReuseIdentifier:@"thumbnail"];
    self.thumbnailCollection.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.thumbnailCollection];
    
    //infinte scroll using lirbrary
    __weak typeof(self) weakSelf = self; // weak reference to use inside block // stackoverflow
    [self.thumbnailCollection addInfiniteScrollingWithActionHandler:^{
        
    [weakSelf GetNextSetOfPhotos];
        
    }];
}








//getting photos
-(void)getPhotos{
    
    self.thumbnailCollection.showsInfiniteScrolling = true;
    
    [self showActivityIndicatorInView:self.view withTitle:@"Loading..."];
    if ([self isReachable]) {
    
        self.currentPage = @"1";
        
      
        NSString *url = [FlickerMethodsViewController searchUrlForString:self.searchTerm withPage:self.currentPage withLocation:self.location];
        
      
        
              AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager GET:url parameters:nil progress:Nil success:^(NSURLSessionTask *operation, id responseObject) {
            
             self.responseDictionary = (NSDictionary *)responseObject;
            
            if([[self.responseDictionary objectForKey:@"stat"]isEqualToString:@"ok"])
            {
                 self.photos = [[NSMutableArray alloc]init];
                [self.photos addObjectsFromArray:[[self.responseDictionary objectForKey:@"photos"] objectForKey:@"photo"]];
                
                if(self.photos.count == 0)
                {
                    self.emptyLabel.hidden = false;
                    self.thumbnailCollection.hidden = true;
                    
                }
                else
                {
                    self.emptyLabel.hidden = true;
                    self.thumbnailCollection.hidden = false;
                    
                }
       
                self.currentPage = [[self.responseDictionary objectForKey:@"photos"] objectForKey:@"page"];
                [self.thumbnailCollection reloadData];
            }
            else
            {
                [self showError];
            }
            
            
            
             [self removeActivityIndicatorForView:self.view];
                    } failure:^(NSURLSessionTask *operation, NSError *error) {
            
           
            [self removeActivityIndicatorForView:self.view];
            [self showError];
        }];
        
           }
    else
    {
        
        [self showNoInternetError];
        [self removeActivityIndicatorForView:self.view];
    }

    
}


// infinite scrolling

-(void)GetNextSetOfPhotos{
    
    
    if ([self isReachable]) {
        
        CGFloat page = self.currentPage.floatValue + 1;
        
        NSString *nextpage = [NSString stringWithFormat:@"%0.f",page];
        
        
        
        
        
        NSString *url = [FlickerMethodsViewController searchUrlForString:self.searchTerm withPage:nextpage withLocation:self.location];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager GET:url parameters:nil progress:Nil success:^(NSURLSessionTask *operation, id responseObject) {
            
            self.responseDictionary = (NSDictionary *)responseObject;
            
            if([[self.responseDictionary objectForKey:@"stat"]isEqualToString:@"ok"])
            {
                
                NSMutableArray *newPhotos = [[self.responseDictionary objectForKey:@"photos"] objectForKey:@"photo"];
                
                if(newPhotos.count == 0)
                {
                    self.thumbnailCollection.showsInfiniteScrolling = false;
                }
                
                self.currentPage = [[self.responseDictionary objectForKey:@"photos"] objectForKey:@"page"];
                
                [self appendNewPhotos:newPhotos];
                
               
            }
            else
            {
                [self showError];
            }
            
            
            
            [self removeActivityIndicatorForView:self.view];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            
            
            [self removeActivityIndicatorForView:self.view];
            [self showError];
        }];
        
    }
    else
    {
        [self showNoInternetError];
        [self removeActivityIndicatorForView:self.view];
    }
    
    
    
}

-(void)appendNewPhotos:(NSMutableArray *)data{
    
    
    [self.thumbnailCollection performBatchUpdates:^{
        NSInteger resultsSize = [self.photos count];
        
        [self.photos addObjectsFromArray:data];
        
        NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
        
        for (NSInteger i = resultsSize; i < resultsSize + data.count; i++) {
            [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        [self.thumbnailCollection insertItemsAtIndexPaths:arrayWithIndexPaths];
    }
                                       completion:nil];
    
    
    [self.thumbnailCollection.infiniteScrollingView stopAnimating];
    
    
    
    
    
    
    
    
    
    
    
    
}



//collectionview methods


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    thumbCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"thumbnail" forIndexPath:indexPath];
    
    
    
    NSDictionary *photo = [self.photos objectAtIndex:indexPath.item];
    
    NSString *photoUrl = [FlickerMethodsViewController ThumbnailPhotoUrlStringForPhoto:photo];
    
    [cell.imageview sd_setImageWithURL:[NSURL URLWithString:photoUrl] placeholderImage:[UIImage imageNamed:@"placeHolder_thumbnail"] ];
    
    
    cell.titleLabel.text = [photo objectForKey:@"title"];
    
    
    
    
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.cellSize = [[UIScreen mainScreen]bounds].size.width ;
    
    self.cellSize = ( self.cellSize - 40) / 3;
    
    return CGSizeMake( self.cellSize,  self.cellSize);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return 10;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //go to detailed page
    
    PhotoDetailViewController *vc = [[PhotoDetailViewController alloc]init];
    vc.photos = self.photos;
    vc.selectedIndex = indexPath;
    
    [self.navigationController pushViewController:vc animated:true];
    
    
    
}



//action Bar

-(void)actionBarButton{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Edit"
                                                                   message:@"Please choose from below"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Change Search tag"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              
                                                              
                                                              [self actionChangeSearchTerm];
                                                          }];
    
    NSString *locationMessage =@"";
    if(self.location)
    {
        locationMessage = @"Disable nearby photos";
    }
    else
    {
        locationMessage = @"Enable nearby photos";
    }
    
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:locationMessage
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               
                                                               
                                                               
                                                               [self toggleShowNearby];
                                                           }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                                                               NSLog(@"Cancel");
                                                           }];
    
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
}

-(void)actionChangeSearchTerm{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Search Tag" message:@"Enter search tag below" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Search" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        
        UITextField *searchText = [alert.textFields objectAtIndex:0];
        
        self.searchTerm = searchText.text;
        self.title = [NSString stringWithFormat:@"%@ Photos",self.searchTerm];
        [self getPhotos];
        
        
        
    }];
    
    [alert addAction:defaultAction];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Input search tag...";
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}

-(void)toggleShowNearby{
    
    self.location = !self.location;
    
    [self getPhotos];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
