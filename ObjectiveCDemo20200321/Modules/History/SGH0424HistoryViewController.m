//
//  SGH0424HistoryViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/24.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGH0424HistoryViewController.h"

@interface SGH0424HistoryViewController ()

@end

@implementation SGH0424HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeNewVC;
    
    NSArray *tempTitleArray = @[
        @"1.iOS检测内存泄漏的方法 \n请结合文章《iOS检测内存泄漏的方法》操作来看，效果更好",
        @"2.iOS中高级特训营--系列代码",
        
    ];
    NSArray *tempClassNameArray = @[
        @"SGHCyclesMemoryLeaksVC",
        @"SGHAdvancedTrainingCampListDemoViewController",
        
    ];
    
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"APM 系列"];
    
    [self.tableView reloadData];
}


@end
