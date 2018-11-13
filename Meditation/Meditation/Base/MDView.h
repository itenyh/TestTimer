//
//  MDView.h
//  Meditation
//
//  Created by Iten on 2018/11/13.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDView : UIView

- (void)setupUI;
- (void)setupConstraints;
- (void)setupBinding;

- (void)viewWillReady;
- (void)viewDidReady;

@end
