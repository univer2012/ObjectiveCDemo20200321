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
        @"5.iOS开发之循环引用",
        @"6.iOS开发之NSTimer",
        @"8.iOS开发之内存检测工具",
    ];
    NSArray *tempClassNameArray = @[
        @"SGH0425LeaksViewController",
        @"SGH0425Leaks6ViewController",
        @"SGHAOPLeakFinderViewController",
    ];
    
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"开发"];
    
    [self.tableView reloadData];
}


@end
