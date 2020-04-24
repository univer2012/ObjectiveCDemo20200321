//
//  SGHDistinctUntilChangedViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHDistinctUntilChangedViewController.h"
#import "UIViewController+Description.h"

@interface SGHDistinctUntilChangedViewController ()

@end

@implementation SGHDistinctUntilChangedViewController

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
    NSString *text = @"distinct  [dɪˈstɪŋkt] adj. 明显的；独特的；清楚的；有区别的"\
    "\n\n改进1:" \
    "\n\ndistinctUntilChanged  --> 如果新的消息 和 上一个消息 完全一样，新的消息 就不发送";
    [self showDescWith:text];
    //
    
    [[[textField.rac_textSignal throttle:0.3] distinctUntilChanged] subscribeNext:^(id x) {
        
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
