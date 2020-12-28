//
//  SGHNaviteJSInteractionViewController.m
//  ObjectiveCDemo20200321
//
//  Created by blue on 2020/8/25.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHNaviteJSInteractionViewController.h"
#import <WebKit/WebKit.h>
@interface SGHNaviteJSInteractionViewController ()<WKScriptMessageHandler>

@property(nonatomic, strong) WKWebView *webView;

@end

@implementation SGHNaviteJSInteractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //! 为userContentController添加ScriptMessageHandler，并指明name
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"jsToOc"];

    //! 使用添加了ScriptMessageHandler的userContentController配置configuration
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;

    //! 使用configuration对象初始化webView
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    //设置代理用来获取加载状态等等信息...<WKUIDelegate,WKNavigationDelegate>
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];

    //加载本地html
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"login" ofType:@"js"];
    [_webView loadFileURL:[NSURL fileURLWithPath:filePath] allowingReadAccessToURL:[NSBundle mainBundle].resourceURL];
    // Do any additional setup after loading the view.
}


#pragma mark - WKScriptMessageHandler

//! WKWebView收到ScriptMessage时回调此方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([message.name caseInsensitiveCompare:@"jsToOc"] == NSOrderedSame) {
        [SGHNaviteJSInteractionViewController showAlertWithTitle:message.name message:message.body cancelHandler:nil];
    }
}



+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelHandler:(NSString *)cancelHandler {
    NSLog(@"%@, %@",title, message);
}

@end
