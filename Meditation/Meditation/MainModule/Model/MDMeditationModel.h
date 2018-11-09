//
//  MDMeditationModel.h
//  Meditation
//
//  Created by mke Qi on 2018/11/5.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MDModel.h"
#import "MDDistractionModel.h"

@interface MDMeditationModel : MDModel

@property (nonatomic, assign) NSInteger seconds;
@property RLMArray<MDDistractionModel *><MDDistractionModel> *distractions;
@property (nonatomic, assign) BOOL finish;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@end
