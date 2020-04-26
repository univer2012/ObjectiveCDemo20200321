//
//  SGH0426OperationQueueDemoViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 远平. All rights reserved.
//
/*
来自：[iOS开发之多线程(GCD与NSOperation)](http://www.jianshu.com/p/5593af00c597)
*/
#import "SGH0426OperationQueueDemoViewController.h"

@interface SGH0426OperationQueueDemoViewController ()

@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation SGH0426OperationQueueDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = SHBaseTableTypeMethod;
    //section 1
    NSArray *tempTitleArray=@[
        @"0.开始执行一个任务",
        @"1.利用NSOperationQueue实现异步操作\n 使用NSOperationQueue来执行任务与之前的区别在于，首先创建一个非主队列。然后用addOperation方法替换之前的start方法。刚刚已经说过，NSOperationQueue会为每一个NSOperation创建线程并调用它们的start方法。",
        @"2.取消NSOperation任务 - 取消某个NSOperation",
        @"2_2.取消NSOperation任务 - 取消某个NSOperationQueue剩余的NSOperation",
        @"2_3.执行到中途，取消NSOperationQueue剩余的NSOperation \n执行`[queue cancelAllOperations];`后面如果执行了`addOperation:`那后面的op会照样执行，只是取消掉了`cancelAllOperations`前面的op。",
        @"3.queue.suspended的使用 - 在当前页面时就恢复轮询网络请求，不在当前页面就暂停请求",
        @"4.进程间通信 - 下载完图片后，回到主线程改变UI",
    ];
    NSArray *tempSelectorArray=@[
        @"demo0",
        @"demo1",
        @"demo2",
        @"demo2_2",
        @"demo2_3",
        @"demo3",
        @"demo4",
    ];
    [self addSectionDataWithClassNameArray:tempSelectorArray titleArray:tempTitleArray title:@""];
    
    [self.tableView reloadData];
}
//MARK: 4.进程间通信 - 下载完图片后，回到主线程改变UI
///5.5 进程间通信
- (void)demo4 {
    self.imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
    }];
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // 子线程下载图片
    [queue addOperationWithBlock:^{
        NSURL * url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
        NSData * data = [NSData dataWithContentsOfURL:url];
        UIImage * image = [[UIImage alloc] initWithData:data];
        //回到主线程进行显示
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = image;
        }];
    }];
}

//MARK:3.queue.suspended的使用 - 在当前页面时就恢复轮询网络请求，不在当前页面就暂停请求
//5.3 NSOperationQueue暂停与恢复
- (void)demo3 {
    
}


//MARK:2_3.执行到中途，取消NSOperationQueue剩余的NSOperation
//执行`[queue cancelAllOperations];`后面如果执行了`addOperation:`那后面的op会照样执行，只是取消掉了`cancelAllOperations`前面的op。
- (void)demo2_3 {
    //自建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    __weak typeof(queue) weakQueue = queue;
    //op1
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task0 :%@", [NSThread currentThread]);
        //[weakQueue cancelAllOperations]; //无取消效果
    }];
    
    [op1 addExecutionBlock:^{
        NSLog(@"task1: %@", [NSThread currentThread]);
    }];
    [queue addOperation:op1];
    
    [queue cancelAllOperations];
    
    //op2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task2 :%@", [NSThread currentThread]);
        //[weakQueue cancelAllOperations]; //无取消效果
    }];
    [op2 addExecutionBlock:^{
        NSLog(@"task3: %@", [NSThread currentThread]);
    }];
    [queue addOperation:op2];
    NSLog(@"操作结束");
    
    
}

//MARK: 2_2.取消NSOperation任务 - 取消某个NSOperationQueue剩余的NSOperation
///5.1 取消任务
- (void)demo2_2 {
    //自建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //op1
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task0 :%@", [NSThread currentThread]);
    }];
    
    [op1 addExecutionBlock:^{
        NSLog(@"task1: %@", [NSThread currentThread]);
    }];
    [queue addOperation:op1];
    
    //op2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task2 :%@", [NSThread currentThread]);
    }];
    [op2 addExecutionBlock:^{
        NSLog(@"task3: %@", [NSThread currentThread]);
    }];
    [queue addOperation:op2];
    NSLog(@"操作结束");
    
    //取消某个NSOperationQueue剩余的NSOperation
    [queue cancelAllOperations];
}

//MARK: 2.取消NSOperation任务 - 取消某个NSOperation
///5.1 取消任务
- (void)demo2 {
    //自建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //op1
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task0 :%@", [NSThread currentThread]);
    }];
    [op1 addExecutionBlock:^{
        NSLog(@"task1: %@", [NSThread currentThread]);
    }];
    [queue addOperation:op1];
    
    //取消某个NSOperation
    [op1 cancel];
    
    //op2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task2 :%@", [NSThread currentThread]);
    }];
    [op2 addExecutionBlock:^{
        NSLog(@"task3: %@", [NSThread currentThread]);
    }];
    [queue addOperation:op2];
    NSLog(@"操作结束");
    
    
}

//MARK: 1.利用NSOperationQueue实现异步操作
///使用NSOperationQueue来执行任务与之前的区别在于，首先创建一个非主队列。然后用addOperation方法替换之前的start方法。刚刚已经说过，NSOperationQueue会为每一个NSOperation创建线程并调用它们的start方法。
- (void)demo1 {
    //自建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"task0 :%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"task1: %@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"task2: %@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"task3: %@", [NSThread currentThread]);
    }];
    [queue addOperation:op];
    NSLog(@"操作结束");
}

//MARK: 0.开始执行一个任务
- (void)demo0 {
    NSBlockOperation * op = [NSBlockOperation blockOperationWithBlock:^{
                //要执行的任务，这个任务主线程中执行
        NSLog(@"task----%@",[NSThread currentThread]);
    }];
    [op start];
}

@end
