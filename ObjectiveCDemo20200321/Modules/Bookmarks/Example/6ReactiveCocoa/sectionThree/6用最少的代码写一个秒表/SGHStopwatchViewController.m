//
//  SGHStopwatchViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHStopwatchViewController.h"

@interface SGHStopwatchViewController ()

@end

@implementation SGHStopwatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //写一个秒表
    UILabel *label=[UILabel new];
    label.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:label];
    
    @weakify(self);
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
       
        @strongify(self);
        make.size.mas_equalTo(CGSizeMake(240, 40));
        make.center.equalTo(self.view);
    }];
    
    RAC(label,text) = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] map:^id(NSDate *value) {
        
        return value.description;
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
