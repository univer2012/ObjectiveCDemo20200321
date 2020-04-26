//
//  SGHLock5ViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHLock5ViewController.h"

@interface SGHLock5ViewController ()

@property (nonatomic, assign)NSInteger tickets;

@property (nonatomic, retain)NSLock *lock;

@end

@implementation SGHLock5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化
    NSLock *_lock = [[NSLock alloc]init];
    // 加锁
    [_lock lock];
    // 解锁
    [_lock unlock];
    // 尝试加锁，可以加锁则立即加锁并返回 YES,反之返回 NO
    [_lock tryLock];
    
    self.type = SHBaseTableTypeMethod;
    NSArray *tempTitleArray = @[
        @"1.没有加锁，2个线程竞争资源",
        @"2.加锁",
    ];
    NSArray *tempClassNameArray = @[
        @"demo1",
        @"demo2",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:self.title];
    
    [self.tableView reloadData];
}

//MARK: 2.加锁
- (void)demo2 {
    self.tickets = 10;
    self.lock = [[NSLock alloc] init];
    // 线程1
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self lockSale];
    });
    // 线程2
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self lockSale];
    });
}
- (void)lockSale{
    while (true) {
        [self.lock lock];
        if (self.tickets > 0) {
            [NSThread sleepForTimeInterval:0.5];
            self.tickets --;
            NSLog(@"剩余票数---%ld张",self.tickets);
        }
        else{
            NSLog(@"卖光了");
            break;
        }
        [self.lock unlock];
    }
}

//MARK: 1.没有加锁，2个线程竞争资源
- (void)demo1 {
    self.tickets = 10;
    // 线程1
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self sale];
    });
    // 线程2
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self sale];
    });
}
- (void)sale{
    while (true) {
        [NSThread sleepForTimeInterval:0.5];
        if (self.tickets > 0) {
            self.tickets --;
            NSLog(@"剩余票数---%ld张",self.tickets);
        }
        else{
            NSLog(@"卖光了");
            break;
        }
    }
}

@end
