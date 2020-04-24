//
//  SGH1012BecomeHtmlStringViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/10/12.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH1012BecomeHtmlStringViewController.h"
#import "SXNewsDetailEntity.h"
#import "SXDetailImgEntity.h"

@interface SGH1012BecomeHtmlStringViewController ()

//新闻详情实体
@property(nonatomic,strong) SXNewsDetailEntity *detailModel;

@property(nonatomic, strong)UIWebView *webView;

@end

@implementation SGH1012BecomeHtmlStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.webView = ({
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, screenSize.width, screenSize.height - 64)];
        webView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:webView];
        webView;
    });
    
    //请求数据
    
#if 0
    //网易新闻的一条详情新闻
    NSString *docId = @"C34SJPIE000146BE";
    NSString *tempUrl = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html", docId];
    [self p_requestForNewsDetailWithUrl:tempUrl result:^(NSDictionary *result) {
        self.detailModel = [SXNewsDetailEntity detailWithDict:result[docId]];
        [self.webView loadHTMLString:[self getHtmlString] baseURL:nil];
    }];
#elif 1
    //
    NSString *tempUrl = @"http://220.178.81.220:8981/servlet/json?funcNo=200030&id=313";
    [self p_requestForNewsDetailWithUrl:tempUrl result:^(NSDictionary *result) {
        
        NSDictionary *tempResultDict = [result[@"results"] objectAtIndex:0];
        self.detailModel = ({
            SXNewsDetailEntity *model = [SXNewsDetailEntity new];
            model.ptime = tempResultDict[@"updatetime"];
            model.title = tempResultDict[@"title"];
            model.body = tempResultDict[@"content"];
            model;
        });
        
        [self.webView loadHTMLString:[self getHtmlString] baseURL:nil];
    }];
    
#endif
    
    
}

//请求网络数据
-(void)p_requestForNewsDetailWithUrl:(NSString *)url result:(void (^)(NSDictionary *result))success {
    NSData *tempData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    id tempResult = [NSJSONSerialization JSONObjectWithData:tempData options:NSJSONReadingMutableLeaves error:nil];
    success(tempResult);
}


- (NSString *)getHtmlString
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"SXDetails.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body style=\"background:#ffffff\">"];//f6f6f6
    [html appendString:[self getBodyString]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    return html;
}

- (NSString *)getBodyString
{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.detailModel.title];
    [body appendFormat:@"<div class=\"time\">%@</div>",self.detailModel.ptime];
    
    if (self.detailModel.body != nil) {
        [body appendString:self.detailModel.body];
    }
    //文章中的图片
    for (SXDetailImgEntity *detailImgModel in self.detailModel.img) {
        NSMutableString *imgHtml = [NSMutableString string];
        // 设置img的div --- 1
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        //获取图片像素宽高
        NSArray *pixel = [detailImgModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            width = maxWidth;
            height = maxWidth / width * height;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx://github.com/dsxNiubility?src=' +this.src+'&top=' + this.getBoundingClientRect().top + '&whscale=' + this.clientWidth/this.clientHeight ;"
        "};";
        // --- 2
        //detailImgModel.src  图片下载的地址
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload, width, height, detailImgModel.src];
        // --- 3
        [imgHtml appendString:@"</div>"];
        //替换body中，图片所处的位置 的字符串
        [body replaceOccurrencesOfString:detailImgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    
    return body;
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
