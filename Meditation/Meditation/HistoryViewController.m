//
//  HistoryViewController.m
//  Meditation
//
//  Created by mke Qi on 2018/11/5.
//  Copyright © 2018年 itenyh. All rights reserved.
//

#import "HistoryViewController.h"

#import "AAChartKit.h"

@interface HistoryViewController ()

@property (nonatomic, strong) AAChartView *aaChartView;

//关于X轴
@property (nonatomic, copy) NSArray *categories;

//关于数据区域
@property (nonatomic, copy) NSArray *datas;

@property (nonatomic, assign) CGFloat contentWidth;                       //图表内容宽度
@property (nonatomic, assign) CGFloat contentHeight;                      //图表内容高度


@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.datas = @[@[@1, @2, @3]];
    self.categories = @[@"1", @"5", @"8"];
    [self reload];
    
}

- (void)setupUI {
    [self.view addSubview:self.aaChartView];
}

- (void)setupConstraints {
    [self.aaChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)reload {
    AAOptions *aaOptions = [AAOptions new];
    [self configueCharType:aaOptions];
    [self configueXAxis:aaOptions];
    [self configueYAxis:aaOptions];
    [self configueSeries:aaOptions];
    [self configueOthers:aaOptions];
//    self.aaChartView.contentHeight = self.contentHeight ? self.contentHeight : CGRectGetHeight(self.view.frame);
//    self.aaChartView.contentWidth = self.contentWidth ? self.contentWidth : CGRectGetWidth(self.view.frame);
//
//    self.aaChartView.scrollEnabled = self.contentWidth > CGRectGetWidth(self.view.frame);
    
    [self.aaChartView aa_drawChartWithOptions:aaOptions];
}

#pragma mark - private methods

- (void)configueCharType:(AAOptions *)aaOptions {
    AAChart *chart = [AAChart new];
    chart.typeSet(AAChartTypeLine);
    aaOptions.chartSet(chart);
}

- (void)configueXAxis:(AAOptions *)aaOptions {
    AAXAxis *xAxis = [AAXAxis new];
    xAxis.visibleSet(YES);
    xAxis.tickColorSet(@"#ffffff");
    xAxis.gridLineWidthSet(@0.5);
    xAxis.gridLineColorSet(@"#eeeeee");
    
    AALabels *labels = [AALabels new];
    labels.enabledSet(YES);
    AAStyle *style = [AAStyle new];
    labels.styleSet(style);
    xAxis.categoriesSet(self.categories);
    aaOptions.xAxisSet(xAxis);
}

- (void)configueYAxis:(AAOptions *)aaOptions {
    AAYAxis *yAxis = [AAYAxis new];
    yAxis.visibleSet(YES);
    yAxis.lineWidthSet(@0);
    AATitle *title = [AATitle new];
    title.textSet(@"");
    yAxis.titleSet(title);
    aaOptions.yAxisSet(yAxis);
}

- (void)configueSeries:(AAOptions *)aaOptions {
    
    NSMutableArray *seriesElements = [NSMutableArray array];
    [self.datas enumerateObjectsUsingBlock:^(NSArray *subData, NSUInteger idx, BOOL * _Nonnull stop) {
        AASeriesElement *ele = [AASeriesElement new];
        ele.allowPointSelectSet(NO);  //指单个点的选中，可以不打开
        ele.borderWidthSet(@0);
        AAMarker *aaMarker = [AAMarker new];
        aaMarker.radiusSet(@2.5)//曲线连接点半径，默认是4
        .symbolSet(@"circle");//曲线点类型："circle", "square", "diamond", "triangle","triangle-down"，默认是"circle"
        ele.markerSet(aaMarker);
        ele.dataSet(subData);
        [seriesElements addObject:ele];
    }];
    aaOptions.seriesSet(seriesElements);
    
}

- (void)configueOthers:(AAOptions *)aaOptions {
    AATitle *title = [AATitle new];
    title.textSet(self.title);
    aaOptions.titleSet(title);
    
    AALegend *aaLegend = [AALegend new];
    aaLegend.enabledSet(NO);//是否显示 legend
    aaOptions.legendSet(aaLegend);
    
    AATooltip *aaTooltip = [AATooltip new];
    aaTooltip.enabledSet(YES);//启用浮动提示框
    aaTooltip.sharedSet(YES);//多组数据共享一个浮动提示框
    aaTooltip.crosshairsSet(NO);//启用准星线
    aaOptions.tooltipSet(aaTooltip);
}

#pragma mark - chart delegate

- (void)AAChartViewDidFinishLoad {
//    UIWebView *chartWebView = self.aaChartView.subviews[0];
//    UIScrollView *scrollView = chartWebView.scrollView;
//    //    scrollView.delegate = self;
//    //delay设置，直接设置真机不生效
//    [self performSelector:@selector(delayAdjustChartScrollViewOffset:) withObject:scrollView afterDelay:0.1];
}

#pragma mark - private method

- (void)delayAdjustChartScrollViewOffset:(UIScrollView *)scrollView {
//    scrollView.contentOffset = CGPointMake(0, self.chartVerticalOffset);
}


#pragma mark - lazy load

- (AAChartView *)aaChartView {
    if (!_aaChartView) {
        _aaChartView = [AAChartView new];
        _aaChartView.delegate = self;
        _aaChartView.isClearBackgroundColor = YES;
        self.aaChartView.subviews[0].backgroundColor = [UIColor clearColor];
    }
    return _aaChartView;
}

@end
