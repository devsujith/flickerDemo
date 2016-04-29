//
//  PhotoDetailViewController.m
//  flickerDemo
//
//  Created by Sujith Chandran on 29/04/16.
//  Copyright © 2016 Sujith. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "LargeCollectionViewCell.h"

@interface PhotoDetailViewController ()
@property(strong,nonatomic) UICollectionView *largeCollection;


@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
     [self setupViews];
}

-(void)setupViews{
    
    //collectionview
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    self.largeCollection = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    self.largeCollection.dataSource = self;
    self.largeCollection.delegate = self;
    [self.largeCollection registerClass:[LargeCollectionViewCell class ] forCellWithReuseIdentifier:@"large"];
    self.largeCollection.backgroundColor = [UIColor whiteColor];
    self.largeCollection.pagingEnabled = true;
    
    [self.view addSubview:self.largeCollection];
    
    [self.largeCollection scrollToItemAtIndexPath:self.selectedIndex atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:false];
    
    
    
    
    
    
}

//collectionview methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LargeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"large" forIndexPath:indexPath];
    
    
    
    NSDictionary *photo = [self.photos objectAtIndex:indexPath.item];
    
    NSString *photoUrl = [FlickerMethodsViewController LargePhotoUrlStringForPhoto:photo];
    
    [cell.imageview sd_setImageWithURL:[NSURL URLWithString:photoUrl] placeholderImage:[UIImage imageNamed:@"placeHolder_large"] ];
    
    
    cell.titleLabel.text = [photo objectForKey:@"title"];
    [cell.titleLabel sizeToFit];
    [cell.scroll setZoomScale:1];
    
    
    
    
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    
    return CGSizeMake( self.largeCollection.frame.size.width ,  self.largeCollection.frame.size.height- 64);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
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
