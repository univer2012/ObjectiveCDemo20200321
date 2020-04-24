//
//  SGHDefineRACViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHDefineRACViewController.h"

@interface SGHDefineRACViewController ()

@end

@implementation SGHDefineRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 为什么没有  button setBackgroundColor:forState:  这个方法
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    
    @weakify(self);
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
       
        @strongify(self);
        make.size.mas_equalTo(CGSizeMake(180, 40));
        make.center.equalTo(self.view);
    }];
    RAC(button,backgroundColor) = [RACObserve(button, selected) map:^id(NSNumber *selected) {
        
        //LxDBAnyVar([selected class]);   // selected 的block里的类型改为id后输出为: [selected class] = __NSCFBoolean
        return [selected boolValue] ? [UIColor redColor] : [UIColor greenColor];
    }];
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
       
        x.selected=!x.selected;
    }];
    /*
     问：多个按钮呢？
     答：
     */
    
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
