//
//  SGHCyclesMemoryLeaksVC.m
//  
//
//  Created by Mac on 2020/4/24.
//
/*
 * 来自：[iOS检测内存泄漏的方法](https://blog.csdn.net/yst19910702/article/details/81199478)
 */
#import "SGHCyclesMemoryLeaksVC.h"

@interface SGHCyclesMemoryLeaksVC ()

@end

@implementation SGHCyclesMemoryLeaksVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeNewVC;
    
    NSArray *tempTitleArray = @[
        @"1.引用循环",
        @"2.悬挂指针",
        @"3.Block内存泄漏",
        @"4.静态分析",
    ];
    NSArray *tempClassNameArray = @[
        @"SGHReferenceCycleViewController",
        @"SGHNameListViewController",
        @"SGHBlockLeakViewController",
        @"SGHStaticAnalysisViewController",
    ];
    
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:self.title];
    
    [self.tableView reloadData];
}


@end
