//
//  MDCalendarViewModel.m
//  Meditation
//
//  Created by Iten on 2018/11/13.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "MDCalendarViewModel.h"

#import "MDMeditationModel.h"

@implementation MDCalendarViewModel

- (void)setupViewModel {
    RLMResults<MDMeditationModel *> *meditations = [MDMeditationModel allObjects];
    
    NSMutableArray *tempDates = [NSMutableArray array];
    for (MDMeditationModel *model in meditations) {
        [tempDates addObject:model.createDate];
    }
    
    self.meditaionDates = [tempDates copy];
    self.dataState = MDViewModelDataReady;
}

- (BOOL)meditationedOnDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *calendarDateStr = [dateFormatter stringFromDate:date];
    
    for (NSDate *mDate in self.meditaionDates) {
        NSString *mDateStr = [dateFormatter stringFromDate:mDate];
        if ([calendarDateStr isEqualToString:mDateStr]) {
            return YES;
        }
    }
    return NO;
}

@end
