//
//  MDNavigationBar.h
//  Meditation
//
//  Created by Iten on 2018/11/13.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MDView.h"

@interface MDNavigationBar : MDView

@property (nonatomic, copy) NSString *title;

- (void)addRightNavItem:(UIView *)item;
+ (UIView *)placeHolderView;

@end
