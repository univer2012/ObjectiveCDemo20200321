//
//  SHCommonToolVC.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/15.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHCommonToolVC.h"

#import <messageUI/MessageUI.h>

@interface SHCommonToolVC ()<MFMessageComposeViewControllerDelegate/*短信*/,MFMailComposeViewControllerDelegate/*邮件*/>

@property(nonatomic,strong)UIWebView *webView;

@end

@implementation SHCommonToolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#if 1
    /* ============================== 打电话： VV
     创建一个成员变量UIWebView来加载URL，拨完后能自动回到原应用        */
    //    UIWebViewController *webView = [[UIWebViewController alloc]init];
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    [_webView loadRequest: [NSURLRequest requestWithURL: [NSURL URLWithString: @"tel:15019471383"] ]];
    //[NSURL URLWithString: @"tel://电话号码"] //   // tel:13534268291
    //需要注意的是：这个webView千万不要添加到界面上来，不然会挡住其他界面
#elif 0
    
    //---------============================
    /* 发短信： VV
     • 如果想指定短信内容，那就得使用MessageUI框架
     • 包含主头文件
     #import <MessageUI/MessageUI.h>        */
    MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc] init];
    // 设置短信内容
    vc.body = @"短信内容";
    
    // 设置收件人列表
    vc.recipients = @[@"号码1", @"号码2"];
    // 设置代理
    vc.messageComposeDelegate = self;
    // 显示控制器
    [self presentViewController:vc animated:YES completion:nil];
    
#elif 0
    //=======================发邮件 VV
    // 不能发邮件
    //    if (![MFMailComposeViewController canSendMail]) return;
    MFMailComposeViewController *vc = [[MFMailComposeViewController alloc] init];
    //************************ 设置邮件内容 ************************
    // 设置邮件主题
    [vc setSubject:@"主题"];
    // 设置邮件内容
    [vc setMessageBody:@"邮件内容" isHTML:NO];
    // 设置收件人列表
    [vc setToRecipients:@[@"收件人@qq.com"]];
    // 设置抄送人列表
    [vc setCcRecipients:@[@"抄送人@qq.com"]];
    // 设置密送人列表
    [vc setBccRecipients:@[@"密送人@qq.com"]];
    
    // 添加附件（例如：一张图片）
    UIImage *image = [UIImage imageNamed:@"图片.jpeg"];
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    [vc addAttachmentData:data mimeType:@"image/jpeg" fileName:@"lufy.jpeg"];
    // 设置代理
    vc.mailComposeDelegate = self;
    // 显示控制器
    [self presentViewController:vc animated:YES completion:nil];
#elif 0
    
    /* 打开其他常见文件     VV
     如果想打开一些常见文件，比如html、txt、PDF、PPT等，都可以使用UIWebView打开
     只需要告诉UIWebView文件的URL即可
     至于打开一个远程的共享资源，比如http协议的，也可以调用系统自带的Safari浏览器：           */
    //创建需要打开的 URL 地址
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    [[UIApplication sharedApplication] openURL:url];
#endif
    
}
//代理方法，当短信界面关闭的时候调用，发完后会自动回到原应用
- (void)messageComposeViewController:(MFMessageComposeViewController*)controller didFinishWithResult:(MessageComposeResult)result {
    // 关闭短信界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    if(result == MessageComposeResultCancelled) {
        NSLog(@"取消发送");
    } else if(result == MessageComposeResultSent) {
        NSLog(@"已经发出");
    } else {
        NSLog(@"发送失败");
    }
}

//邮件发送后的代理方法回调，发完后会自动回到原应用
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // 关闭邮件界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    if(result == MFMailComposeResultCancelled) {
        NSLog(@"取消发送");
    } else if(result == MFMailComposeResultSent) {
        NSLog(@"已经发出");
    } else {
        NSLog(@"发送失败");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
