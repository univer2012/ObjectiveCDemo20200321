//
//  SGHDataStructAlgorithmsViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/29.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 来自：《数据结构(C++版)(第2版)》王红梅/胡明/王涛 编著--源代码
 */


#import "SGHDataStructAlgorithmsViewController.h"


@interface SGHDataStructAlgorithmsViewController ()

@end

@implementation SGHDataStructAlgorithmsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = SHBaseTableTypeMethod;
    
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"1.链表",
    ];
    NSArray *tempClassNameArray = @[
        @"chap2demo1",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"第2章"];
    
    [self.tableView reloadData];
}

//MARK: 第2章
//MARK: 1.链表
- (void)chap2demo1 {
    
}


@end
