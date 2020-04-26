//
//  SGHLock7ViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHLock7ViewController.h"

@interface SGHLock7ViewController ()

@end

@implementation SGHLock7ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    NSConditionLock *_conditionLock = [[NSConditionLock alloc]init];
    // 加锁
    [_conditionLock lock];
    // 解锁
    [_conditionLock unlock];
    // 尝试加锁，可以加锁则立即加锁并返回 YES,反之返回 NO
    [_conditionLock tryLock];
    /*
    其他功能接口
    - (instancetype)initWithCondition:(NSInteger)condition NS_DESIGNATED_INITIALIZER; //初始化传入条件
    - (void)lockWhenCondition:(NSInteger)condition;//条件成立触发锁
    - (BOOL)tryLockWhenCondition:(NSInteger)condition;//尝试条件成立触发锁
    - (void)unlockWithCondition:(NSInteger)condition;//条件成立解锁
    - (BOOL)lockBeforeDate:(NSDate *)limit;//触发锁 在等待时间之内
    - (BOOL)lockWhenCondition:(NSInteger)condition beforeDate:(NSDate *)limit;//触发锁 条件成立 并且在等待时间之内
    */
    
    [self conditionLock1];
}

- (void)conditionLock1{
    NSConditionLock *condition = [[NSConditionLock alloc] initWithCondition:1];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([condition tryLockWhenCondition:1]) {
            NSLog(@"我是线程1");
            [condition unlockWithCondition:3];
        }
        else{
            NSLog(@"线程一等待锁失败");
        }
    });
    sleep(0.5);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [condition lockWhenCondition:2];
        NSLog(@"我是线程2");
        [condition unlockWithCondition:0];
    });
    sleep(0.5);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [condition lockWhenCondition:3];
         NSLog(@"我是线程3");
        [condition unlockWithCondition:2];
    });
}

@end
