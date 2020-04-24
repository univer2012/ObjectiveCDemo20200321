//
//  SGHMergeViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHMergeViewController.h"
#import "UIViewController+Description.h"

@interface SGHMergeViewController ()

@end

@implementation SGHMergeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *text = @"merge 其实是把 signalA 和 signaleB 一起订阅了。它们两个相互不影响，只是订阅放在一起了"\
    "\n\n问：[signalA merge:signalB]，merge时，A，B都是2秒，会怎么样？"\
    "\n答：\n"\
    "2016-01-31 12:19:10.743 RAC_test[31906:680415] 执行前 \n"\
    "2016-01-31 12:19:12.750 RAC_test[31906:680415] 执行时a \n"\
    "2016-01-31 12:19:12.750 RAC_test[31906:680415] 执行时b \n\n"\
    "如果是[signalB merge:signalA]，则先打印b，再打印a。\n\n"\
    "[RACSignal merge:@[signalA, signalB]] 和[RACSignal merge:@[signalB, signalA]]同理";
    [self showDescWith:text];
    
    RACSignal * signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LxPrintAnything(a);
            [subscriber sendNext:@"a"];
            [subscriber sendCompleted];
        });
        
        return nil;
    }];
    
    RACSignal * signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LxPrintAnything(b);
            [subscriber sendNext:@"b"];
            [subscriber sendCompleted];
        });
        
        return nil;
    }];
    
#if 0
    // merge 其实是把 signalA 和 signaleB 一起订阅了。它们两个相互不影响，只是订阅放在一起了
    NSLog(@"执行前");
    [[signalA merge:signalB] subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
        NSLog(@"执行时%@",x);
    }];
    //问：merge时，A，B都是2秒，会怎么样？
    //答：
    /*
     2016-01-31 12:19:10.743 RAC_test[31906:680415] 执行前
     2016-01-31 12:19:12.750 RAC_test[31906:680415] 执行时a
     2016-01-31 12:19:12.750 RAC_test[31906:680415] 执行时b
     */
    
#elif 1
    // 另一种写法
    [[RACSignal merge:@[signalA, signalB]] subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
    }];
    
#endif
    
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
