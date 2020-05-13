//
//  SGHSocketListViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/25.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHSocketListViewController.h"

@interface SGHSocketListViewController ()

@end

@implementation SGHSocketListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeNewVC;
    
    NSArray *tempTitleArray = @[
        @"1.iOS 用原生代码写一个简单的socket连接 - 客户端",
        @"socket通信，客户端",
        @"socket通信，服务端",
        @"3.iOS GCDAsyncSocket简单使用 - 客户端",
        @"4.Socket基本结构",
    ];
    NSArray *tempClassNameArray = @[
        @"SGHNativeSocketViewController",
        @"SGHSocketClientViewController",
        @"SGHSocketSeverViewController",
        @"SGHAsyncSocketClientViewController",
        @"SHSocketStruc0218ViewController",
    ];
    
    self.inStoryboardVCArray = @[
        @"SGHNativeSocketViewController",
        @"SGHSocketClientViewController",
        @"SGHSocketSeverViewController",
        @"SGHAsyncSocketClientViewController",
    ];
    
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"Socket"];
    
    [self.tableView reloadData];
    
}



@end
