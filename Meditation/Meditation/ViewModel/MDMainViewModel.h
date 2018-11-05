//
//  MDMainViewModel.h
//  Meditation
//
//  Created by mke Qi on 2018/11/5.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "MDViewModel.h"

@interface MDMainViewModel : MDViewModel

@property (nonatomic, assign) BOOL isMeditation;
@property (nonatomic, assign) NSUInteger distractionCount;
@property (nonatomic, assign) NSUInteger seconds;

- (void)addDistraction;

@end
