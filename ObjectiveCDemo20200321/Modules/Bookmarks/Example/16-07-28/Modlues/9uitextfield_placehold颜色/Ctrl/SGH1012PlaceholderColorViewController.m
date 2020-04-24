//
//  SGH1012PlaceholderColorViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/10/12.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH1012PlaceholderColorViewController.h"

@interface SGH1012PlaceholderColorViewController ()

@end

@implementation SGH1012PlaceholderColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    
    NSString *placeholderString = @"请输入用户名";
    UITextField *textField = ({
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width - 100, 40)];
        textField.center = CGPointMake(self.view.center.x, textField.center.y);
        textField.layer.cornerRadius = 4;
        textField.clipsToBounds = YES;
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        //textField.placeholder = @"";
        //更换 placeholder 的颜色
        UIColor *placeholderColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderString attributes:@{NSForegroundColorAttributeName: placeholderColor}];
        textField;
    });
    [self.view addSubview:textField];
    
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
