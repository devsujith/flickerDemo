//
//  AppDelegate.m
//  flickerDemo
//
//  Created by Sujith Chandran on 28/04/16.
//  Copyright © 2016 Sujith. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [self initialSetups];
    [self setupAppearance];
    
    GridViewController *grid = [[GridViewController alloc]init];
    
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:grid];
    self.window.rootViewController = nav;
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)setupAppearance{
    
    
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor colorWithRed:60/255.0 green:67/255.0 blue:80/255.0 alpha:1],NSForegroundColorAttributeName,
                                                          nil]];
    
    
    
    [[UIImageView appearance] setClipsToBounds:true];
    
    
    
}
-(void)initialSetups{
    
    [AFNetworkReachabilityManager sharedManager];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        ////DDLogInfo(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        
        if (status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN)
        {
            //  [defaults setBool:true forKey:@"isReachable"];
            [defaults setValue:@"yes" forKey:@"isReachable"];
            
        }
        else if(status == AFNetworkReachabilityStatusNotReachable)
        {
            //   [defaults setBool:false forKey:@"isReachable"];
            [defaults setValue:@"no" forKey:@"isReachable"];
        }
        else
        {
            [defaults setValue:@"yes" forKey:@"isReachable"];
        }
        
        [defaults synchronize];
    }];
    
    
    

    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
