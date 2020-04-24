//
//  SGHTimeoutViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHTimeoutViewController.h"
#import "UIViewController+Description.h"

@interface SGHTimeoutViewController ()

@end

@implementation SGHTimeoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *firstBtn = [self buildBtnWith:@"在超时时间内"];
    [firstBtn addTarget:self action:@selector(firstAction) forControlEvents:UIControlEventTouchUpInside];
    [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(150);
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(60);
    }];
    
    UIButton *secondBtn = [self buildBtnWith:@"超出 超时时间"];
    [secondBtn addTarget:self action:@selector(secondAction) forControlEvents:UIControlEventTouchUpInside];
    [secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(firstBtn.mas_bottom).offset(20);
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(60);
    }];
    
    [self showDescWith:@"超时后 ，sendNext:方法 就不处理了。"];
    
}
- (void)firstAction {
    // 超时后 ，sendNext:方法 就不处理了。
    /// 延时1秒后才 `sendNext:@"rac"`，否则超时2秒后就报错
    NSLog(@"执行前");
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
            [subscriber sendNext:@"rac"];
            [subscriber sendCompleted];
        }];
        return nil;
        
    }] timeout:2 onScheduler:[RACScheduler mainThreadScheduler]]
    subscribeNext:^(id x) {
        NSLog(@"执行subscribeNext");
        LxDBAnyVar(x);
    } error:^(NSError *error) {
        NSLog(@"执行报错");
        LxDBAnyVar(error);
    } completed:^{
        LxPrintAnything(completed);
        NSLog(@"执行完成");
    }];
}
- (void)secondAction {
    // 超时后 ，sendNext:方法 就不处理了。
    /// 延时3秒后才 `sendNext:@"rac"`，否则超时2秒后就报错
    NSLog(@"执行前");
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[RACScheduler mainThreadScheduler] afterDelay:3 schedule:^{
            [subscriber sendNext:@"rac"];
            [subscriber sendCompleted];
        }];
        return nil;
        
    }] timeout:2 onScheduler:[RACScheduler mainThreadScheduler]]
    subscribeNext:^(id x) {
        NSLog(@"执行subscribeNext");
        LxDBAnyVar(x);
    } error:^(NSError *error) {
        NSLog(@"执行报错");
        LxDBAnyVar(error);
    } completed:^{
        LxPrintAnything(completed);
        NSLog(@"执行完成");
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
