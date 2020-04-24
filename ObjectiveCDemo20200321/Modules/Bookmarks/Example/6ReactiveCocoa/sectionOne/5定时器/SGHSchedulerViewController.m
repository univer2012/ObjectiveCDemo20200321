//
//  SGHSchedulerViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/30.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//
/*
 * 参考：[iOS】【ReactiveCocoa】[RACSignal interval]定时器](https://my.oschina.net/onepieceios/blog/744880)
 */
#import "SGHSchedulerViewController.h"

@interface SGHSchedulerViewController ()

@end

@implementation SGHSchedulerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //下面这个宏，打印什么，就输出什么
    LxPrintAnything(faejfo je;false);
    
    //定时器：
    //常用两种：
#if 0
    //1. 延迟某个时间后再做某件事
    [[RACScheduler mainThreadScheduler]afterDelay:2 schedule:^{
        
        LxPrintAnything(rac);
    }];
#elif 0
    //2. 每隔一定长度时间做一件事
    //下面代码 输出，当前时间
    ///有个致命问题：pop后不会自动停止计时
//    [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]]subscribeNext:^(NSDate * date) {
//        LxDBAnyVar(date);
//    }];
#elif 1
    /// 对上面问题的优化：
    [[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSDate * date) {
        LxDBAnyVar(date);
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
