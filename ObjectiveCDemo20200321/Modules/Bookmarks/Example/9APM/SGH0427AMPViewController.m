//
//  SGH0427AMPViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/27.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGH0427AMPViewController.h"

@interface SGH0427AMPViewController ()

@end

@implementation SGH0427AMPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = SHBaseTableTypeNewVC;
    
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"1.使用FBRetainCycleDetector检测引用循环",
    ];
    NSArray *tempClassNameArray = @[
        @"SGHFBRetainCycleViewController",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"NSOperation&NSOperationQueue"];
    
    [self.tableView reloadData];
}


@end
