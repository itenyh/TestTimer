//
//  MDTabBarView.h
//  Meditation
//
//  Created by Iten on 2018/11/13.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "MDView.h"

@class MDTabBarView;
@protocol MDTabBarViewDelegate <NSObject>

- (void)MDTabBarView:(MDTabBarView *)view selectedIndex:(NSInteger)index;

@end

@interface MDTabBarView : MDView

@property (nonatomic, weak) id<MDTabBarViewDelegate> delegate;

- (void)setImages:(NSArray *)images;
- (void)selectIndex:(NSInteger)index;
+ (UIView *)placeHolderView;

@end
