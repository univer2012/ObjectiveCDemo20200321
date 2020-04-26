//
//  SGHMultithreadProgramViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHMultithreadProgramViewController.h"

@interface SGHMultithreadProgramViewController ()

@end

@implementation SGHMultithreadProgramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeNewVC;
    
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"1.多线程NSOperation的示例",
        @"2.NSOperationQueue 的使用",
    ];
    NSArray *tempClassNameArray = @[
        @"SGHAboutNSOperationViewController",
        @"SGH0426OperationQueueDemoViewController",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"NSOperation&NSOperationQueue"];
    
    
    //MARK: section 2
    NSArray *tempTitleArray2 = @[
        @"1.GCD的使用",
    ];
    NSArray *tempClassNameArray2 = @[
        @"SGH0426GCDViewController",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray2 titleArray:tempTitleArray2 title:@"GCD"];
    
    //MARK: section 3
    NSArray *tempTitleArray3 = @[
        @"1.线程的创建和使用实例：模拟售票",
    ];
    NSArray *tempClassNameArray3 = @[
        @"SGH0409ThreadViewController",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray3 titleArray:tempTitleArray3 title:@"NSThread"];
    
    //MARK: section 4
    NSArray *tempTitleArray4 = @[
    ];
    NSArray *tempClassNameArray4 = @[
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray4 titleArray:tempTitleArray4 title:@"pthread"];
    
    //MARK: section 5
    NSArray *tempTitleArray5 = @[
        @"1.切回到主线程的N种方式",
        @"2.iOS 十种线程锁",
    ];
    NSArray *tempClassNameArray5 = @[
        @"SGHGoBackMainThreadViewController",
        @"SGHTenThreadLocksViewController",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray5 titleArray:tempTitleArray5 title:@"其他issue"];
    
    [self.tableView reloadData];
    
    
    self.inStoryboardVCArray = @[
        @"SGHAboutNSOperationViewController",
    ];
}



@end
