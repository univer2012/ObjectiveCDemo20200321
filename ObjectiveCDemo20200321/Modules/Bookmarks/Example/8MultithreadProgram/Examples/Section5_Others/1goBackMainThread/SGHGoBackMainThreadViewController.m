//
//  SGHGoBackMainThreadViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 来自：[IOS基础之切回到主线程的N种方式](https://www.jianshu.com/p/6f1a6d8f9f1d)
 */
#import "SGHGoBackMainThreadViewController.h"

@interface SGHGoBackMainThreadViewController ()

@end

@implementation SGHGoBackMainThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeMethod;
    
    NSArray *tempTitleArray = @[
        @"1.第1种，使用GCD",
        @"2.第2种，使用`[NSOperationQueue mainQueue]`",
        @"3.第3种，使用`performSelectorOnMainThread:withObject:waitUntilDone:`",
        @"4.第4种，使用`[NSThread mainThread]`",
    ];
    NSArray *tempClassNameArray = @[
        @"demo1",
        @"demo2",
        @"demo3",
        @"demo4",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:self.title];
    
    [self.tableView reloadData];
}

//MARK: 4.第4种，使用`[NSThread mainThread]`
- (void)demo4 {
    [[NSThread mainThread] performSelector:@selector(updateData) withObject:nil];
}
- (void)updateData {
    NSLog(@"updateData");
    NSLog(@"%@",[NSThread mainThread]);
}

//MARK: 3.第3种，使用`performSelectorOnMainThread:withObject:waitUntilDone:`
- (void)demo3 {
    [self performSelectorOnMainThread:@selector(WantToGoBackMianThread:) withObject:@"1" waitUntilDone:YES];

}
- (void)WantToGoBackMianThread:(id)sender {
    NSLog(@"WantToGoBackMianThread:%@",sender);
    NSLog(@"%@",[NSThread mainThread]);
}

//MARK: 2.第2种，使用`[NSOperationQueue mainQueue]`
- (void)demo2 {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                //需要在主线程执行的代码
        NSLog(@"%@",[NSThread mainThread]);
    }];
}

//MARK: 1.第1种，使用GCD
- (void)demo1 {
    NSLog(@"开启一个异步线程");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"正在执行子线程中的代码");
        sleep(1);
        NSLog(@"准备回到主线程");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"开始执行main线程中的代码");
            sleep(1);
            NSLog(@"继续执行main线程中的代码");
            sleep(1);
            NSLog(@"继续执行main线程中的代码");
            sleep(1);
            NSLog(@"继续执行main线程中的代码");
            NSLog(@"main线程中的代码执行完毕");
        });
        NSLog(@"继续执行子线程中的代码");
        sleep(1);
        NSLog(@"继续执行子线程中的代码");
        sleep(1);
        NSLog(@"继续执行子线程中的代码");
        sleep(1);
        NSLog(@"继续执行子线程中的代码");
        sleep(1);
        NSLog(@"子线程中代码执行完成");
    });
    NSLog(@"完成");
}


@end
