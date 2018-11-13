//
//  ViewController.m
//  Meditation
//
//  Created by itenyh on 2018/11/3.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "MainViewController.h"
#import "MDCalendarViewController.h"

#import "MDMainViewModel.h"

#import <JPSVolumeButtonHandler/JPSVolumeButtonHandler.h>
#import <MZTimerLabel/MZTimerLabel.h>

static int playRepeatTime = 4;

@interface MainViewController () <MZTimerLabelDelegate>

@property (nonatomic, strong) UILabel *distractionLabel;
@property (nonatomic, strong) JPSVolumeButtonHandler *volumeButtonHandler;
@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) MZTimerLabel *countDownTimer;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UIButton *actionButton;

@property (nonatomic, strong) UIButton *calendar;

@property (nonatomic, strong) MDMainViewModel *viewModel;

@end

@implementation MainViewController

- (void)setupUI {
    
    [self.contentView addSubview:self.distractionLabel];
    [self.contentView addSubview:self.stackView];
    [self.stackView addArrangedSubview:self.timerLabel];
    [self.stackView addArrangedSubview:self.slider];
    [self.stackView addArrangedSubview:self.actionButton];
    
    [self.navigationBar addRightNavItem:self.calendar];
    self.title = @"主页";
}

- (void)setupConstraints {
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@150);
    }];
    
    [self.distractionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView).offset(-80);
    }];
    
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-100);
        make.centerX.equalTo(self.contentView);
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
        self.slider.enabled = !self.viewModel.isMeditation;
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
    
    //分散次数
    [RACObserve(self.viewModel, distractionCount) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.distractionLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.viewModel.distractionCount];
    }];
    
    //时间
    [RACObserve(self.viewModel, seconds) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.countDownTimer setCountDownTime:self.viewModel.seconds];
    }];
    
    //滑动杆值
    [[self.slider rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(__kindof UIControl * _Nullable x) {
         self.viewModel.seconds = (int)self.slider.value * 60;
    }];
    
    //分散事件
    self.volumeButtonHandler = [JPSVolumeButtonHandler volumeButtonHandlerWithUpBlock:^{
        if (self.viewModel.isMeditation)
            [self.viewModel addDistraction];
    } downBlock:^{
        if (self.viewModel.isMeditation)
            [self.viewModel addDistraction];
    }];
    [self.volumeButtonHandler startHandler:YES];
    
}

#pragma - mark MZTimerLabelDelegate

- (void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime {
    [self.viewModel stopMeditationFinish:YES];
    playAudio();
}

void playAudio() {
    
    if (playRepeatTime > 0) {
        playRepeatTime--;
        NSURL *audioPath = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"clock" ofType:@"wav"]];
        SystemSoundID soundId;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)audioPath, &soundId);
        AudioServicesAddSystemSoundCompletion(soundId,NULL, NULL, soundCompleteCallback, NULL);
        AudioServicesPlayAlertSound(soundId);
    }
    else {
        playRepeatTime = 0;
    }
}

void soundCompleteCallback(SystemSoundID soundID, void *clientData) {
    playAudio();
}

#pragma - mark Action

- (void)calendarAction {
    [self.navigationController pushViewController:[MDCalendarViewController new] animated:YES];
}

#pragma - mark lazy load

- (UILabel *)distractionLabel {
    if (!_distractionLabel) {
        _distractionLabel = [UILabel new];
        _distractionLabel.textColor = [UIColor lightGrayColor];
        _distractionLabel.textAlignment = NSTextAlignmentCenter;
        _distractionLabel.font = [UIFont boldSystemFontOfSize:85];
        _distractionLabel.text = @"0";
    }
    return _distractionLabel;
}

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

- (UISlider *)slider {
    if (!_slider) {
        _slider = [UISlider new];
        _slider.maximumValue = 60;
        _slider.minimumValue = 1;
        _slider.value = 15;
    }
    return _slider;
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
    }
    return _viewModel;
}

- (UIButton *)calendar {
    if (!_calendar) {
        _calendar = [UIButton new];
        [_calendar setImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
        [_calendar addTarget:self action:@selector(calendarAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _calendar;
}

@end
