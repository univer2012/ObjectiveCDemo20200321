//
//  SGHSumupViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHSumupViewController.h"

@interface SGHSumupViewController ()

@end

@implementation SGHSumupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //编程思想讲一个：
    //大量使用RAC代码，会怎么写？会把事件封装成 一个个信号，
    /*
     IB MVVM
     问：跨类监听
     答：只要这个信号不受类的影响
     */
    
    [[self loginSignal] subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
    } error:^(NSError *error) {
        
    }];
    
    
#if 0
    /*
     问：RAC有什么坑？
     答： side effect.
     
     注意：光创建信号，里面的代码不会被执行，必须要有订阅者。
     (实验:注释掉下面的2个 subscribeNext: ，并在创建信号的block里打断点)
     */
    RACSignal *signal =[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        static int i = 0;
        i++;
        [subscriber sendNext:@(i)];
        [subscriber sendCompleted];
        return nil;
    }];
    
    [signal subscribeNext:^(id x) {
       
        LxDBAnyVar(x);
    }];
    
    [signal subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
    }];
    /*print:
     📍__37-[SGHSumupViewController viewDidLoad]_block_invoke_4 + 55🎈 x = 1
     📍__37-[SGHSumupViewController viewDidLoad]_block_invoke_5 + 60🎈 x = 2
     
     对于这个问题，是有解决办法的，如下：
     */
    
#elif 1
    // replay --->  我订阅一次之后，我发送的喜好，会缓存起来；第二次订阅时，用的是缓存。
    RACSignal *signal =[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        static int i = 0;
        i++;
        [subscriber sendNext:@(i)];
        [subscriber sendCompleted];
        return nil;
    }] replay];
    
    [signal subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
    }];
    
    [signal subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
    }];
    /*print:
     📍__37-[SGHSumupViewController viewDidLoad]_block_invoke_4 + 83🎈 x = 1
     📍__37-[SGHSumupViewController viewDidLoad]_block_invoke_5 + 88🎈 x = 1
     */
    
#endif
    /*
     信号要理解是局部变量。
     比如说，信号甚至可以写成一个单例，我出一个单例就是信号，然后A类里面也订阅，B类里面也订阅，是不是就解决了。
     */
    
}

- (RACSignal *)loginSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        RACDisposable * schedulerDisposable = [[RACScheduler mainThreadScheduler]afterDelay:2 schedule:^{
            
            if (arc4random()%10 > 1) {
                
                [subscriber sendNext:@"Login response"];
                [subscriber sendCompleted];
            }
            else {
                
                [subscriber sendError:[NSError errorWithDomain:@"LOGIN_ERROR_DOMAIN" code:444 userInfo:@{}]];
            }
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
            [schedulerDisposable dispose];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
