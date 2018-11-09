//
//  MDMainViewModel.m
//  Meditation
//
//  Created by mke Qi on 2018/11/5.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "MDMainViewModel.h"

#import <Realm/Realm.h>
#import "MDDistractionModel.h"

@implementation MDMainViewModel

- (void)setupViewModel {
    self.seconds = 15 * 60;
}

#pragma - mark Public Method

- (void)addDistraction {
    self.distractionCount++;
    
    [self.meditationModel.distractions addObject:[MDDistractionModel new]];
}

- (void)startMeditation {
    self.isMeditation = YES;
    
    self.meditationModel = [MDMeditationModel new];
    self.meditationModel.seconds = self.seconds;
    self.meditationModel.startDate = [NSDate new];
}

- (void)stopMeditationFinish:(BOOL)finish {
    self.isMeditation = NO;
    
    self.meditationModel.finish = finish;
    self.meditationModel.endDate = [NSDate new];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:self.meditationModel];
    }];
}

@end
