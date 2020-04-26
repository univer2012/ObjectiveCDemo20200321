//
//  SGHTenThreadLocksViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 来自：
 1.[iOS 线程锁，多线程加锁，附DEMO！](https://www.jianshu.com/p/f2ce831de20c)
 2.[iOS 十种线程锁](https://www.jianshu.com/p/7e9dd2cb78a8)
 */
#import "SGHTenThreadLocksViewController.h"

@interface SGHTenThreadLocksViewController ()

@end

@implementation SGHTenThreadLocksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = SHBaseTableTypeNewVC;
    
    NSArray *tempTitleArray = @[
        @"一、OSSpinLock (自旋锁)",
        @"二、os_unfair_lock(互斥锁)",
        @"三、dispatch_semaphore (信号量)",
        @"四、pthread_mutex(互斥锁)",
        @"五、NSLock(互斥锁、对象锁)-有demo",
        @"六、NSCondition(条件锁、对象锁)",
        @"七、NSConditionLock(条件锁、对象锁)",
        @"八、NSRecursiveLock(递归锁、对象锁)",
        @"九、@synchronized()递归锁-有demo",
        @"十、pthread_mutex(recursive)(递归锁)",
    ];
    NSArray *tempClassNameArray = @[
        @"SGHLock1ViewController",
        @"SGHLock2ViewController",
        @"SGHLock3ViewController",
        @"SGHLock4ViewController",
        @"SGHLock5ViewController",
        @"SGHLock6ViewController",
        @"SGHLock7ViewController",
        @"SGHLock8ViewController",
        @"SGHLock9ViewController",
        @"SGHLock10ViewController",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:self.title];
    
    [self.tableView reloadData];
}



@end


