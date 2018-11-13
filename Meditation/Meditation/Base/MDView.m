//
//  MDView.m
//  Meditation
//
//  Created by Iten on 2018/11/13.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "MDView.h"

@implementation MDView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self viewWillReady];
        
        [self setupUI];
        [self setupConstraints];
        [self setupBinding];
        
        [self viewDidReady];
    }
    return self;
}

- (void)setupUI {}
- (void)setupConstraints {}
- (void)setupBinding {}

- (void)viewWillReady {}
- (void)viewDidReady {}

@end
