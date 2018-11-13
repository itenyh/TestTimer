//
//  MDCalendarCell.m
//  Meditation
//
//  Created by Iten on 2018/11/13.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "MDCalendarCell.h"

@interface MDCalendarCell ()

@property (nonatomic, strong) UIView *meditationIcon;

@end

@implementation MDCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel addSubview:self.meditationIcon];
        [self.meditationIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.titleLabel);
            make.width.height.equalTo(@30);
        }];
    }
    return self;
}


- (UIView *)meditationIcon {
    if (!_meditationIcon) {
        _meditationIcon = [UIView new];
        _meditationIcon.layer.borderWidth = 1.5;
        _meditationIcon.layer.borderColor = [UIColor orangeColor].CGColor;
        _meditationIcon.layer.cornerRadius = 15;
        _meditationIcon.backgroundColor = [UIColor clearColor];
        _meditationIcon.hidden = YES;
    }
    return _meditationIcon;
}

- (void)setMeditationed:(BOOL)meditationed {
    _meditationed = meditationed;
    self.meditationIcon.hidden = !meditationed;
}

@end
