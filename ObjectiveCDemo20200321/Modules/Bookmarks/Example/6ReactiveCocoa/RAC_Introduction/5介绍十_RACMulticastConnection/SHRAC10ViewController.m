//
//  SHRAC10ViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/23.
//  Copyright © 2019 huangaengoln. All rights reserved.
//
/*
 * 来自：[RAC(ReactiveCocoa)介绍（十）——RACMulticastConnection](https://www.jianshu.com/p/ceb84f847212)
 * Multicast ['mʌltikɑ:st, -kæst]  n. 多路广播；多路传送
 * Connection  [kəˈnekʃn] n. 连接；关系；连接件
 */
#import "SHRAC10ViewController.h"
#import "UIViewController+Description.h"

@interface SHRAC10ViewController ()

@property (nonatomic, strong)RACSignal *exampleSignal;

@end

@implementation SHRAC10ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self multicastConnection];
    [self multicastConnection1];
    
    NSString *text = @"Multicast ['mʌltikɑ:st, -kæst]  n. 多路广播；多路传送\n\n"\
    "Connection  [kəˈnekʃn] n. 连接；关系；连接件";
    [self showDescWith:text];
    
}
///改进代码1
- (void)multicastConnection1 {
    _exampleSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@"message received"];
        NSLog(@"这里进行了一次耗时操作");
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"disposable!");
        }];
    }];
    
    RACMulticastConnection *connection = [_exampleSignal publish];
    
    
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一处，收到订阅信号：%@",x);
    }];
    
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二处，收到订阅信号：%@",x);
    }];
    
    [connection connect];
}




///初始代码
- (void)multicastConnection {
    _exampleSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@"message received"];
        NSLog(@"这里进行了一次耗时操作");
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"disposable!");
        }];
    }];
    
    [_exampleSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一处，收到订阅信号：%@",x);
    }];
    
    [_exampleSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二处，收到订阅信号：%@",x);
    }];
}

@end
