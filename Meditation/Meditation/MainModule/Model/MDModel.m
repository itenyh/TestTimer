//
//  MDObject.m
//  Meditation
//
//  Created by mke Qi on 2018/11/5.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "MDModel.h"

@implementation MDModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Any Init Here......
    }
    return self;
}

+ (NSDictionary *)defaultPropertyValues {
    return @{@"createDate" : [NSDate new]};
}

@end
