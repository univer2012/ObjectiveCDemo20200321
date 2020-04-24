//
//  SGHTakeWhileBlockViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHTakeWhileBlockViewController.h"
#import "UIViewController+Description.h"

@interface SGHTakeWhileBlockViewController ()

@end

@implementation SGHTakeWhileBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ///理解：当执行块返回YES时，才take(拿)
    [self showDescWith:@"takeWhileBlock: 返回YES 时，你的订阅者 才能接收到消息"];
    
    UIButton *firstBtn = [self buildBtnWith:@"takeWhileBlock:^BOOL(id x) {return NO;}"];
    [firstBtn addTarget:self action:@selector(firstAction:) forControlEvents:UIControlEventTouchUpInside];
    firstBtn.tag = 1;
    [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(150);
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(60);
    }];
    
    UIButton *secondBtn = [self buildBtnWith:@"takeWhileBlock:^BOOL(id x) {return YES;}"];
    [secondBtn addTarget:self action:@selector(firstAction:) forControlEvents:UIControlEventTouchUpInside];
    secondBtn.tag = 2;
    [secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(firstBtn.mas_bottom).offset(20);
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(60);
    }];
    
    
}
- (void)firstAction:(UIButton *)btn {
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"rac1"];
        [subscriber sendNext:@"rac2"];
        [subscriber sendNext:@"rac3"];
        [subscriber sendNext:@"rac4"];
        [subscriber sendCompleted];
        return nil;
        
    }] takeWhileBlock:^BOOL(id x) {
        if (btn.tag == 1) {
            return NO;
        }
        //返回YES 时，你的订阅者 才能接收到消息
        return YES;//NO;
    }] subscribeNext:^(id x) {
      
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
