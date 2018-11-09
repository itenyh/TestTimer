//
//  AppDelegate.m
//  Meditation
//
//  Created by itenyh on 2018/11/3.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "AppDelegate.h"

#import "MDTabBarController.h"

#import "StageZeroViewController.h"
#import "StageOneViewController.h"
#import "MainViewController.h"
#import "MDContentViewController.h"
#import "HistoryViewController.h"
#import "MDDetailViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)lastObject];
    NSLog(@"documentPath: %@", documentPath);
    
    MDTabBarController *tabBarController = [MDTabBarController new];
    
    UIViewController *mainVC = [StageZeroViewController new];
    mainVC.tabBarItem.title = @"主页";
    
    MDContentViewController *contentVC = [MDContentViewController new];
    contentVC.tabBarItem.title  = @"内容";
    
    tabBarController.viewControllers = @[mainVC, contentVC];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    navController.navigationBar.hidden = YES;
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
