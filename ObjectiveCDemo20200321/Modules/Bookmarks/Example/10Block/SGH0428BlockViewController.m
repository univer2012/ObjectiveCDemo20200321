//
//  SGH0428BlockViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/28.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGH0428BlockViewController.h"

@interface SGH0428BlockViewController ()

@end

@implementation SGH0428BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeNewVC;
    
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"1.MRC模式下，Block作为属性，是否使用copy修饰的区别",
        @"2.ARC模式下，Block的情况探究",
    ];
    NSArray *tempClassNameArray = @[
        @"SGHMRCBlockViewController",
        @"SGHARCBlockViewController",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"NSOperation&NSOperationQueue"];
    
    [self.tableView reloadData];
}


@end
