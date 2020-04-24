//
//  SGHDelayViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHDelayViewController.h"

@interface SGHDelayViewController ()

@end

@implementation SGHDelayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"rac"];
        [subscriber sendCompleted];
        return nil;
    }] delay:2];
    
    NSLog(@"延时前");
    LxPrintAnything(qwr);   //先进行任意打印，记录这个打印的时间
    
    [signal subscribeNext:^(id x) {
        NSLog(@"延时后");
        LxDBAnyVar(x);  //延时2秒后才发出signal，订阅才接收到
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
