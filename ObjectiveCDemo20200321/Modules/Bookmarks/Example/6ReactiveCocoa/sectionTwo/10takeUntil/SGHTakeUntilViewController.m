//
//  SGHTakeUntilViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHTakeUntilViewController.h"
#import "UIViewController+Description.h"

@interface SGHTakeUntilViewController ()

@end

@implementation SGHTakeUntilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ///理解：一直拿，直到xxx情况才不拿。
    NSString *text = @"takeUntil:  后面接一个信号 ，意思是：直到这个信号执行完，才执行 上面的 sendNext:" \
    "\n\n比如，计时器，在执行willDealloc之前，停止计时。" \
    "\n\n使用`takeUntil:`后，不用再执行`[disposable dispose];`。否则代码还没执行就已经dispose了。";
    [self showDescWith:text];
    //
    
    /// 原代码
//    [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [subscriber sendNext:@"rac1"];
//        [subscriber sendNext:@"rac2"];
//        [subscriber sendNext:@"rac3"];
//        [subscriber sendNext:@"rac4"];
//        [subscriber sendCompleted];
//        return nil;
//
//    }] takeUntil:[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [subscriber sendNext:@"takeUntil"];
//        [subscriber sendCompleted];
//        return nil;
//    }]
//    ];
    
    
    RACSignal *signal = [RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]];
    [[signal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSDate * date) { //订阅
        LxDBAnyVar(date);
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
