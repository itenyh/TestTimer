//
//  MDViewModel.h
//  Meditation
//
//  Created by mke Qi on 2018/11/5.
//  Copyright © 2018年 itenyh. All rights reserved.
//

typedef NS_ENUM(NSUInteger, MDViewModelDataState) {
    MDViewModelDataUnReady,
    MDViewModelDataReady,
    MDViewModelDataFail
};

#import <Foundation/Foundation.h>

@interface MDViewModel : NSObject

@property (nonatomic, assign) MDViewModelDataState dataState;

- (void)setupViewModel;

@end
