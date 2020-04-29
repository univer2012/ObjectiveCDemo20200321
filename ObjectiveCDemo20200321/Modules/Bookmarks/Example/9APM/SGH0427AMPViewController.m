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
        @"2.探究NSString作为属性时要用copy修饰-MRC",
        @"3.使用`copy`方法时，什么时候是浅拷贝什么时候是深拷贝",
        @"4.栈内存和堆内存的比较",
    ];
    NSArray *tempClassNameArray = @[
        @"SGHFBRetainCycleViewController",
        @"SGH0428StringViewController",
        @"SGH0428CopyViewController",
        @"SGHStackMallocViewController",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"NSOperation&NSOperationQueue"];
    
    [self.tableView reloadData];
}


@end
