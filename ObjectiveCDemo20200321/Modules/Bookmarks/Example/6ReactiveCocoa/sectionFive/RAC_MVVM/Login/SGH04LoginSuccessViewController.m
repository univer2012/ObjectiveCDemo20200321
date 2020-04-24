//
//  SGH04LoginSuccessViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/4.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGH04LoginSuccessViewController.h"

@interface SGH04LoginSuccessViewController ()
@property (strong, nonatomic) IBOutlet UILabel *userInfoLabel;

@end

@implementation SGH04LoginSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userInfoLabel.text = [NSString stringWithFormat:@"用户名：%@,  密码：%@", _userName, _password];
}

- (IBAction)tapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
