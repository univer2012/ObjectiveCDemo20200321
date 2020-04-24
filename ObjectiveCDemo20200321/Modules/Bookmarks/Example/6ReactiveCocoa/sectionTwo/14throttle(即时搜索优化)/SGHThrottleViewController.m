//
//  SGHThrottleViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHThrottleViewController.h"
#import "UIViewController+Description.h"

@interface SGHThrottleViewController ()

@end

@implementation SGHThrottleViewController

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
    
    NSString *text = @"throttle  [ˈθrɒtl] vt. 节流" \
    "\n\n当 rac_textSignal 发出信号之后，它会等0.3秒。"\
    "\n\n如果在0.3秒内，rac_textSignal 又发了一条消息，它会从新的信号发出时开始计时，"\
    "\n\n一直到过了0.3秒，这个 rac_textSignal 仍然没发消息，这个订阅者 就收到消息了。";
    [self showDescWith:text];
    
    [[textField.rac_textSignal throttle:0.3] subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
        
        // 通常会把(即时搜索的)请求 写到这里来
    }];
    
    
    
    
    // 问:代码很难调
    //答：如果你不用RAC，你得写多少代码。代码越多，越容易出bug。
    
    
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
