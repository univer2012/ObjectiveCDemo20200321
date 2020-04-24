//
//  SGHCoreText2ViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/3/23.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHCoreText2ViewController.h"
#import "CTDisplayView.h"
#import "CTFrameParserConfig.h"
#import "CTFrameParser.h"

@interface SGHCoreText2ViewController ()

@property (weak, nonatomic) IBOutlet CTDisplayView *ctView;

@end

@implementation SGHCoreText2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#if 0
    CTFrameParserConfig *config=[[CTFrameParserConfig alloc]init];
    config.textColor=[UIColor blackColor];
    config.width=self.ctView.width;
    
    NSString *content=@"对于上面的例子，我们给CTFrameParser增加了一个将NSString转"
    "换为CoreTextData的方法。"
    "但这样的实现方式有很多局限性，因为整个内容虽然可以定制字体"
    "大小、颜色、行高等信息，但是却不能试吃定制内容汇总的某一部分。"
    "例如，如果我们只想让内容的前三个显"
    "示成红色，而让其他文字显示成黑色，那么就办不到了。"
    "\n\n"
    "解决的办法很简单，我们让CTFrameParser支持接收"
    "NSAttributeString作为参数，然后在ViewController类中设置"
    "我们想要的NSAttributeString信息。";
    
    NSDictionary *attr=[CTFrameParser attributesWithConfig:config];
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc]initWithString:content attributes:attr];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 7)];

    CoreTextData *data=[CTFrameParser parseContent:[attributedString string] config:config];
    self.ctView.data=data;
    self.ctView.height=data.height;
    self.ctView.backgroundColor=[UIColor yellowColor];
#elif 1
    CTFrameParserConfig *config=[[CTFrameParserConfig alloc]init];
    config.width=self.ctView.width;
    NSLog(@"config : %@",config);
    NSString *path=[[NSBundle mainBundle] pathForResource:@"demo2_content" ofType:@"json"];
    CoreTextData *data=[CTFrameParser parseTemplateFile:path config:config];
    self.ctView.data=data;
    self.ctView.height=data.height;
    self.ctView.backgroundColor = [UIColor whiteColor];
    
#endif
}


@end
