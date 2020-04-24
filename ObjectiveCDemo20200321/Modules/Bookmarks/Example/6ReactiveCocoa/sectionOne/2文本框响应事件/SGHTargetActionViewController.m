//
//  SGHTargetActionViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/30.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHTargetActionViewController.h"

@interface SGHTargetActionViewController ()

@end

@implementation SGHTargetActionViewController

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
    
#if 0
    //原始 写法
    //[textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
#elif 0
    //rac 写法1
    //对于所有UIControl 子类的对象，都可以这么做
    [[textField rac_signalForControlEvents:UIControlEventEditingChanged]subscribeNext:^(id x) {
        LxDBAnyVar(x);
    }];
#elif 0
    //rac 写法2
    [textField.rac_textSignal subscribeNext:^(id x) {
        //LxDBAnyVar(x);
        //其实 x 的类型是已知的。打印如下
        LxDBAnyVar([x class]);
        // [x class] = NSTaggedPointerString
        //实际上 它 就是NSString 的子类
    }];
    
#elif 1
    //rac 写法2  已知类型，改变如下：
    [textField.rac_textSignal subscribeNext:^(NSString *text) {
        LxDBAnyVar(text);
    }];

    
#endif
    
}

- (void)textChanged:(UITextField *)textField
{
    LxDBAnyVar(textField);
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
