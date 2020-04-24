//
//  SGH1013TextViewViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/10/13.
//  Copyright © 2016年 huangaengoln. All rights reserved.

#import "SGH1013TextViewViewController.h"

@interface SGH1013TextViewViewController ()

@property(nonatomic, strong)UITextView *textView;



@end

@implementation SGH1013TextViewViewController {
    double _fontNumber;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_setupTextView];
}

-(void)p_setupTextView {
    _textView = [[UITextView alloc] initWithFrame:self.view.bounds];
//    _textView.backgroundColor = [UIColor redColor];
    NSString *contentString;
#if 0
    NSString *tempString = @"<div id='lg' class='s-p-top'><img id='s_lg_img' src='https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/logo_white_fe6da1ec.png' width='270' height='129'>  </div>";
#elif 1
//    NSDictionary *tempDict = [self p_fecthWithUrl:@"http://220.178.81.220:8981/servlet/json?funcNo=200030&id=313"];
    NSDictionary *tempDict = [self p_fecthWithUrl:@"http://zmall.hazq.com:8981/servlet/json?funcNo=200001&id=498690126"];
    NSArray *resultsArray = tempDict[@"results"];
    NSDictionary *resultsDict = resultsArray[0];
    contentString = [self p_getHtmlStringWithDitc:resultsDict];
    //contentString = resultsDict[@"content"];
    
#endif
    
    contentString = [contentString stringByReplacingOccurrencesOfString:@"\n" withString:@"</br>"];
    contentString = [contentString stringByReplacingOccurrencesOfString:@"\r" withString:@"</br>"];
    
    
    
    NSData *tempData = [contentString dataUsingEncoding:NSUnicodeStringEncoding];
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:tempData options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    _textView.attributedText = attrStr;
    [self.view addSubview:_textView];
    
    
    
    //改变文字 大小
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(p_addFontNumber)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    _fontNumber = 12.0;
    _textView.font = [UIFont systemFontOfSize:_fontNumber];
    
    NSLog(@"_textView.contentSize : %@, _textView.contentOffset : %@", NSStringFromCGSize(_textView.contentSize), NSStringFromCGPoint(_textView.contentOffset));
}


- (NSString *)p_getHtmlStringWithDitc:(NSDictionary *)dict
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"SXDetails.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body style=\"background:#f6f6f6\">"];
    [html appendString:[self p_getBodyStringWithDict:dict]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    return html;
}

-(NSString *)p_getBodyStringWithDict:(NSDictionary *)dict {
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",dict[@"title"]];
    
    [body appendFormat:@"<div class=\"media\">%@</div>",dict[@"media"]];
    
    [body appendFormat:@"<div class=\"time\">%@</div>",dict[@"updatetime"]];
    
    [body appendString:dict[@"content"]];
    return body;
}

-(void)p_addFontNumber {
    _fontNumber = _fontNumber + 3;
    _textView.font = [UIFont systemFontOfSize:_fontNumber];
    
}

-(NSDictionary *)p_fecthWithUrl:(NSString *)url {
    NSData *tempData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    NSDictionary * tempResult = [NSJSONSerialization JSONObjectWithData:tempData options:NSJSONReadingMutableLeaves error:nil];
    return tempResult;
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
