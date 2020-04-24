//
//  SGHSkipWhileBlockViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHSkipWhileBlockViewController.h"
#import "UIViewController+Description.h"

@interface SGHSkipWhileBlockViewController ()

@end

@implementation SGHSkipWhileBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ///理解：当执行块返回YES时，才跳过
    [self showDescWith:@"skipWhileBlock: 返回YES时，就跳过；返回NO时，就接收消息"];
    
    UIButton *firstBtn = [self buildBtnWith:@"skipWhileBlock:^BOOL(id x) {return NO;}"];
    [firstBtn addTarget:self action:@selector(firstAction:) forControlEvents:UIControlEventTouchUpInside];
    firstBtn.tag = 1;
    [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(150);
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(60);
    }];
    
    UIButton *secondBtn = [self buildBtnWith:@"skipWhileBlock:^BOOL(id x) {return YES;}"];
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
        
    }] skipWhileBlock:^BOOL(id x) {
        if (btn.tag == 1) {
            return NO;
        }
        //返回YES时，就跳过；返回NO时，就接收消息
        return YES;// NO;
        
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
