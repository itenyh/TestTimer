//
//  MDNavigationBar.m
//  Meditation
//
//  Created by Iten on 2018/11/13.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "MDNavigationBar.h"

@interface MDNavigationBar ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MDNavigationBar

- (void)setupUI {
    [self addSubview:self.titleLabel];
}

- (void)setupConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-10);
    }];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric, 64);
}

+ (UIView *)placeHolderView {
    UIView *placeHolder = [UIView new];
    [placeHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@64);
    }];
    return placeHolder;
}

#pragma - mark Public Method
#pragma ()
- (void)addRightNavItem:(UIView *)item {
    [self addSubview:item];
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self.titleLabel);
    }];
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

#pragma - mark Lazy Load

MDLazyInit(UILabel, titleLabel)

@end
