//
//  SGHStartWithViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHStartWithViewController.h"
#import "UIViewController+Description.h"

@interface SGHStartWithViewController ()

@end

@implementation SGHStartWithViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *firstBtn = [self buildBtnWith:@"startWith:@\"wrwer\""];
    [firstBtn addTarget:self action:@selector(firstAction) forControlEvents:UIControlEventTouchUpInside];
    [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(150);
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(60);
    }];
    
    UIButton *secondBtn = [self buildBtnWith:@"先执行sendNext:@\"wrwer\""];
    [secondBtn addTarget:self action:@selector(secondAction) forControlEvents:UIControlEventTouchUpInside];
    [secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(firstBtn.mas_bottom).offset(20);
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(60);
    }];
    NSString *text = @"startWith:@\"wrwer\",相当于先其他`sendNext:`之前，先执行`sendNext:@\"wrwer\"`";
    [self showDescWith:text];
}

- (void)firstAction {
    RACSignal *signal=[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"rac"];
        [subscriber sendCompleted];
        return nil;
    }] startWith:@"wrwer"];
    
    LxPrintAnything(qwr);
    
    [signal subscribeNext:^(id x) {
        LxDBAnyVar(x);
    }];
}
- (void)secondAction {
    //上面的写法 相当于下面的 写法
    RACSignal *signal=[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@"wrwer"];
                
        [subscriber sendNext:@"rac"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    LxPrintAnything(qwr);
    
    [signal subscribeNext:^(id x) {
        LxDBAnyVar(x);
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
