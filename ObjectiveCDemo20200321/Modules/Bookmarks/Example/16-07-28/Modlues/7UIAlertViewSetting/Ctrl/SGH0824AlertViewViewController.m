//
//  SGH0824AlertViewViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/8/24.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0824AlertViewViewController.h"

@interface SGH0824AlertViewViewController ()<UIAlertViewDelegate>

@end

@implementation SGH0824AlertViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
#if 0
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 21)];
    
    label.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:label];
    
    
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"TViewController"];
    
    //计算文字大小，参数一定要符合相应的字体和大小
    
    CGSize attributeSize = [attributeString.string sizeWithAttributes:@{NSFontAttributeName:label.font}];
    
    //计算字符间隔
    
    CGSize frame = label.frame.size;
    
    NSNumber *wordSpace = [NSNumber numberWithInt:(frame.width-attributeSize.width)/(attributeString.length-1)];
    
    //添加属性
    
    [attributeString addAttribute:NSKernAttributeName value:wordSpace range:NSMakeRange(0, attributeString.length)];
    
    
    
    label.attributedText = attributeString;
#endif
    
    
}
- (IBAction)p_showAlertView:(id)sender {
//    NSString *content = @"<p>标题：招财宝有新版本啦，快来体验吧。  <br>Android版本可自动升级体验，iOS版本稍后更新。 <br>如遇自动更新失败，请复制以下地址到浏览器重新下载安装 <a href=\"http://t.cn/RZkb4bq\">http://t.cn/RZkb4bq</a>。 </p><p><img src=\"/upload/20160427/20160427135038422.jpg\" border=\"0\" _ewebeditor_pa_src=\"%2Fupload%2F20160427%2F20160427135038422.jpg\"><br>本次升级内容： <br>1.	登录界面新增账户切换，账户太多记不住，账户切换助你快人一步登录系统； <br>2.	行情界面优化增加涨跌量展示； <br>3.	股票持仓展示优化，价格展示三位小数； <br>4.	解决股票预警功能失效，瞬息万变的价格你不再错过； <br>5.	手机可以开通月月红啦，白天炒股，闲置资金闭市买理财，24小时财富增值停不下来； <br>6.	解决消息推送无法查看详情； <br>7.	三方存管变更上线！换卡不用再跑营业部；    <br>8.	理财商城展示优化，增加申购日期； <br>9.	理财商城基金增加排序功能； <br>10.	理财商城增加查看收益率、净值、累计净值等数据；\n\n你好，哈 哈  哈    哈\n\n!!!</p>";
    NSString *title = @"消息推送测试<br>消息推送测试";
    
    NSString *content = @"消息推送测试<br>消息推送测试";
//    NSString *title = @"温馨提示";
    
    /*   对message的处理   */
    NSMutableAttributedString *muatbleAttrContent = [[NSMutableAttributedString alloc]initWithData:[content  dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    [muatbleAttrContent addAttributes:@{NSForegroundColorAttributeName : [UIColor redColor],NSFontAttributeName : [UIFont systemFontOfSize:17],NSParagraphStyleAttributeName : paragraphStyle }
                              range:NSMakeRange(0, muatbleAttrContent.length)];
//    [muatbleAttrContent addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, muatbleAttrContent.length)];
    //systemFontSize
    
    /*  对title的处理  */
    NSMutableAttributedString *muatbleAttrTitle = [[NSMutableAttributedString alloc]initWithData:[title  dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    NSMutableParagraphStyle *paragraphStyleTitle = [NSMutableParagraphStyle new];
    paragraphStyleTitle.alignment = NSTextAlignmentCenter;
    [muatbleAttrTitle addAttributes:@{                                               NSFontAttributeName : [UIFont systemFontOfSize:20],NSParagraphStyleAttributeName : paragraphStyleTitle} range:NSMakeRange(0, muatbleAttrTitle.length)];
    
#if 1
    
    content = [muatbleAttrContent string];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:[muatbleAttrTitle string] message:content delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alertView.alertViewStyle = UIAlertViewStyleDefault;
    //改变alertView按钮的颜色 --同时改变
    [[UIView appearance] setTintColor:[UIColor redColor]];
    //[[UIView appearanceWhenContainedInInstancesOfClasses:@[[UIAlertView class]]] setTintColor:[UIColor redColor]];
    //[[UIView appearanceWhenContainedIn:[UIAlertView class], nil] setTintColor:[UIColor redColor]];
    
    [alertView show];
    
#if 1
    UILabel *textLabel = [UILabel new];
    textLabel.textColor = [UIColor blackColor];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    textLabel.numberOfLines = 0 ;
//    textLabel.textAlignment = NSTextAlignmentLeft;
    textLabel.text = content;
//    textLabel.attributedText = muatbleAttrContent;
    [alertView setValue:textLabel forKey:@"accessoryView"];
    
    alertView.message =@"";
#endif
    
    
    
#else
    
    
    
    
    
    
    //如果是8.0以上的版本
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAcion = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"action1 : %@", action);
            
        }];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"action2 : %@", action);
        }];
        [alertController addAction:cancelAcion];
        [alertController addAction:defaultAction];
        //对title的设置 --可注释后对比
        [alertController setValue:muatbleAttrTitle forKey:@"attributedTitle"];
        //对message的设置 --可注释后对比
        [alertController setValue:muatbleAttrContent forKey:@"attributedMessage"];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
#endif
    
#endif
    
    
    
    

}

#pragma mark - UIAlertViewDelegate
-(void)willPresentAlertView:(UIAlertView *)alertView {
    NSLog(@"alertView.subviews.count : %ld", alertView.subviews.count);
    for (UIView *view in alertView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.textAlignment = NSTextAlignmentLeft;
        }
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
