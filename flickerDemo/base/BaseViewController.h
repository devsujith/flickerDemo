//
//  BaseViewController.h
//  flickerDemo
//
//  Created by Sujith Chandran on 28/04/16.
//  Copyright © 2016 Sujith. All rights reserved.
// Base class for some common functions , which can be reused through the app.

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "FlickerMethodsViewController.h"


@interface BaseViewController : UIViewController

-(void) showActivityIndicatorInView:(UIView *) view withTitle:(NSString *) title;
-(void) showActivityIndicatorInView:(UIView *) view;
-(void) changeActivityIndicatorTitleTo: (NSString*) title inView:(UIView *) view;
-(void) removeActivityIndicatorForView:(UIView *) view;
-(void) showError;
- (BOOL)connected;
-(void) showNoInternetError;

-(void) showAnswerNotPostedError;
- (void)showMessage:(NSString *)text withTitle:(NSString *)title;


- (BOOL) isReachable;


@end
