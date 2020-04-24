//
//  SGHMapViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHMapViewController.h"

@interface SGHMapViewController ()

@end

@implementation SGHMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITextField *textField=[[UITextField alloc]init];
    textField.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:textField];
    
    @weakify(self);
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(CGSizeMake(180, 40));
        make.center.equalTo(self.view);
    }];
    
#if 0
    [[textField.rac_textSignal map:^id(id value) {
        LxDBAnyVar(value);
        
        return @"ewf";
        
    }] subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
    }];
    
#endif
    
    [[textField.rac_textSignal map:^id(NSString *text) {
        LxDBAnyVar(text);
        return @(text.length);
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
