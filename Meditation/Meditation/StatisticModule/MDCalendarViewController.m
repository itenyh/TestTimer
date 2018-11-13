//
//  MDCalendarViewController.m
//  Meditation
//
//  Created by Iten on 2018/11/13.
//  Copyright © 2018年 itenyh. All rights reserved.
//


#import "MDCalendarViewController.h"

#import "MDCalendarViewModel.h"

#import "MDCalendarCell.h"

#import <FSCalendar.h>

@interface MDCalendarViewController () <FSCalendarDelegate, FSCalendarDataSource>

@property (nonatomic, strong) FSCalendar *calendar;
@property (nonatomic, strong) MDCalendarViewModel *viewModel;

@end

@implementation MDCalendarViewController

- (void)setupUI {
    [self.view addSubview:self.calendar];
}

- (void)setupConstraints {
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setupBinding {
    [RACObserve(self.viewModel, dataState) subscribeNext:^(id  _Nullable x) {
        if (self.viewModel.dataState == MDViewModelDataReady) {
            [self.calendar reloadData];
        }
    }];
}

- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position {
    MDCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:MDCalendarCell.description forDate:date atMonthPosition:position];
    cell.meditationed = [self.viewModel meditationedOnDate:date];
    return cell;
}

//- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
//{
//    self.calendarHeightConstraint.constant = CGRectGetHeight(bounds);
//    // Do other updates here
//    [self.view layoutIfNeeded];
//}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return [NSDate new];
}

- (FSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [FSCalendar new];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        _calendar.backgroundColor = [UIColor whiteColor];
        _calendar.allowsMultipleSelection = YES;
        _calendar.today = nil;
        [_calendar registerClass:MDCalendarCell.class forCellReuseIdentifier:MDCalendarCell.description];
    }
    return _calendar;
}


- (MDCalendarViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [MDCalendarViewModel new];
    }
    return _viewModel;
}

@end
