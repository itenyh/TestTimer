//
//  AppDelegate.m
//  Meditation
//
//  Created by itenyh on 2018/11/3.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "AppDelegate.h"

#import "MDTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)lastObject];
    NSLog(@"documentPath: %@", documentPath);

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[MDTabBarController new]];
    navController.navigationBar.hidden = YES;
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
