//
//  MDCalendarViewModel.h
//  Meditation
//
//  Created by Iten on 2018/11/13.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "MDViewModel.h"

@interface MDCalendarViewModel : MDViewModel

@property (nonatomic, copy) NSArray *meditaionDates;

- (BOOL)meditationedOnDate:(NSDate *)date;

@end
