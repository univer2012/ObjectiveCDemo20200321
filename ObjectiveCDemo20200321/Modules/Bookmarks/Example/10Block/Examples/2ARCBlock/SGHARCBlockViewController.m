//
//  SGHARCBlockViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/8.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHARCBlockViewController.h"

@interface SGHARCBlockViewController ()

@end

@implementation SGHARCBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeMethod;
    
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"1.在ARC下打印出 NSStackBlock",

    ];
    NSArray *tempClassNameArray = @[
        @"demo1",

    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"ARC模式下的 block"];
    
    [self.tableView reloadData];
}

//MARK: 1.在ARC下打印出 NSStackBlock
- (void)demo1 {
    
    int a = 1;
    void (^blcok1)(void) = ^{
        NSLog(@"abcd %d",a);
    };
    NSLog(@"NSMallocBlock: %@",blcok1);
    
    NSLog(@"NSStackBlock: %@",^{
        NSLog(@"%d",a);
    });
}

@end
