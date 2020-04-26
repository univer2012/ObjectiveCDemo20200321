//
//  SGHLock4ViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHLock4ViewController.h"
#import <pthread/pthread.h>

@interface SGHLock4ViewController ()

@end

@implementation SGHLock4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化(两种)
    //1.普通初始化
    pthread_mutex_t mutex_t;
    pthread_mutex_init(&mutex_t, NULL);
    
    //2.宏初始化
    pthread_mutex_t mutex =PTHREAD_MUTEX_INITIALIZER;
    
    // 加锁
    pthread_mutex_lock(&mutex_t);
    // 解锁
    pthread_mutex_unlock(&mutex_t);
    // 尝试加锁，可以加锁时返回的是 0，否则返回一个错误
    pthread_mutex_trylock(& mutex_t);
    
    
    [self pthreadExample];
}

- (void)pthreadExample{
    static pthread_mutex_t plock;
    pthread_mutex_init(&plock, NULL);//互斥锁
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"我是线程一");
        pthread_mutex_lock(&plock);
        sleep(3);
        NSLog(@"线程一进行中");
        pthread_mutex_unlock(&plock);
        NSLog(@"线程一结束");
    });
    sleep(1);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"我是线程二");
        pthread_mutex_lock(&plock);
        NSLog(@"线程二进行中");
        pthread_mutex_unlock(&plock);
        NSLog(@"线程二结束");
    });
}



@end
