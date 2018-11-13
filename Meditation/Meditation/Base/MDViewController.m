//
//  MDViewController.m
//  Meditation
//
//  Created by mke Qi on 2018/11/5.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "MDViewController.h"
#import "MDTabBarView.h"

@interface MDViewController ()

@property (nonatomic, strong) UIStackView *baseStackView;

@end

@implementation MDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.baseStackView];
    [self.baseStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.baseStackView addArrangedSubview:MDNavigationBar.placeHolderView];
    [self.baseStackView addArrangedSubview:self.contentView];
    [self.view addSubview:self.navigationBar];
    [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
    }];
    if (self.tabBarController) {
        [self.baseStackView addArrangedSubview:MDTabBarView.placeHolderView];
    }
    
    /*Call Template Method*/
    
    [self setupUI];
    [self setupConstraints];
    [self setupBinding];

    [self controllerDidReady];
}

#pragma mark - Template Method

- (void)setupUI {}
- (void)setupConstraints {}
- (void)setupBinding {}

- (void)controllerDidReady {}

#pragma mark - Public Method

- (void)setTitle:(NSString *)title {
    self.navigationBar.title = title;
}

#pragma - mark lazy load

MDLazyInit(UIView, contentView)
MDLazyInit(UIStackView, baseStackView,
           _baseStackView.axis = UILayoutConstraintAxisVertical;
)
MDLazyInit(MDNavigationBar, navigationBar)

@end
