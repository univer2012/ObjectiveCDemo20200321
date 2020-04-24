//
//  SGH04RACLoginViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/4.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGH04RACLoginViewController.h"
#import "SGH04RACViewModel.h"
#import "SGH04LoginSuccessViewController.h"


typedef void(^SignInRespongse)(BOOL result);

@interface SGH04RACLoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic, strong) SGH04RACViewModel *viewModel;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation SGH04RACLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindModel];
    
    [self onClick];
}

//关联ViewModel
- (void)bindModel {
    _viewModel = [[SGH04RACViewModel alloc] init];
    
    RAC(self.viewModel, userName) = self.userNameTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    RAC(self.loginButton, enabled) = [_viewModel buttonIsValid];
    
    @weakify(self)
    
    //登录成功要处理的方法
    [self.viewModel.successObject subscribeNext:^(NSArray * _Nullable x) {
        @strongify(self)
        SGH04LoginSuccessViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SGH04LoginSuccessViewController"];
        vc.userName = x[0];
        vc.password = x[1];
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }];
    
    //fail
    [self.viewModel.failureObject subscribeNext:^(id  _Nullable x) {
        
    }];
    
    //error
    [self.viewModel.errorObject subscribeNext:^(id  _Nullable x) {
        
    }];
    
}

- (void)onClick {
    @weakify(self)
    //按钮点击事件
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.viewModel login];
    }];
}

- (IBAction)tapGestureRecognizer:(id)sender {
    [self.view endEditing:YES];
}

@end
