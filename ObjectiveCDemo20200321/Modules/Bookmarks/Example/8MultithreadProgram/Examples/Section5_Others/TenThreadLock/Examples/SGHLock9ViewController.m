//
//  SGHLock9ViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHLock9ViewController.h"

@interface SGHLock9ViewController ()

@property (nonatomic, assign)NSInteger tickets;

@end

@implementation SGHLock9ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    @synchronized(self){
        
    }
    //底层封装的pthread_mutex的PTHREAD_MUTEX_RECURSIVE 模式,
    //锁对象来表示是否为同一把锁
    
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
    // 线程1
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self synchronizeSale];
    });
    // 线程2
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self synchronizeSale];
    });
}
- (void)synchronizeSale {
    while (true) {
        @synchronized(self){
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
