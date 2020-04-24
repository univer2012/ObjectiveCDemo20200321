//
//  SGHWebViewConstrainsViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/4/27.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHWebViewConstrainsViewController.h"
#import "Masonry.h"

@interface SGHWebViewConstrainsViewController () <UIWebViewDelegate>
{
    NSInteger changeBig ;
    UIWebView *_webView;
}
@end

@implementation SGHWebViewConstrainsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    changeBig = 90;
    
    UILabel *titleLabel = ({
        UILabel *label = [UILabel new];
//        label.text = @"标题";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        [self.view addSubview:label];
        label;
    });
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        
    }];
    
    NSTextAttachment *attachMent = [NSTextAttachment new];
    attachMent.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://220.178.81.210:8001/upload/20160427/20160427135038422.jpg"]]];
    //[UIImage imageNamed:@"inform_menu_selected"];
    NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:attachMent];
    titleLabel.attributedText = str;
    
    //webView
    _webView = ({
        UIWebView *webView = [UIWebView new];
        webView.backgroundColor = [UIColor redColor];
        [self.view addSubview:webView];
        webView;
    });
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.left.equalTo(self.view);
//        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
#if 0
    NSURL* url = [NSURL URLWithString:@"http://www.baidu.com"];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
#endif
    
//    NSString *contentStr = [[NSBundle mainBundle]pathForResource:@"demo" ofType:@"html"];
    //要公司内网才可以加载出图片
//    NSString *contentStr = @"<p>标题：招财宝有新版本啦，快来体验吧。  <br>Android版本可自动升级体验，iOS版本稍后更新。 <br>如遇自动更新失败，请复制以下地址到浏览器重新下载安装 <a href=\"http://t.cn/RZkb4bq\">http://t.cn/RZkb4bq</a>。 </p><p><img src=\"http://220.178.81.210:8001/upload/20160427/20160427135038422.jpg\" border=\"0\" _ewebeditor_pa_src=\"%2Fupload%2F20160427%2F20160427135038422.jpg\"><br>本次升级内容： <br>1.	登录界面新增账户切换，账户太多记不住，账户切换助你快人一步登录系统； <br>2.	行情界面优化增加涨跌量展示； <br>3.	股票持仓展示优化，价格展示三位小数； <br>4.	解决股票预警功能失效，瞬息万变的价格你不再错过； <br>5.	手机可以开通月月红啦，白天炒股，闲置资金闭市买理财，24小时财富增值停不下来； <br>6.	解决消息推送无法查看详情； <br>7.	三方存管变更上线！换卡不用再跑营业部；    <br>8.	理财商城展示优化，增加申购日期； <br>9.	理财商城基金增加排序功能； <br>10.	理财商城增加查看收益率、净值、累计净值等数据；</p>";
    NSString *contentStr = @"<p>标题：招财宝有新版本啦，快来体验吧。  <br>Android版本可自动升级体验，iOS版本稍后更新。 <br>如遇自动更新失败，请复制以下地址到浏览器重新下载安装 <a href=\"http://t.cn/RZkb4bq\">http://t.cn/RZkb4bq</a>。 </p><p><img src=\"http://220.178.81.210:8001/upload/20160427/20160427135038422.jpg\" border=\"0\" _ewebeditor_pa_src=\"%2Fupload%2F20160427%2F20160427135038422.jpg\"><br>本次升级内容： <br>1.	登录界面新增账户切换，账户太多记不住，账户切换助你快人一步登录系统； <br>2.	行情界面优化增加涨跌量展示； <br>3.	股票持仓展示优化，价格展示三位小数； <br>4.	解决股票预警功能失效，瞬息万变的价格你不再错过； <br>5.	手机可以开通月月红啦，白天炒股，闲置资金闭市买理财，24小时财富增值停不下来； <br>6.	解决消息推送无法查看详情； <br>7.	三方存管变更上线！换卡不用再跑营业部；    <br>8.	理财商城展示优化，增加申购日期； <br>9.	理财商城基金增加排序功能； <br>10.	理财商城增加查看收益率、净值、累计净值等数据；\n\n你好，哈 哈  哈    哈\n\n!!!</p>";
    _webView.delegate = self;
    //替换换行
    contentStr = [[contentStr copy] stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    //替换空格
    contentStr = [contentStr stringByReplacingOccurrencesOfString:@" " withString:@"&emsp;"];
    //对图片中的空格 替换回来
    contentStr = [contentStr stringByReplacingOccurrencesOfString:@"<p><img&emsp;src=" withString:@"<p><img src="];
    
    [_webView  loadHTMLString:contentStr baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
    
    //按钮
    UIButton *button = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"点我" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(changeBig:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.equalTo(_webView.mas_bottom);
        make.bottom.equalTo(self.view);
        make.centerX.equalTo(self.view);
    }];
}

-(void)changeBig:(UIButton *)button {
    changeBig += 20;
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%ld%%'",changeBig]];
    [_webView reload];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    // 字体大小比例
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '90%'"];
    // 字体颜色
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'gray'"];
    // 背景色
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#2E2E2E'"];
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
