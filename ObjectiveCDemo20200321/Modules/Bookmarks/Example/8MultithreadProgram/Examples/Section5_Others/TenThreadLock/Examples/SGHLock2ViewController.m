//
//  SGHLock2ViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 来自：
 [iOS锁-OSSpinLock与os_unfair_lock](https://www.jianshu.com/p/40adc41735b6)
 */
#import "SGHLock2ViewController.h"
#import <os/lock.h>

API_AVAILABLE(ios(10.0))
@interface SGHLock2ViewController ()
@property (nonatomic, assign)os_unfair_lock theLock;
@end

@implementation SGHLock2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 10.0, *)) {
        // 初始化
        os_unfair_lock unfair_lock = OS_UNFAIR_LOCK_INIT;
        // 加锁
        os_unfair_lock_lock(&unfair_lock);
        // 解锁
        os_unfair_lock_unlock(&unfair_lock);
        // 尝试加锁，可以加锁则立即加锁并返回 YES,反之返回 NO
        os_unfair_lock_trylock(&unfair_lock);
        /*
        注:解决不同优先级的线程申请锁的时候不会发生优先级反转问题.
        不过相对于 OSSpinLock , os_unfair_lock性能方面减弱了许多.
        */
        
    } else {
        // Fallback on earlier versions
    }
    
    
    [self forTest];
}

- (void)forTest {
    // 创建信号量
    self.theLock = OS_UNFAIR_LOCK_INIT;
    NSThread *thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(download1) object:nil];
    [thread1 start];
    NSThread *thread2 = [[NSThread alloc]initWithTarget:self selector:@selector(download2) object:nil];
    [thread2 start];
}
-(void)download1 {
    os_unfair_lock_lock(&_theLock);
    NSLog(@"第一个线程同步操作开始");
    sleep(5);
    NSLog(@"第一个线程同步操作结束");
    os_unfair_lock_unlock(&_theLock);
}

-(void)download2 {
    os_unfair_lock_lock(&_theLock);
    NSLog(@"第二个线程同步操作开始");
    sleep(1);
    NSLog(@"第二个线程同步操作结束");
    os_unfair_lock_unlock(&_theLock);
}


@end
