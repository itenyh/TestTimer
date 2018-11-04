//
//  ViewController.m
//  Meditation
//
//  Created by itenyh on 2018/11/3.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "ViewController.h"

#import <JPSVolumeButtonHandler/JPSVolumeButtonHandler.h>
#import <MZTimerLabel/MZTimerLabel.h>
#import <Masonry/Masonry.h>

static int playRepeatTime = 4;

@interface ViewController () <MZTimerLabelDelegate>

@property (nonatomic, strong) UILabel *distractionLabel;

@property (nonatomic, assign) BOOL isMeditation;
@property (nonatomic, assign) NSUInteger distractionCount;

@property (nonatomic, strong) JPSVolumeButtonHandler *volumeButtonHandler;
@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) MZTimerLabel *countDownTimer;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UIButton *actionButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.volumeButtonHandler = [JPSVolumeButtonHandler volumeButtonHandlerWithUpBlock:^{
        if (self.isMeditation)
        self.distractionCount++;
    } downBlock:^{
        if (self.isMeditation)
        self.distractionCount++;
    }];
    [self.volumeButtonHandler startHandler:YES];
    
    [self setupView];
    
    [self valueChange:self.slider];
    
    
    
}

#pragma ()
- (void)setupView {
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@150);
    }];
    
    [self.view addSubview:self.distractionLabel];
    [self.distractionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-80);
    }];
    
    [self.view addSubview:self.stackView];
    [self.stackView addArrangedSubview:self.timerLabel];
    [self.stackView addArrangedSubview:self.slider];
    [self.stackView addArrangedSubview:self.actionButton];
    
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-100);
        make.centerX.equalTo(self.view);
    }];
}

#pragma )(
- (void)meditationAction:(UIButton *)sender {
    self.isMeditation = !self.isMeditation;
}

#pragma )(
- (void)valueChange:(UISlider *)sender {
    [self.countDownTimer setCountDownTime:(int)sender.value * 60];
}

#pragma - mark Value Binding

- (void)setDistractionCount:(NSUInteger)distractionCount {
    _distractionCount = distractionCount;
    self.distractionLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)distractionCount];
}

- (void)setIsMeditation:(BOOL)isMeditation {
    _isMeditation = isMeditation;
    self.actionButton.selected = isMeditation;
    self.slider.enabled = !isMeditation;
    if (isMeditation) {
        
        //屏幕常亮
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        
        self.distractionCount = 0;
        [self.countDownTimer start];
    }
    else {
        
        
        //屏幕常亮
        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
        
        [self.countDownTimer pause];
        [self.countDownTimer reset];
    }
}

#pragma - mark MZTimerLabelDelegate

- (void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime {
    self.isMeditation = NO;
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

#pragma - mark lazy load
#pragma ()
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
        [_slider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton new];
        [_actionButton setTitle:@"开始" forState:UIControlStateNormal];
        [_actionButton setTitle:@"结束" forState:UIControlStateSelected];
        [_actionButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_actionButton addTarget:self action:@selector(meditationAction:) forControlEvents:UIControlEventTouchUpInside];
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

@end
