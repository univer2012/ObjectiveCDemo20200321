//
//  SGHLock1ViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHLock1ViewController.h"
#import <libkern/OSAtomic.h>

@interface SGHLock1ViewController ()

@end

@implementation SGHLock1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化
     OSSpinLock spinLock = OS_SPINLOCK_INIT;
    // 加锁
    OSSpinLockLock(&spinLock);
    // 解锁
    OSSpinLockUnlock(&spinLock);
    // 尝试加锁，可以加锁则立即加锁并返回 YES,反之返回 NO
    OSSpinLockTry(&spinLock);
    /*
    注:苹果爸爸已经在iOS10.0以后废弃了这种锁机制,使用os_unfair_lock 替换,
    顾名思义能够保证不同优先级的线程申请锁的时候不会发生优先级反转问题.
    */
    
    [self spinLock];
}

- (void)spinLock {
    __block OSSpinLock spinLock = OS_SPINLOCK_INIT;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"我是线程1");
        OSSpinLockLock(&spinLock);
        sleep(3);
        NSLog(@"线程1进行中");
        OSSpinLockUnlock(&spinLock);
        NSLog(@"线程1结束");
    });
    sleep(1);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"我是线程2");
        OSSpinLockLock(&spinLock);
        NSLog(@"线程2进行中");
        OSSpinLockUnlock(&spinLock);
        NSLog(@"线程2结束");
        
    });
    sleep(1);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"我是线程3");
        OSSpinLockLock(&spinLock);
        NSLog(@"线程3进行中");
        OSSpinLockUnlock(&spinLock);
        NSLog(@"线程3结束");
    });
}

@end
