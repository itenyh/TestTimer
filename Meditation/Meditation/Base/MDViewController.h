//
//  MDViewController.h
//  Meditation
//
//  Created by mke Qi on 2018/11/5.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MDNavigationBar.h"

@interface MDViewController : UIViewController

@property (nonatomic, strong) MDNavigationBar *navigationBar;
@property (nonatomic, strong) UIView *contentView;

- (void)setupUI;
- (void)setupConstraints;
- (void)setupBinding;

- (void)controllerDidReady;


- (UIView *)_createNaviTitleViewOnContainerView:(void (^)(UIView *container))setupContainerBlock;
- (UIBarButtonItem *)_createNaviItemOnContainerView:(void (^)(UIView *container))setupContainerBlock;

@end
