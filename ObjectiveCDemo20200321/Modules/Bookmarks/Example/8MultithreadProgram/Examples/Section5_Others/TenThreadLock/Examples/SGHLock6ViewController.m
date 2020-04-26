//
//  SGHLock6ViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHLock6ViewController.h"

@interface SGHLock6ViewController ()

@end

@implementation SGHLock6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    NSCondition *_condition= [[NSCondition alloc]init];
    // 加锁
    [_condition lock];
    // 解锁
    [_condition unlock];
    /*
    其他功能接口
    wait 进入等待状态
    waitUntilDate:让一个线程等待一定的时间
    signal 唤醒一个等待的线程
    broadcast 唤醒所有等待的线程
    注: 所测时间波动太大, 有时候会快于 NSLock, 我取得中间值.
    */
    
    [self conditionLock];
}

- (void)conditionLock{
    NSCondition *condition = [NSCondition new];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"我是线程一");
        [condition lock];
        [condition wait];
        NSLog(@"线程一进行中");
        [condition unlock];
        NSLog(@"线程一结束");
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"我是线程二");
        [condition lock];
        [condition wait];
        NSLog(@"线程二进行中");
        [condition unlock];
        NSLog(@"线程二结束");
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        NSLog(@"唤醒一个线程");
        [condition signal];
    });
}

@end
