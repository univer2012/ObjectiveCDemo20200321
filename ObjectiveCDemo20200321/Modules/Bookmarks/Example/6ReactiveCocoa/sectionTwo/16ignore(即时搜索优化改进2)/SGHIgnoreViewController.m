//
//  SGHIgnoreViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHIgnoreViewController.h"
#import "UIViewController+Description.h"

@interface SGHIgnoreViewController ()

@end

@implementation SGHIgnoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITextField * textField = [[UITextField alloc]init];
    textField.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:textField];
    
    @weakify(self); //  __weak __typeof__(self) self_weak_ = self;
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self);   //  __strong __typeof__(self) self = self_weak_;
        make.size.mas_equalTo(CGSizeMake(180, 40));
        make.center.equalTo(self.view);
    }];
    
    ///理解：有区别的，直到改变了
    NSString *text = @"改进2:" \
    "\n\n空字符串 实际上 就没有必要发送给服务器";
    [self showDescWith:text];
    //
    
    [[[[textField.rac_textSignal throttle:0.3] distinctUntilChanged] ignore:@""] subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
        
        // 通常会把(即时搜索的)请求 写到这里来
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
