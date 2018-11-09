//
//  StageOneViewController.m
//  Meditation
//
//  Created by Iten on 2018/11/9.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "StageOneViewController.h"
#import <MZTimerLabel/MZTimerLabel.h>

#import "MDMainViewModel.h"

@interface StageOneViewController () <MZTimerLabelDelegate>

@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) MZTimerLabel *countDownTimer;
@property (nonatomic, strong) UIButton *actionButton;

@property (nonatomic, strong) MDMainViewModel *viewModel;

@end

@implementation StageOneViewController


- (void)setupUI {
    
    [self.view addSubview:self.stackView];
    [self.stackView addArrangedSubview:self.timerLabel];
    [self.stackView addArrangedSubview:self.actionButton];
    
}

- (void)setupConstraints {
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@150);
    }];
    
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

#pragma )(
- (void)setupBinding {
    @weakify(self)
    
    //开始按钮
    [[self.actionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (self.viewModel.isMeditation) {
            [self.viewModel stopMeditationFinish:NO];
        }
        else {
            [self.viewModel startMeditation];
        }
    }];
    
    //是否在启动状态
    [RACObserve(self.viewModel, isMeditation) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.actionButton.selected = self.viewModel.isMeditation;
        if (self.viewModel.isMeditation) {
            //屏幕常亮
            [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
            self.viewModel.distractionCount = 0;
            [self.countDownTimer start];
        }
        else {
            //屏幕常亮
            [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
            
            [self.countDownTimer pause];
            [self.countDownTimer reset];
        }
    }];
    
    [RACObserve(self.viewModel, seconds) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.countDownTimer setCountDownTime:self.viewModel.seconds];
    }];
    
    
}


#pragma - mark lazy load

- (UILabel *)timerLabel {
    if (!_timerLabel) {
        _timerLabel = [UILabel new];
        _timerLabel.textColor = [UIColor blackColor];
        _timerLabel.textAlignment = NSTextAlignmentCenter;
        _timerLabel.font = [UIFont systemFontOfSize:20];
        _timerLabel.text = @"00:00:00";
    }
    return _timerLabel;
}

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [UIStackView new];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.spacing = 15;
    }
    return _stackView;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton new];
        [_actionButton setTitle:@"开始" forState:UIControlStateNormal];
        [_actionButton setTitle:@"结束" forState:UIControlStateSelected];
        [_actionButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    return _actionButton;
}

- (MZTimerLabel *)countDownTimer {
    if (!_countDownTimer) {
        _countDownTimer = [[MZTimerLabel alloc] initWithLabel:self.timerLabel andTimerType:MZTimerLabelTypeTimer];
        _countDownTimer.delegate = self;
    }
    return _countDownTimer;
}

- (MDMainViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [MDMainViewModel new];
        _viewModel.seconds = 3 * 60;
    }
    return _viewModel;
}

@end
