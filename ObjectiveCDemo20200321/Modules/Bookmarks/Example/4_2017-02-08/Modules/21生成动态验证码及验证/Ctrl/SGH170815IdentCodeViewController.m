//
//  SGH170815IdentCodeViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/8/15.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH170815IdentCodeViewController.h"
#import "SGH170815IdentCodeAuthView.h"

@interface SGH170815IdentCodeViewController ()<UITextFieldDelegate, UIAlertViewDelegate>
{
    UITextField *_input;
    SGH170815IdentCodeAuthView *authCodeView;
}

@end

@implementation SGH170815IdentCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //显示验证码界面
    authCodeView = [[SGH170815IdentCodeAuthView alloc] initWithFrame:CGRectMake(30, 100, self.view.frame.size.width-60, 40)];
    [self.view addSubview:authCodeView];
    
    //提示文字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 160, self.view.frame.size.width-100, 40)];
    label.text = @"点击图片换验证码";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    //添加输入框
    _input = [[UITextField alloc] initWithFrame:CGRectMake(30, 220, self.view.frame.size.width-60, 40)];
    _input.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _input.layer.borderWidth = 2.0;
    _input.layer.cornerRadius = 5.0;
    _input.font = [UIFont systemFontOfSize:21];
    _input.placeholder = @"请输入验证码!";
    _input.clearButtonMode = UITextFieldViewModeWhileEditing;
    _input.backgroundColor = [UIColor clearColor];
    _input.textAlignment = NSTextAlignmentCenter;
    _input.returnKeyType = UIReturnKeyDone;
    _input.delegate = self;
    [self.view addSubview:_input];
}

#pragma mark 输入框代理，点击return 按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //判断输入的是否为验证图片中显示的验证码
    if ([_input.text isEqualToString:authCodeView.authCodeString])
    {
        //正确弹出警告款提示正确
        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"恭喜您 ^o^" message:@"验证成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alview show];
    }
    else
    {
        //验证不匹配，验证码和输入框抖动
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20,@20,@-20];
        //        [authCodeView.layer addAnimation:anim forKey:nil];
        [_input.layer addAnimation:anim forKey:nil];
    }
    
    return YES;
}

#pragma mark 警告框中方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //清空输入框内容，收回键盘
    if (buttonIndex==0)
    {
        _input.text = @"";
        [_input resignFirstResponder];
    }
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
