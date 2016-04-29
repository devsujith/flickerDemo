//
//  FlickerMethodsViewController.h
//  flickerDemo
//
//  Created by Sujith Chandran on 28/04/16.
//  Copyright © 2016 Sujith. All rights reserved.
//  Class to add flicker API methods.

#import <UIKit/UIKit.h>

@interface FlickerMethodsViewController : UIViewController

+ (NSString *)searchUrlForString:(NSString *)searchString withPage:(NSString *)page withLocation:(BOOL)location;


+ (NSString*)ThumbnailPhotoUrlStringForPhoto:(NSDictionary *)photo;
+ (NSString*)LargePhotoUrlStringForPhoto:(NSDictionary *)photo;

@end
