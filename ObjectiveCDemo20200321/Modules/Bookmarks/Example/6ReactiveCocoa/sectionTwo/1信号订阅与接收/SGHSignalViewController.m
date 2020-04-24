//
//  SGHSignalViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHSignalViewController.h"
#import "UIViewController+Description.h"

@interface SGHSignalViewController ()

@property (nonatomic, strong)RACDisposable *thirdDisposable;

@end

@implementation SGHSignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *firstBtn = [self buildBtnWith:@"第一种return nil,sendNext and sendCompleted"];
    firstBtn.tag = 1;
    [firstBtn addTarget:self action:@selector(firstAction:) forControlEvents:UIControlEventTouchUpInside];
    [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(60);
    }];
    
    UIButton *first2Btn = [self buildBtnWith:@"第一种return nil sendError"];
    first2Btn.tag = 2;
    [first2Btn addTarget:self action:@selector(firstAction:) forControlEvents:UIControlEventTouchUpInside];
    [first2Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstBtn.mas_bottom).offset(20);
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(60);
    }];
    
    UIButton *secondBtn = [self buildBtnWith:@"第二种return RACDisposable"];
    [secondBtn addTarget:self action:@selector(secondAction) forControlEvents:UIControlEventTouchUpInside];
    [secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(first2Btn.mas_bottom).offset(20);
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(60);
    }];
    
    UIButton *thirdBtn = [self buildBtnWith:@"第三种"];
    [thirdBtn addTarget:self action:@selector(thirdAction) forControlEvents:UIControlEventTouchUpInside];
    [thirdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.leading.equalTo(self.view).offset(20);
        make.centerX.equalTo(self.view);
        make.top.equalTo(secondBtn.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(60);
    }];
    
}

- (void)firstAction:(UIButton *)btn {
    //第1种 返回
    RACSignal *signal=[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       //request
        if (btn.tag == 1) {
            //第1种
            [subscriber sendNext:@"reponse"];
            [subscriber sendNext:@"reponse2"];
            //第2种
            [subscriber sendCompleted];
        } else if (btn.tag == 2) {
            //第3种   request error
            [subscriber sendError:[NSError errorWithDomain:@"domain" code:214 userInfo:@{}]];
        }
        // 第1种 返回nil
        return nil;
    }];
    
    //完整的 订阅信号
    [signal subscribeNext:^(id x) {
        // x 就是 sendNext: 后面的参数
        LxDBAnyVar(x);
        
    } error:^(NSError *error) {
        
        LxDBAnyVar(error);
        
    } completed:^{
        
        LxPrintAnything(completed);
        
    }];
}

- (void)secondAction {
    // 第2种 返回 取消订阅
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //request
        [subscriber sendNext:@"reponse2"];
        [subscriber sendCompleted];
        
        // 第1种 返回RACDisposable
        return [RACDisposable disposableWithBlock:^{
            //cancel request
            NSLog(@"执行Disposable block");
        }];
        
    }];
    //完整的 订阅信号
    RACDisposable *disposable = [signal subscribeNext:^(id x) {
        // x 就是 sendNext: 后面的参数
        LxDBAnyVar(x);
        
    } error:^(NSError *error) {
        
        LxDBAnyVar(error);
        
    } completed:^{
        
        LxPrintAnything(completed);
        
    }];
    //Performs the disposal work. Can be called multiple times, though subsequent calls won't do anything.
    [disposable dispose];
}

- (void)thirdAction {
    //另一种 写法
    /// 原代码
//    RACSignal *signal = [[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil];
//    RACDisposable *dispose = [signal subscribeNext:^(NSNotification * notification) {
//           LxDBAnyVar(notification);
//       }];
//   [dispose dispose];
    
    /// 修复「原代码」中，监听后马上「dispose」，导致f无法响应监听事件的问题
    RACSignal *signal = [[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil];
    
    self.thirdDisposable = [signal subscribeNext:^(NSNotification * notification) {
        LxDBAnyVar(notification);
    }];
}
- (void)dealloc
{
    [self.thirdDisposable dispose];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
