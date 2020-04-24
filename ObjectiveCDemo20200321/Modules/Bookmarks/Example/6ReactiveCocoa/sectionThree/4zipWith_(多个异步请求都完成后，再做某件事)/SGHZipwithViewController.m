//
//  SGHZipwithViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHZipwithViewController.h"
#import "UIViewController+Description.h"

@interface SGHZipwithViewController ()

@end

@implementation SGHZipwithViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *text = @"结论1：可以看出，signalA 和signalB相互不影响 。但是 只有两者都完成了，订阅者才执行。"\
    "\n\n结论2：signalA 和 signalB 都至少发送一次消息时，zipWith: 才会执行。";
    [self showDescWith:text];
    
    RACSignal * signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //LxPrintAnything(a);
            NSLog(@"a = a");
            [subscriber sendNext:@"a"];
            [subscriber sendNext:@"a1"];
            [subscriber sendCompleted];
        });
        
        return nil;
    }];
    
    RACSignal * signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //LxPrintAnything(b);
            NSLog(@"b = b");
            [subscriber sendNext:@"b"];
            [subscriber sendNext:@"b1"];
            [subscriber sendCompleted];
        });
        
        return nil;
    }];
    
#if 0
//    [[[signalA zipWith:signalB] zipWith:signalC] subscribeNext:^(id x) {
//    }];
    
    NSLog(@"执行前");
    [[signalA zipWith:signalB] subscribeNext:^(id x) {
       
        LxDBAnyVar(x);  //
        NSLog(@"执行时%@",x);
        
    }];
    /*print:
     2016-01-31 12:31:59.737 RAC_test[32048:689973] 执行前
     2016-01-31 12:32:01.739 RAC_test[32048:689973] a = a
     2016-01-31 12:32:04.739 RAC_test[32048:689973] b = b
     2016-01-31 12:32:04.740 RAC_test[32048:689973] 执行时<RACTuple: 0x7fc208c0a7a0> (
     a,
     b
     )
     
     “执行前” 和 “a = a”相差2秒；
     “a = a” 和 “b = b”相差3秒。
     “b = b” 和 “执行时<RACTuple: 0x7fc208c0a7a0>” 相差0秒
     */
    /*问：如果A是5秒，B是2秒，会怎样？
    答：
     2016-01-31 12:36:56.713 RAC_test[32079:693240] 执行前
     2016-01-31 12:36:58.718 RAC_test[32079:693240] b = b
     2016-01-31 12:37:01.718 RAC_test[32079:693240] a = a
     2016-01-31 12:37:01.719 RAC_test[32079:693240] 执行时<RACTuple: 0x7fb7e2f8bf30>
     analyse:“执行前” 和 “b = b”相差2秒；
     “b = b” 和 “a = a”相差3秒。
     “a = a” 和 “执行时<RACTuple: 0x7fb7e2f8bf30>” 相差0秒。
     
     结论2的实验：
     注释掉signalA中的sendNext: 和 sendCompleted 方法，会得到下面的打印：
     2016-01-31 12:41:55.292 RAC_test[32110:695759] 执行前
     2016-01-31 12:41:57.295 RAC_test[32110:695759] b = b
     2016-01-31 12:42:00.295 RAC_test[32110:695759] a = a
     
     结论1：可以看出，signalA 和signalB相互不影响 。但是 只有两者都完成了，订阅者才执行。
     结论2：signalA 和 signalB 都至少发送一次消息时，zipWith: 才会执行。
     */
    
#elif 1
    //zipWith: 的另一种写法
    NSLog(@"执行前");
    //每个信号 至少发送过一个消息，才会执行订阅
    [[RACSignal combineLatest:@[signalA,signalB]] subscribeNext:^(id x) {
       
        LxDBAnyVar(x);
        NSLog(@"执行时%@",x);
        
    }];
    /*zipWith: 与  combineLatest: 的区别：
     zipWith: 如果signalA 发送了a,a1，signalB 发送了b,b1，那么[signalA zipWith:signalB] 会执行(a,b)、(a1,b1)组合，也就是执行2次。
     
     如果signalA 发送了a,a1，signalB 发送了b，那么[signalA zipWith:signalB] 会执行(a,b)组合，也就是执行1次。
     
     combineLatest: 如果signalA 发送了a,a1，signalB 发送了b,b1，那么[RACSignal combineLatest:@[signalA,signalB]] 会执行(a1,b)、(a1,b1)组合，也就是执行2次。 */
    
    
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
