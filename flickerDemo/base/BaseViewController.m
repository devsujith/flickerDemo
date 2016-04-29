//
//  BaseViewController.m
//  flickerDemo
//
//  Created by Sujith Chandran on 28/04/16.
//  Copyright © 2016 Sujith. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)isReachable
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *reachable = [defaults valueForKey:@"isReachable"];
    
    
    
    
    if([reachable isEqualToString:@"yes"])
    {
        return YES ;
    }
    else
    {
        return NO;
    }
    
    
}

- (BOOL)connected {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

-(void) showActivityIndicatorInView:(UIView *) view withTitle:(NSString *) title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = title;
    hud.animationType = MBProgressHUDAnimationZoomIn;
}
-(void) showActivityIndicatorInView:(UIView *) view
{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

- (void) changeActivityIndicatorTitleTo: (NSString*) title inView:(UIView *) view
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    hud.labelText = title;
}

-(void) removeActivityIndicatorForView:(UIView *) view
{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}


-(void) showNoInternetError
{
    
    
    
    [[[UIAlertView alloc] initWithTitle:@"Error!"
                                message:@"No internet Connection found, try again."
                               delegate:self
                      cancelButtonTitle:@"Dismiss"
                      otherButtonTitles:nil] show];
    
}

-(void) showAnswerNotPostedError
{
    [[[UIAlertView alloc] initWithTitle:@"Not Updated"
                                message:@"No internet Connection found, Your answer was not updated to the world"
                               delegate:self
                      cancelButtonTitle:@"Dismiss"
                      otherButtonTitles:nil] show];
    
}
-(void) showError
{
    [[[UIAlertView alloc] initWithTitle:@"Error!"
                                message:@"Oops, something went wrong, try again."
                               delegate:nil
                      cancelButtonTitle:@"Dismiss"
                      otherButtonTitles:nil] show];
}


- (void)showMessage:(NSString *)text withTitle:(NSString *)title
{
    [[[UIAlertView alloc] initWithTitle:title
                                message:text
                               delegate:self
                      cancelButtonTitle:@"Dismiss"
                      otherButtonTitles:nil] show];
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
