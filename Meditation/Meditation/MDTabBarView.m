//
//  MDTabBarView.m
//  Meditation
//
//  Created by Iten on 2018/11/13.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "MDTabBarView.h"

@interface MDTabBarView ()

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, copy) NSArray<UIButton *> *buttons;

@end

@implementation MDTabBarView

- (void)setupUI {
    [self addSubview:self.stackView];
    [self addSubview:self.lineView];
}

- (void)setupConstraints {
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@0.5);
    }];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric, 64);
}

- (void)setButtons:(NSArray<UIButton *> *)buttons {
    _buttons = buttons;
    for (UIButton *button in buttons) {
        [self.stackView addArrangedSubview:button];
    }
}

- (void)action:(UIButton *)sender {
    [self.delegate MDTabBarView:self selectedIndex:sender.tag];
}

#pragma - mark Public Method

- (void)setImages:(NSArray *)images {
    NSMutableArray *buttons = [NSMutableArray array];
    for (int i = 0; i < images.count / 2; i++) {
        UIImage *unSelectedImage = [UIImage imageNamed:images[i * 2]];
        UIImage *selectedImage = [UIImage imageNamed:images[i * 2 + 1]];
        UIButton *button = [UIButton new];
        [button setImage:unSelectedImage forState:UIControlStateNormal];
        [button setImage:selectedImage forState:UIControlStateSelected];
        button.tag = i;
        [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [buttons addObject:button];
    }
    self.buttons = buttons;
}

- (void)selectIndex:(NSInteger)index {
    for (UIButton *button in self.buttons) {
        if (button.tag == index) { button.selected = YES; }
        else { button.selected = NO; }
    }
}

+ (UIView *)placeHolderView {
    UIView *placeHolder = [UIView new];
    [placeHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@64);
    }];
    return placeHolder;
}

#pragma - mark lazy load

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [UIStackView new];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.distribution = UIStackViewDistributionFillEqually;
    }
    return _stackView;
}

MDLazyInit(UIView, lineView, _lineView.backgroundColor = [UIColor grayColor];)

@end
