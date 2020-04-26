//
//  SGHLock3ViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHLock3ViewController.h"

@interface SGHLock3ViewController ()

@property (nonatomic, assign)NSInteger tickets;

@property (nonatomic, retain)dispatch_semaphore_t semaphore;

@end

@implementation SGHLock3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#if 0
    // 初始化
    dispatch_semaphore_t semaphore_t = dispatch_semaphore_create(1);
    // 加锁
    dispatch_semaphore_wait(semaphore_t,DISPATCH_TIME_FOREVER);
    // 解锁
    dispatch_semaphore_signal(semaphore_t);
    /*
    注: dispatch_semaphore  其他两个功能
    1.还可以起到阻塞线程的作用.
    2.可以实现定时器功能,这里不做过多介绍.
    */
#endif
    
    self.type = SHBaseTableTypeMethod;
    NSArray *tempTitleArray = @[
        @"1.没有加锁，2个线程竞争资源",
        @"2.加锁",
        @"3.第2个例子 -- 没有达到预期的延迟三秒执行",
        @"3_2.第2个例子的改进 -- 达到了预期的延迟三秒执行",
    ];
    NSArray *tempClassNameArray = @[
        @"demo1",
        @"demo2",
        @"semExample",
        @"semExampleImprove",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:self.title];
    
    [self.tableView reloadData];
}

//MARK: 3_2.第2个例子的改进 -- 达到了预期的延迟三秒执行
- (void)semExampleImprove {
    self.semaphore = dispatch_semaphore_create(0);
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"我是线程一");
        dispatch_semaphore_wait(self.semaphore, time);
        NSLog(@"线程一：我应该延迟三秒才执行");
        dispatch_semaphore_signal(self.semaphore);
        NSLog(@"线程一结束");
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"我是线程二");
        dispatch_semaphore_wait(self.semaphore, time);
        NSLog(@"线程二：我应该延迟三秒才执行");
        dispatch_semaphore_signal(self.semaphore);
        NSLog(@"线程二结束");
    });
}

//MARK: 3.第2个例子 -- 没有达到预期的延迟三秒执行
- (void)semExample{
    self.semaphore = dispatch_semaphore_create(1);
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"我是线程一");
        dispatch_semaphore_wait(self.semaphore, time);
        NSLog(@"线程一：我应该延迟三秒才执行");
        dispatch_semaphore_signal(self.semaphore);
        NSLog(@"线程一结束");
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"我是线程二");
        dispatch_semaphore_wait(self.semaphore, time);
        NSLog(@"线程二：我应该延迟三秒才执行");
        dispatch_semaphore_signal(self.semaphore);
        NSLog(@"线程二结束");
    });
}

//MARK: 2.加锁
- (void)demo2 {
    self.tickets = 10;
    self.semaphore = dispatch_semaphore_create(1);
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
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        if (self.tickets > 0) {
            [NSThread sleepForTimeInterval:0.5];
            self.tickets --;
            NSLog(@"剩余票数---%ld张",self.tickets);
        }
        else{
            NSLog(@"卖光了");
            break;
        }
        dispatch_semaphore_signal(self.semaphore);
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
