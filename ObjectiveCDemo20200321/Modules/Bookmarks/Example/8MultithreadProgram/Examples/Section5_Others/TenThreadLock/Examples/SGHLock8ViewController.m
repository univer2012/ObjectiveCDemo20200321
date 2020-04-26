//
//  SGHLock8ViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHLock8ViewController.h"

@interface SGHLock8ViewController ()

@property (nonatomic, assign)NSInteger tickets;
@property (nonatomic, retain)NSLock *lock;

@property (nonatomic, retain) NSRecursiveLock *recursiveLock;

@end

@implementation SGHLock8ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    NSRecursiveLock *_recursiveLock = [[NSRecursiveLock alloc]init];
    // 加锁
    [_recursiveLock lock];
    // 解锁
    [_recursiveLock unlock];
    // 尝试加锁，可以加锁则立即加锁并返回 YES,反之返回 NO
    [_recursiveLock tryLock];
    /*
    注: 递归锁可以被同一线程多次请求，而不会引起死锁。
    即在同一线程中在未解锁之前还可以上锁, 执行锁中的代码。
    这主要是用在循环或递归操作中。
    - (BOOL)lockBeforeDate:(NSDate *)limit;//触发锁 在等待时间之内
    */
    
    self.type = SHBaseTableTypeMethod;
    
    NSArray *tempTitleArray = @[
        @"1.在用递归的时候如果用普通锁进行加锁的话，会造成死锁",
        @"2.将它改成递归锁，",
    ];
    NSArray *tempClassNameArray = @[
        @"normalLock",
        @"recersiveLock",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:self.title];
    
    [self.tableView reloadData];
    
}
//MARK: 2.将它改成递归锁，
- (void)recersiveLock{
    self.recursiveLock = [[NSRecursiveLock alloc]init];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        static void (^recursiveLockBlock)(int);
        recursiveLockBlock= ^(int tickets){
            [self.recursiveLock lock];
            if (tickets > 0) {
                NSLog(@"卖出第%d张图片",tickets);
                sleep(0.5);
                tickets --;
                recursiveLockBlock(tickets);
            }
            [self.recursiveLock unlock];
        };
        recursiveLockBlock(10);
    });
}

//MARK: 1.在用递归的时候如果用普通锁进行加锁的话，会造成死锁
- (void)normalLock {
    self.lock = [[NSLock alloc] init];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        static void (^recursiveLockBlock)(int);
        recursiveLockBlock= ^(int tickets){
            [self.lock lock];
            if (tickets > 0) {
                NSLog(@"卖出第%d张图片",tickets);
                sleep(0.5);
                tickets --;
                recursiveLockBlock(tickets);
            }
            [self.lock unlock];
        };
        recursiveLockBlock(10);
    });
}


@end
