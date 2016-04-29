//
//  FlickerMethodsViewController.m
//  flickerDemo
//
//  Created by Sujith Chandran on 28/04/16.
//  Copyright © 2016 Sujith. All rights reserved.
//

#import "FlickerMethodsViewController.h"
#import "LocationManagerInstance.h"

@interface FlickerMethodsViewController ()

@end

@implementation FlickerMethodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NSString *)searchUrlForString:(NSString *)searchString withPage:(NSString *)page withLocation:(BOOL)location{
    
    NSString *APIKey = @"73a6e5bc4362bf6210966720d833f8ab";
    NSString *search = [searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if(location)
    {
    
    NSString *latitude =  [[LocationManagerInstance sharedManager] latitude];
    NSString *longitude = [[LocationManagerInstance sharedManager] longitude];
        
        if(!latitude || !longitude || [latitude isEqualToString:@""] || [longitude isEqualToString:@""])
        {
           // cant get location
           return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&page=%@&per_page=20&format=json&nojsoncallback=1", APIKey, search, page];
   
        }
        else
        {
    //has location
    
  
    
            
             return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&lat=%@&lon=%@&tags=%@&page=%@&per_page=20&format=json&nojsoncallback=1", APIKey,latitude,longitude,search,page];
        }
    }
    else
    {
        //location not needed
       
        return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&page=%@&per_page=20&format=json&nojsoncallback=1", APIKey, search, page];
        
    }

    
    
   
}




+ (NSString*)ThumbnailPhotoUrlStringForPhoto:(NSDictionary *)photo{
    
      //  https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_t.jpg
    
    
    NSString *farmID = [photo objectForKey:@"farm"];
     NSString *serverID = [photo objectForKey:@"server"];
    NSString *ID = [photo objectForKey:@"id"];
    NSString *secret = [photo objectForKey:@"secret"];
    
    
    NSString *photoUrl = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_t.jpg",farmID,serverID,ID,secret];
    return photoUrl;
    
    
}

+ (NSString*)LargePhotoUrlStringForPhoto:(NSDictionary *)photo{
    
  //  https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_b.jpg
    
    NSString *farmID = [photo objectForKey:@"farm"];
    NSString *serverID = [photo objectForKey:@"server"];
    NSString *ID = [photo objectForKey:@"id"];
    NSString *secret = [photo objectForKey:@"secret"];
    
    
    NSString *photoUrl = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_b.jpg",farmID,serverID,ID,secret];
    return photoUrl;
    
    
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
