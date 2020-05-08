//
//  SGHGroupSemaphoreNetworkViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/8.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 来自：1.[iOS 使用GCD控制网络请求顺序](https://www.jianshu.com/p/92eed31b7421)
 */

#import "SGHGroupSemaphoreNetworkViewController.h"

@interface SGHGroupSemaphoreNetworkViewController ()

@end

@implementation SGHGroupSemaphoreNetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeMethod;
    //MARK: section 1
    NSArray *tempTitleArray=@[
        @"1.使用dispatch_group_async + dispatch_group_notify实现异步和任务完成的通知。\n 内部是同步操作，没有网络请求",
        @"2.使用dispatch_async + dispatch_barrier_async实现异步和任务完成的通知。\n async内部是同步操作，没有网络请求",
    ];
    NSArray *tempSelectorArray=@[
        @"demo1",
        @"barrier",
    ];
    [self addSectionDataWithClassNameArray:tempSelectorArray titleArray:tempTitleArray title:@"async内部是同步操作，没有网络请求"];
    
    //MARK: section 2
    NSArray *tempTitleArray2 = @[
        @"方法一、使用dispatch_semaphore_t",
        @"方法二、使用GCD的 `dispatch_group_enter` + `dispatch_group_leave`",
        @"方法三、回调中执行",
    ];
    NSArray *tempSelectorArray2 = @[
        @"serialBySemaphore",
        @"serialByGroupWait",
        @"serialByCallBack",
    ];
    [self addSectionDataWithClassNameArray:tempSelectorArray2 titleArray:tempTitleArray2 title:@"异步中顺序执行"];
    
    //MARK: section 3
    NSArray *tempTitleArray3 = @[
        @"方式一：使用信号量 dispatch_semaphore_t",
        @"方法二、使用GCD的 `dispatch_group_enter` + `dispatch_group_leave`",
    ];
    NSArray *tempSelectorArray3 = @[
        @"concurrentBySemaphore",
        @"concurrentByGroup",
    ];
    [self addSectionDataWithClassNameArray:tempSelectorArray3 titleArray:tempTitleArray3 title:@"异步同时执行"];
    
    //MARK: section 4
    NSArray *tempTitleArray4 = @[
        @"1.GCD + 信号量方式",
        @"2.GCD + group enter/leave 方式",
    ];
    NSArray *tempSelectorArray4 = @[
        @"concurrentTest1",
        @"concurrentTest2",
    ];
    [self addSectionDataWithClassNameArray:tempSelectorArray4 titleArray:tempTitleArray4 title:@"模拟循环网络请求 - 异步执行、统一通知完成"];
    
    //MARK: section 5
    NSArray *tempTitleArray5 = @[
        @"1.GCD + 信号量方式",
        @"2.GCD + group enter/leave 方式",
    ];
    NSArray *tempSelectorArray5 = @[
        @"serialTest1",
        @"serialTest2",
    ];
    [self addSectionDataWithClassNameArray:tempSelectorArray5 titleArray:tempTitleArray5 title:@"模拟循环网络请求 - 异步中顺序执行"];
    
    [self.tableView reloadData];
}

//MARK: 2.GCD + group enter/leave 方式
- (void)serialTest2 {
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0 ; i < 5; i++) {
        dispatch_group_enter(group);
        NSLog(@"开始%d",i);
        // 模拟请求 ↓
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            sleep(6 - i);
            NSLog(@"任务%d完成",i);
            dispatch_group_leave(group);
        });
        // 模拟请求 ↑
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER); // 顺序执行与同步执行的不同点
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"全部搞完了");
    });
}




//MARK: - section 5、模拟循环网络请求 - 异步中顺序执行
//MARK: 1.GCD + 信号量方式
- (void)serialTest1 {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0 ; i < 5; i++) {
            NSLog(@"开始%d",i);
            // 模拟请求 ↓
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                sleep(3);
                NSLog(@"任务%d完成",i);
                dispatch_semaphore_signal(sema);
            });
            // 模拟请求 上
           dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        
       NSLog(@"全部搞完了");
    });
}



//MARK: 2.GCD + group enter/leave 方式
- (void)concurrentTest2 {
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0 ; i < 5; i++) {
        dispatch_group_enter(group);
        NSLog(@"开始%d",i);
          // 模拟请求 ↓
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            sleep(3);
            NSLog(@"任务%d完成",i);
            dispatch_group_leave(group);
        });
          // 模拟请求 ↑
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"全部搞完了");
    });
}


//MARK: - section 4、模拟循环网络请求 - 异步执行、统一通知完成
//MARK: 1.GCD + 信号量方式
- (void)concurrentTest1 {
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0 ; i < 5; i++) {
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            NSLog(@"开始%d",i);
             // 模拟请求 ↓
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                sleep(3);
                NSLog(@"任务%d完成",i);
                 dispatch_semaphore_signal(sema);
            });
             // 模拟请求 上
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"全部搞完了");
    });
}



//MARK: 方法二、使用GCD的 `dispatch_group_enter` + `dispatch_group_leave`
- (void)concurrentByGroup {
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [self requestOneWithSuccessBlock:^{
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self requestTwoWithBlock:^{
        dispatch_group_leave(group);
    }];
    
  // 1 2  都完成 才会执行
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"all request  done!");
    });
}


//MARK: - section 3 异步同时执行
//MARK: 方式一：使用信号量 dispatch_semaphore_t
- (void)concurrentBySemaphore {
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [self requestOneWithSuccessBlock:^{
            dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [self requestTwoWithBlock:^{
            dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"全部搞完了");
    });
}



//MARK: 方法三、回调中执行
///low方法，请求一多，嵌套恶心
- (void) serialByCallBack {
    [self requestOneWithSuccessBlock:^{
        [self requestTwoWithBlock:^{
        }];
    }];
}


//MARK: 方法二、使用GCD的 `dispatch_group_enter` + `dispatch_group_leave`
///1、2 同时执行，执行完了再执行3
- (void)serialByGroupWait {
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [self requestOneWithSuccessBlock:^{
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self requestTwoWithBlock:^{
        dispatch_group_leave(group);
    }];
    // 1  2同时执行
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);// 1 2 执行完 下面才会执行
    
    dispatch_group_enter(group);
    [self requestThreeWithBlock:^{
        dispatch_group_leave(group);
    }];
    
  // 1 2 3 都完成 才会执行
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"all request  done!");
    });
}
- (void)requestThreeWithBlock:(void(^)(void))finished {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        NSLog(@"Three");
        finished();
    });
}


//MARK: - section 2异步中顺序执行
//MARK: 方法一、使用dispatch_semaphore_t
- (void)serialBySemaphore {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

        [self requestOneWithSuccessBlock:^{
            dispatch_semaphore_signal(semaphore);
        }];

        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

        [self requestTwoWithBlock:^{
        }];
    });
}

- (void)requestTwoWithBlock:(void(^)(void))finished {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        NSLog(@"Two");
        finished();
    });
}

- (void)requestOneWithSuccessBlock:(void(^)(void))finished {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3);
        NSLog(@"One");
        finished();
    });
}


//MARK: 2.使用dispatch_async + dispatch_barrier_async实现异步和任务完成的通知。\n async内部是同步操作，没有网络请求
- (void)barrier {
    //dispatch_queue_t queue = dispatch_queue_create("com.lai.www", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    
    dispatch_async(queue, ^{
        NSLog(@"任务1-1完成");
    });
    dispatch_async(queue, ^{
        NSLog(@"任务1-2完成");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"任务1-3完成");
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"以上任务都完成 dispatch_barrie完成");
    });
}



//MARK: 1.使用dispatch_group_async + dispatch_group_notify实现异步和任务完成的通知。\n 内部是同步操作，没有网络请求
- (void)demo1 {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务一完成");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务二完成");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务三完成");
    });
    //在分组的所有任务完成后触发
    dispatch_group_notify(group, queue, ^{
        NSLog(@"所有任务完成");
    });

}


@end
