//
//  AppDelegate.m
//  GPFRankingList
//
//  Created by IAP-guo-pf on 17/4/24.
//  Copyright © 2017年 guo-pf. All rights reserved.
//

#import "GPFAppDelegate.h"
#import "GPFViewController.h"

@interface GPFAppDelegate ()

@end

@implementation GPFAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    GPFViewController *VC = [[GPFViewController alloc]init];
    self.window.rootViewController = VC;
  
    
    
     [self.window makeKeyAndVisible];
    return YES;
}


@end
