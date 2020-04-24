//
//  SGHConcatViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHConcatViewController.h"

@interface SGHConcatViewController ()

@end

@implementation SGHConcatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    RACSignal * signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LxPrintAnything(a);
            [subscriber sendNext:@"a"];
            [subscriber sendCompleted];
        });
        
        return nil;
    }];
    
    RACSignal * signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LxPrintAnything(b);
            [subscriber sendNext:@"b"];
            [subscriber sendCompleted];
        });
        
        return nil;
    }];
    
    NSLog(@"执行前");
    //concat  --> 连接
    [[signalA concat:signalB] subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
        NSLog(@"执行时%@",x);
    }];
    /// analyse: “执行前” 和 “执行时a” 相差 2秒，
    ///“执行时a” 和 “执行时b” 相差 5秒
    ///signalA 执行完 sendCompleted 之后，才会执行 SignalB.
    ///
    ///问：如果A不执行 sendCompleted，是不是B就不会执行？
    ///答：是的。如果 A没有执行 sendCompleted，B就不会被 订阅
    
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
