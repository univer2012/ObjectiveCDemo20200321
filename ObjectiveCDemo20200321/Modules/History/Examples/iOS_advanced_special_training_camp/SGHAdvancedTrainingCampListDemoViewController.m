//
//  SGHAdvancedTrainingCampListDemoViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/25.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHAdvancedTrainingCampListDemoViewController.h"

@interface SGHAdvancedTrainingCampListDemoViewController ()

@end

@implementation SGHAdvancedTrainingCampListDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = SHBaseTableTypeNewVC;
    
    NSArray *tempTitleArray = @[
        @"2.Runtime方法交换，交换UITableView的reloadData方法",
        @"4.Runtime自定义KVO",
        @"5.iOS开发之循环引用",
        @"6.iOS开发之NSTimer",
        @"8.iOS开发之内存检测工具",
        @"12、13.iOS组件通讯原理 -CTMediator的使用",
    ];
    NSArray *tempClassNameArray = @[
        @"SGHMethodExchangeImpViewController",
        @"SGHCustomKVOViewController",
        @"SGH0425LeaksViewController",
        @"SGH0425Leaks6ViewController",
        @"SGHAOPLeakFinderViewController",
        @"SGH_CTMediatorViewController",
    ];
    
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"开发"];
    
    [self.tableView reloadData];
}


@end
