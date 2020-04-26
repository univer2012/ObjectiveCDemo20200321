//
//  SGHLock10ViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHLock10ViewController.h"
#import <pthread/pthread.h>

@interface SGHLock10ViewController ()

@end

@implementation SGHLock10ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化
    pthread_mutex_t mutex_t;
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr); //初始化attr并且给它赋予默认
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE); //设置锁类型，这边是设置为递归锁
    pthread_mutex_init(&mutex_t, &attr);
    
    pthread_mutexattr_destroy(&attr); //销毁一个属性对象，在重新进行初始化之前该结构不能重新使用
    // 加锁
    pthread_mutex_lock(&mutex_t);
    // 解锁
    pthread_mutex_unlock(&mutex_t);
    /*
    注: 递归锁可以被同一线程多次请求，而不会引起死锁。
    即在同一线程中在未解锁之前还可以上锁, 执行锁中的代码。
    这主要是用在循环或递归操作中。
    */
    
    
    [self pthreadLock];
}

- (void)pthreadLock{
    static pthread_mutex_t plock1;
    pthread_mutexattr_t attr;
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);// 递归锁
    pthread_mutex_init(&plock1, &attr);
    pthread_mutex_destroy(&plock1);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        static void (^recursiveLockBlock)(int);
        
        recursiveLockBlock= ^(int tickets){
            pthread_mutex_lock(&plock1);
            if (tickets > 0) {
                NSLog(@"卖出第%d张图片",tickets);
                sleep(0.5);
                tickets --;
                recursiveLockBlock(tickets);
            }
            pthread_mutex_unlock(&plock1);
        };
        
        recursiveLockBlock(10);
    });
}

@end
