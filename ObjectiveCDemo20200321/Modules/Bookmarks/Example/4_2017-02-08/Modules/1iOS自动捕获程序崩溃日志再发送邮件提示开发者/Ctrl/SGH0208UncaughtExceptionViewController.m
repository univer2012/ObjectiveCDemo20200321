//
//  SGH0208UncaughtExceptionViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/2/8.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0208UncaughtExceptionViewController.h"
//倒计时
#import "UIButton+timeCountDown.h"

@interface SGH0208UncaughtExceptionViewController ()

@end

@implementation SGH0208UncaughtExceptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 100, 40);
        button.center = self.view.center;
        //[self.view addSubview:button];
        button.backgroundColor = [UIColor colorWithRed:84/255.0 green:180/255.0 blue:98/255.0 alpha:1.0f];
        [button addTarget:self action:@selector(p_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:button];
}

-(void)p_buttonClick:(UIButton *)button {
    [button startWithTime:5 title:@"获取验证码" countDownTitle:@"s" mainColor:[UIColor colorWithRed:84/255.0 green:180/255.0 blue:98/255.0 alpha:1.0f] countColor:[UIColor lightGrayColor]];
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
