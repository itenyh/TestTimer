//
//  MDTabBarController.m
//  Meditation
//
//  Created by Iten on 2018/11/9.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "MDTabBarController.h"

#import "MDTabBarView.h"

#import "StageZeroViewController.h"
#import "StageOneViewController.h"
#import "MainViewController.h"
#import "MDContentViewController.h"
#import "HistoryViewController.h"
#import "MDDetailViewController.h"
#import "MDCalendarViewController.h"

@interface MDTabBarController () <MDTabBarViewDelegate>

@property (nonatomic, strong) MDTabBarView *tabBarView;

@end

@implementation MDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.hidden = YES;
    [self.view addSubview:self.tabBarView];
    [self.tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
    }];
    [self.tabBarView setImages:@[@"tab_time_unselected", @"tab_time_selected", @"tab_book_unselected", @"tab_book_selected"]];
    self.selectedIndex = 0;
    
    UIViewController *mainVC = [MainViewController new];
    MDContentViewController *contentVC = [MDContentViewController new];
    
    self.viewControllers = @[mainVC, contentVC];
    
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    [self.tabBarView selectIndex:selectedIndex];
}

#pragma - mark MDTabBarViewDelegate

- (void)MDTabBarView:(MDTabBarView *)view selectedIndex:(NSInteger)index {
    self.selectedIndex = index;
}

#pragma - mark Lazy Load

- (MDTabBarView *)tabBarView {
    if (!_tabBarView) {
        _tabBarView = [MDTabBarView new];
        _tabBarView.delegate = self;
    }
    return _tabBarView;
}

@end
