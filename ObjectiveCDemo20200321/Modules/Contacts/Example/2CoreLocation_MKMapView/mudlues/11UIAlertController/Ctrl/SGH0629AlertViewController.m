//
//  SGH0629AlertViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/6/29.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0629AlertViewController.h"

@interface SGH0629AlertViewController ()

@end

@implementation SGH0629AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *alertTitleString = @"标题";
    NSString *alertMessageString = @"消息推送测试<br>消息推送测试";//@"这个是UIAlertController";
    
    NSMutableAttributedString *muatbleAttrTitle = [[NSMutableAttributedString alloc]initWithData:[alertMessageString  dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    alertMessageString = [muatbleAttrTitle string];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitleString message:alertMessageString preferredStyle:UIAlertControllerStyleAlert];
    
    /**
     *	@author hsj, 16-06-29 16:06:24
     *
     *	添加按钮
     */
#if 1
    UIAlertAction *cancelAcion = [UIAlertAction actionWithTitle:@"取消Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"默认Default" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"重置Destructive" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:cancelAcion];
    [alertController addAction:defaultAction];
    [alertController addAction:resetAction];
    
    ///标题和提示内容的文字设置
    /* ----------- 修改title -------------- */
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc]initWithString:alertTitleString];
    //红色
    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, alertTitleString.length)];
    //大小为17
    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, alertTitleString.length)];
    [alertController setValue:alertControllerStr forKey:@"attributedTitle"];
    
    /* ---------- 修改message --------------- */
    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc]initWithString:alertMessageString];
#if 0
    //颜色为绿色
    [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, alertMessageString.length)];
    //字体大小为20
    [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, alertMessageString.length)];
    //左对齐
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [alertControllerMessageStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, alertMessageString.length)];
#else
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    [alertControllerMessageStr addAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor],
                                               NSFontAttributeName : [UIFont systemFontOfSize:20],
                                               NSParagraphStyleAttributeName : paragraphStyle
                                               }
                                       range:NSMakeRange(0, alertMessageString.length)];
#endif
    
    [alertController setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    
   
    //修改按钮
    [cancelAcion setValue:[UIColor redColor] forKey:@"titleTextColor"];
    
#endif
    
#if 0
    UIAlertAction *getAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *login = alertController.textFields[0];
        UITextField *password = alertController.textFields[1];
        [self.view endEditing:YES];
        
        NSLog(@"登录:%@, 密码:%@", login.text, password.text);
    }];
    [alertController addAction:getAction];
#endif
    
    
    
#if 0
    //添加文本输入框，以登录和密码对话框实例
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
       textField.placeholder = @"登录";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder = @"密码";
        textField.secureTextEntry = YES;
    }];
    
    //如果要监听UITextField开始，结束，改变状态，则需要添加监听代码
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder = @"添加监听代码";
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(p_alertTextFiledDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
#endif
    
    
    //弹出视图，使用UIViewController的方法
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}
-(void)p_alertTextFiledDidChange:(NSNotification *)notification {
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    
    if (alertController) {
        
        //下标为2的是添加了监听的  也是最后一个 alertController.textFields.lastObject
        UITextField *listen = alertController.textFields[2];
        
        //限制，如果listen输入长度要限制在5个字内，否则不允许点击默认Default键
        //当UITextField输入字数超过5个是按钮变灰色enabled为NO
        UIAlertAction *action = alertController.actions.lastObject;
        action.enabled = listen.text.length <= 5;
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
