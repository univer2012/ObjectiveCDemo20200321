//
//  SGH0425LeaksViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/25.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 来自：爱奇艺的 「iOS中高级特训营」的第5个视频「iOS开发之循环引用」
 */
#import "SGH0425LeaksViewController.h"

@interface SGH0425LeaksViewController ()

@property (nonatomic, copy) dispatch_block_t block;
@property (nonatomic, copy) NSString *str;

@end

@implementation SGH0425LeaksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeMethod;
    
    NSArray *tempTitleArray = @[
        @"1.两个对象的相互引用",
        @"2.block内使用self，导致的循环引用",
        @"2_2.block内使用self，导致的循环引用 - 的解决方案",
        @"3.block内有延时，导致退出后，延时内的外部引用变量值为null",
        @"3_2.block内有延时，导致退出后，延时内的外部引用变量值为null -- 的解决方案",
    ];
    NSArray *tempClassNameArray = @[
        @"demo1",
        @"demo2",
        @"demo2_2",
        @"demo3",
        @"demo3_2",
    ];
    
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:self.title];
    
    [self.tableView reloadData];
    
}

//MARK: 3_2.block内有延时，导致退出后，延时内的外部引用变量值为null -- 的解决方案
- (void)demo3_2 {
    __weak typeof(self) weakSelf = self;
    self.block = ^{
        weakSelf.str = @"hello";
        __strong typeof(self) strongSelf = weakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"---- %@",strongSelf.str);
        });
    };
    self.block();
}


//MARK: 3.block内有延时，导致退出后，延时内的外部引用变量值为null
- (void)demo3 {
    __weak typeof(self) weakSelf = self;
    self.block = ^{
        weakSelf.str = @"hello";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"---- %@",weakSelf.str);
        });
    };
    self.block();
}


//MARK: 2_2.block内使用self，导致的循环引用 - 的解决方案
- (void)demo2_2 {
    __weak typeof(self) weakSelf = self;
    self.block = ^{
        weakSelf.str = @"hello";
    };
    self.block();
}

//MARK: 2.block内使用self，导致的循环引用
- (void)demo2 {
    
    self.block = ^{
        self.str = @"hello";
    };
    self.block();
}

- (void)demo1 {
    /*
    //正常的内存管理逻辑：
    ClassA *a = [ClassA new];
    a.ClassB = [Class new];
    
    
    //不正常的内存管理：
    ClassA *a = [ClassA new];
    ClassB *b = [ClassB new];
    a.ClassB = b;
    b.ClassA = a;
    */
}

- (void)dealloc
{
    NSLog(@"LC Dealloc");
}


@end
