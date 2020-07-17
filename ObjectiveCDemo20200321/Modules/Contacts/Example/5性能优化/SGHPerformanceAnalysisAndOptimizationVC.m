//
//  SGHPerformanceAnalysisAndOptimizationVC.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/24.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHPerformanceAnalysisAndOptimizationVC.h"

@interface SGHPerformanceAnalysisAndOptimizationVC ()

@end

@implementation SGHPerformanceAnalysisAndOptimizationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = SHBaseTableTypeMethod;
    
    NSArray *tempTitleArray = @[
        @"例子1：有cornerRadius，没有clipsToBounds",
        @"例子2：有cornerRadius，有clipsToBounds",
        @"例子3：有cornerRadius，有clipsToBounds，layer.contents上加图片",
        @"例子4：有cornerRadius，有clipsToBounds，加了子view",
        @"例子5：有cornerRadius，有clipsToBounds，没有子view，没有设置背景色、边框",
        @"例子6：为UIButton设置一个图片，其实会添加一个UIImageView。UIButton切圆角，有离屏渲染",
        @"例子7：UIButton切圆角，应该这样避免离屏渲染",
    ];
    NSArray *tempClassNameArray = @[
        @"sec1demo1",
        @"sec1demo2",
        @"sec1demo3",
        @"sec1demo4",
        @"sec1demo5",
        @"sec1demo6",
        @"sec1demo7",
    ];
    
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"1.iOS圆角的离屏渲染，你真的弄明白了吗"];
    
    [self.tableView reloadData];
}

- (void)sec1demo7 {
    [self pushToNewVCWith:@"SGHOffScreenRender_CornerRadiusVC" title:@"" inBookmarkStoryboard:NO selText:@"demo7"];
}

- (void)sec1demo6 {
    [self pushToNewVCWith:@"SGHOffScreenRender_CornerRadiusVC" title:@"" inBookmarkStoryboard:NO selText:@"demo6"];
}

- (void)sec1demo5 {
    [self pushToNewVCWith:@"SGHOffScreenRender_CornerRadiusVC" title:@"" inBookmarkStoryboard:NO selText:@"demo5"];
}

- (void)sec1demo4 {
    [self pushToNewVCWith:@"SGHOffScreenRender_CornerRadiusVC" title:@"" inBookmarkStoryboard:NO selText:@"demo4"];
}

- (void)sec1demo3 {
    [self pushToNewVCWith:@"SGHOffScreenRender_CornerRadiusVC" title:@"" inBookmarkStoryboard:NO selText:@"demo3"];
}

- (void)sec1demo2 {
    [self pushToNewVCWith:@"SGHOffScreenRender_CornerRadiusVC" title:@"" inBookmarkStoryboard:NO selText:@"demo2"];
}

- (void)sec1demo1 {
    [self pushToNewVCWith:@"SGHOffScreenRender_CornerRadiusVC" title:@"" inBookmarkStoryboard:NO selText:@"demo1"];
}


@end
