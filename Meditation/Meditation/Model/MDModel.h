//
//  MDObject.h
//  Meditation
//
//  Created by mke Qi on 2018/11/5.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import <Realm/Realm.h>

#import <Foundation/Foundation.h>

@interface MDModel : RLMObject

@property (nonatomic, strong) NSDate *createDate;

@end
