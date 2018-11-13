//
//  MDCommonMacro.h
//  Meditation
//
//  Created by Iten on 2018/11/13.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#ifndef MDCommonMacro_h
#define MDCommonMacro_h

/**
 替代烦人的懒加载
 
 @param aClass Class
 @param instance Instance Name
 */
#define MDLazyInit(aClass, instance, ...)    \
-(aClass *)instance {               \
void (^TestBlock)(void) = ^void() {\
__VA_ARGS__ \
};                                              \
if (!_##instance) {             \
_##instance = [aClass new]; \
TestBlock();                       \
}                               \
return _##instance;             \
};

#endif /* MDCommonMacro_h */
