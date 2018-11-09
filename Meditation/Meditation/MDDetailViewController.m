//
//  MDDetailViewController.m
//  Meditation
//
//  Created by Iten on 2018/11/9.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "MDDetailViewController.h"

@interface MDDetailViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *scrollViewContentView;

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *sureButton;

@end

@implementation MDDetailViewController

- (void)setupUI {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.scrollViewContentView];
    [self.scrollViewContentView addSubview:self.contentLabel];
    [self.scrollViewContentView addSubview:self.sureButton];
}

- (void)setupConstraints {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.scrollViewContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.scrollViewContentView);
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(20);
        make.bottom.equalTo(self.scrollViewContentView).offset(-5);
        make.centerX.equalTo(self.scrollViewContentView);
    }];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
    }
    return _scrollView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.text = @"     Meditation is a practice where an individual uses a technique, such as focusing their mind on a particular object, thought or activity, to achieve a mentally clear and emotionally calm state.[1] ] \n\n       Meditation has been practiced since antiquity in numerous religious traditions and beliefs. Since the 19th century, it has spread from its origins to other cultures where it is commonly practiced in private and business life. \n\n      Meditation may be used with the aim of reducing stress, anxiety, depression, and pain, and increasing peace, perception,[2] self-concept, and well-being.[3][4][5][6] Meditation is under research to define its possible health (psychological, neurological, and cardiovascular) and other effects.";
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIView *)scrollViewContentView {
    if (!_scrollViewContentView) {
        _scrollViewContentView = [UIView new];
    }
    return _scrollViewContentView;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton new];
        [_sureButton setTitle:@"阅读完毕" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _sureButton;
}

@end
