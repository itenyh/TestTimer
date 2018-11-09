//
//  MDMainViewModel.h
//  Meditation
//
//  Created by mke Qi on 2018/11/5.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "MDViewModel.h"

#import "MDMeditationModel.h"

@interface MDMainViewModel : MDViewModel

@property (nonatomic, strong) MDMeditationModel *meditationModel;

@property (nonatomic, assign) BOOL isMeditation;
@property (nonatomic, assign) NSInteger distractionCount;
@property (nonatomic, assign) NSInteger seconds;

- (void)addDistraction;
- (void)startMeditation;
- (void)stopMeditationFinish:(BOOL)finish;

@end
