//
//  SGH0426GCDViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 来自：
 1.[iOS开发之多线程(GCD与NSOperation)](http://www.jianshu.com/p/5593af00c597)
 2. [iOS 使用dispatch_group_enter 使多次网络请求依次执行](https://www.jianshu.com/p/71fbc0415b5d)
 
 更多dispatch_semaphore_t的使用情况，请查看：
 [GCD信号量-dispatch_semaphore_t](https://www.jianshu.com/p/24ffa819379c)
 
 
 */
#import "SGH0426GCDViewController.h"

@interface SGH0426GCDViewController ()

@end

@implementation SGH0426GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeMethod;
    //section 1
    NSArray *tempTitleArray=@[
        @"1.GCD死锁问题",
        @"2_1.dispatch_group_wait 的使用",
        @"2_2.dispatch_after 的使用",
        @"3.其他线程在读取时，使用dispatch_async执行写操作",
        @"3_2.对「3」的改进，使用dispatch_barrier_async执行写操作",
        
    ];
    NSArray *tempSelectorArray=@[
        @"demo1",
        @"demo2_1",
        @"demo2_2",
        @"demo3",
        @"demo3_2",
        
    ];
    [self addSectionDataWithClassNameArray:tempSelectorArray titleArray:tempTitleArray title:@""];
    
    //MARK: section 2
    NSArray *tempTitleArray2 = @[
        @"1.使用dispatch_group_enter使多次网络请求依次执行",
        @"2.GCD任务组 的使用 - dispatch_group_async、dispatch_group_notify",
    ];
    NSArray *tempSelectorArray2 = @[
        @"sec2demo1",
        @"sec2demo2",
    ];
    [self addSectionDataWithClassNameArray:tempSelectorArray2 titleArray:tempTitleArray2 title:@"dispatch_group_t的使用"];
    
    //MARK: section 3
    NSArray *tempTitleArray3 = @[
        @"1.利用dispatch_semaphore_t将数据，在异步线程追加到数组",
        @"2.用 dispatch_semaphore 实现：A 请求数据成功之后,再执行 B 的网络请求",
    ];
    NSArray *tempSelectorArray3 = @[
        @"sec3demo1",
        @"sec3demo2",
    ];
    [self addSectionDataWithClassNameArray:tempSelectorArray3 titleArray:tempTitleArray3 title:@"dispatch_semaphore_t的使用"];
        
    [self.tableView reloadData];
}

//MARK: 2.用 dispatch_semaphore 实现：A 请求数据成功之后,再执行 B 的网络请求
///3.3 dispatch_semaphore
- (void)sec3demo2 {
    [self finishedSemDataFinished:^(BOOL success) {
        if (success) {
            NSLog(@"执行完成");
        } else {
            NSLog(@"执行中...");
        }
    }];
}

- (void)finishedSemDataFinished:(void(^)(BOOL success))finished {
    NSLog(@"开始");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [self loadADataFinished:^(BOOL success){
            if (success){
            }else{
                finished(NO);
            }
            dispatch_semaphore_signal(semaphore);
        }];
    
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); // A请求完成之后,请求 B
    
        [self loadBDataFinished:^(BOOL success){
            if (success){
            }else{
                finished(NO);
            }
            dispatch_semaphore_signal(semaphore);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        NSLog(@"结束");
        
    });
}


//MARK: section 3
//MARK: 1.利用dispatch_semaphore_t将数据，在异步线程追加到数组
///3.3 dispatch_semaphore
- (void)sec3demo1 {
    //创建一个信号量初始值为1
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    dispatch_queue_t dispatchQueue = dispatch_queue_create("sgh.gcd.next", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"开始");
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 10000; i++) {
        dispatch_async(dispatchQueue, ^{
            /* 某个线程执行到这里，如果信号量为1，那么wait方法返回1，开始执行接下来的操作。
             与此同时，因为信号量变为0，其他执行到这里的线程必须等待  *****/
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

            /* 执行了wait方法后，信号量变成了0，可以进行接下来的操作。
             这时候其他线程都得等待wait方法返回。
             对array修改的线程在任意时刻都只有一个，可以安全的修改array *****/
            [array addObject:@(i)];
            NSLog(@"被锁在房间,%d",i);
            
            /** 排他操作执行结束，记得要调用signal方法，把信号量的值加1。
             这样，如果有别的线程在等待wait函数返回，就由最先等待的线程执行  ****/
            dispatch_semaphore_signal(semaphore);
            
            if (i + 1 == 10000) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"结束");
                });
            }
            
        });
        
    }
    NSLog(@"结束2");
}

//MARK: 2.GCD任务组 的使用 - dispatch_group_async、dispatch_group_notify
//2.2 GCD任务组
- (void)sec2demo2 {
    dispatch_queue_t dispatchQueue = dispatch_queue_create("sgh.queue.next", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t dispatchGroup = dispatch_group_create();

    dispatch_group_async(dispatchGroup, dispatchQueue, ^{
        NSLog(@"任务A");
    });
    dispatch_group_async(dispatchGroup, dispatchQueue, ^{
        NSLog(@"任务B");
    });
    dispatch_group_async(dispatchGroup, dispatchQueue, ^{
        NSLog(@"任务C");
    });
    dispatch_group_async(dispatchGroup, dispatchQueue, ^{
        NSLog(@"任务D");
    });

    dispatch_group_notify(dispatchGroup, dispatchQueue, ^{
        NSLog(@"end");
    });
}

//MARK: section 2
//MARK:1. 使用dispatch_group_enter使多次网络请求依次执行
///
- (void)sec2demo1 {
    [self finishedDataFinished:^(BOOL success) {
        if (success) {
            NSLog(@"执行完成");
        } else {
            NSLog(@"执行中...");
        }
    }];
}

// 请求是否全部完成
- (void)finishedDataFinished:(void(^)(BOOL success))finished {
  dispatch_group_t group = dispatch_group_create();
  dispatch_group_enter(group);
  [self loadADataFinished:^(BOOL success){
    if (success){
      dispatch_group_leave(group);
    }else{
      finished(NO);
    }
  }];
  dispatch_group_enter(group);
  [self loadBDataFinished:^(BOOL success){
    if (success){
      dispatch_group_leave(group);
    }else{
      finished(NO);
    }
  }];

 dispatch_group_wait(group, DISPATCH_TIME_FOREVER);// A,B同时执行, 执行完才会执行下面的 C
 dispatch_group_enter(group);
 [self loadCDataFinished:^(BOOL success){
    if (success){
      dispatch_group_leave(group);
    }else{
      finished(NO);
    }
  }];
 
  //  group 中的任务都成功完成后,才会返回 YES
  dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        finished(YES);
   });
}
// A 请求数据 - 异步
- (void)loadADataFinished:(void(^)(BOOL success))finished {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3);
        NSLog(@"A");
        finished(YES);
    });
        
}
// B 请求数据 - 异步
- (void)loadBDataFinished:(void(^)(BOOL success))finished {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        NSLog(@"B");
        finished(YES);
    });
    
}
// C 请求数据 - 异步
- (void)loadCDataFinished:(void(^)(BOOL success))finished {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        NSLog(@"C");
        finished(YES);
    });
}



//MARK: 3_2.对「3」的改进，使用dispatch_barrier_async执行写操作
- (void)demo3_2 {
    dispatch_queue_t dispatchQueue = dispatch_queue_create("sgh.queue.next", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_block_t block1_for_reading, block2_for_reading, block_for_writing;
    dispatch_block_t block3_for_reading, block4_for_reading;
    
    block1_for_reading = ^{
        NSLog(@"block1前");
        sleep(3);
        NSLog(@"block1--- 3秒后执行");
    };
    
    block2_for_reading = ^{
        NSLog(@"block2前");
        sleep(2);
        NSLog(@"block2--- 2秒后执行");
    };
    
    block_for_writing = ^{
        NSLog(@"writing前");
        sleep(5);
        NSLog(@"writing--- 5秒后执行");
    };
    
    block3_for_reading = ^{
        NSLog(@"block3前");
        sleep(3);
        NSLog(@"block3--- 3秒后执行");
        
    };
    block4_for_reading = ^{
        NSLog(@"block4前");
        sleep(2);
        NSLog(@"block4--- 2秒后执行");
        
    };
    
    dispatch_async(dispatchQueue, block1_for_reading);
    dispatch_async(dispatchQueue, block2_for_reading);
    
    //这里插入写入任务，比如：
    dispatch_barrier_async(dispatchQueue, block_for_writing);
    
    dispatch_async(dispatchQueue, block3_for_reading);
    dispatch_async(dispatchQueue, block4_for_reading);
    
    
}

//MARK: 3.其他线程在读取时，使用dispatch_async执行写操作
//3.2 dispatch_barrier_async
- (void)demo3 {
    
    dispatch_queue_t dispatchQueue = dispatch_queue_create("sgh.queue.next", DISPATCH_QUEUE_CONCURRENT);

    dispatch_block_t block1_for_reading, block2_for_reading, block_for_writing;
    dispatch_block_t block3_for_reading, block4_for_reading;
    
    block1_for_reading = ^{
        NSLog(@"block1前");
        sleep(3);
        NSLog(@"block1--- 3秒后执行");
    };
    
    block2_for_reading = ^{
        NSLog(@"block2前");
        sleep(2);
        NSLog(@"block2--- 2秒后执行");
    };
    
    block_for_writing = ^{
        NSLog(@"writing前");
        sleep(5);
        NSLog(@"writing--- 5秒后执行");
    };
    
    block3_for_reading = ^{
        NSLog(@"block3前");
        sleep(3);
        NSLog(@"block3--- 3秒后执行");
        
    };
    block4_for_reading = ^{
        NSLog(@"block4前");
        sleep(2);
        NSLog(@"block4--- 2秒后执行");
        
    };
    
    dispatch_async(dispatchQueue, block1_for_reading);
    dispatch_async(dispatchQueue, block2_for_reading);
    
    //这里插入写入任务，比如：
    dispatch_async(dispatchQueue, block_for_writing);
     
    dispatch_async(dispatchQueue, block3_for_reading);
    dispatch_async(dispatchQueue, block4_for_reading);
    
    
    
}



//MARK: 2_2.dispatch_after 的使用
//2.2.2 dispatch_after
- (void)demo2_2 {
    NSLog(@"前");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"1秒后执行");
    });
    NSLog(@"后");
}

//MARK: 2_1.dispatch_group_wait 的使用
//2.2.1 dispatch_group_wait
///返回值表示，经过指定的等待时间，属于这个group的任务是否已经全部执行完。如果是则返回0，否则返回非0。
- (void)demo2_1 {
    dispatch_queue_t dispatchQueue = dispatch_queue_create("sgh.queue.next", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_t dispatchGroup = dispatch_group_create();

    dispatch_group_async(dispatchGroup, dispatchQueue, ^{
        NSLog(@"任务A");
    });
    dispatch_group_async(dispatchGroup, dispatchQueue, ^{
        NSLog(@"任务B");
    });
    
    long temp = dispatch_group_wait(dispatchGroup, DISPATCH_TIME_NOW);
    NSLog(@"temp:%ld",temp);
    long tempFOREVER = dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER);
    NSLog(@"tempFOREVER: %ld",tempFOREVER);
    
    dispatch_group_async(dispatchGroup, dispatchQueue, ^{
        NSLog(@"任务C");
    });
    dispatch_group_async(dispatchGroup, dispatchQueue, ^{
        NSLog(@"任务D");
    });

    dispatch_group_notify(dispatchGroup, dispatchQueue, ^{
        NSLog(@"end");
        long temp_end = dispatch_group_wait(dispatchGroup, DISPATCH_TIME_NOW);
        NSLog(@"temp_end:%ld",temp_end);
    });
    
    long temp2 = dispatch_group_wait(dispatchGroup, DISPATCH_TIME_NOW);
    NSLog(@"temp2:%ld",temp2);
    long tempFOREVER2 = dispatch_group_wait(dispatchGroup, DISPATCH_TIME_FOREVER);
    NSLog(@"tempFOREVER2: %ld",tempFOREVER2);
}



//MARK: 1.GCD死锁问题
/*
 ### 2.1.1 理论分析

    dispatch_sync表示同步的执行任务，也就是说执行dispatch_sync后，当前队列会阻塞。而dispatch_sync中的block如果要在当前队列中执行，就得等待当前队列执行完成。
 
 上面例子中，首先主队列执行任务1，然后执行dispatch_sync，随后在队列中新增一个任务2。因为主队列是同步队列，所以任务2要等dispatch_sync执行完才能执行，但是dispatch_sync是同步派发 ，要等任务2执行完才算是结束。在主队列中的两个任务互相等待，导致了死锁<\span>。当然，由于死锁，后面添加的任务3也不会执行了。
 */
- (void)demo1 {
    NSLog(@"1"); //任务1
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2"); //任务2
    });
    NSLog(@"3"); //任务3
}


@end
