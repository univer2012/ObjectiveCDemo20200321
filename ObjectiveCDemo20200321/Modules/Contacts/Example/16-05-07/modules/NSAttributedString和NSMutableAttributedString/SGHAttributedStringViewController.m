//
//  SGHAttributedStringViewController.m
//  ObjectiveCDemo
//
//  Created by huangaengoln on 16/4/6.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHAttributedStringViewController.h"

@implementation SGHAttributedStringViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * aLable = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(4, 68, 200, 40)];
        label.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
//        label.center = self.view.center;
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        label;
    });
    NSString * aString = @"¥150 元/位";
     //富文本对象
    NSMutableAttributedString * aAttributedString = [[NSMutableAttributedString alloc] initWithString:aString];
    
    
    // ========== 富文本样式
    //文字颜色
    [aAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 4)];
    //文字字体
    [aAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, 4)];
   
    aLable.attributedText = aAttributedString;
    
#if 0
     [段落样式－插曲]
     @property(readwrite) CGFloat lineSpacing;　　　　　　　　　　　　　　//行间距
     @property(readwrite) CGFloat paragraphSpacing;　　　　　　　　　　　//段间距
     @property(readwrite) NSTextAlignment alignment;　　　　　　　　　　 //对齐方式
     @property(readwrite) CGFloat firstLineHeadIndent;　　　　　　　　　 //首行缩紧
     @property(readwrite) CGFloat headIndent;　　　　　　　　　　　　　　 //除首行之外其他行缩进
     @property(readwrite) CGFloat tailIndent;　　　　　　　　　　　　　　 //每行容纳字符的宽度
     @property(readwrite) NSLineBreakMode lineBreakMode;　　　　　　　  //换行方式
     @property(readwrite) CGFloat minimumLineHeight;　　　　　　　　　　 //最小行高
     @property(readwrite) CGFloat maximumLineHeight;　　　　　　　　　　 //最大行高
     @property(readwrite) NSWritingDirection baseWritingDirection;　　//书写方式（NSWritingDirectionNatural，NSWritingDirectionLeftToRight，NSWritingDirectionRightToLeft）
     @property(readwrite) CGFloat lineHeightMultiple;
     @property(readwrite) CGFloat paragraphSpacingBefore;
    @property(readwrite) float hyphenationFactor;
    @property(readwrite,copy,NS_NONATOMIC_IOSONLY) NSArray *tabStops NS_AVAILABLE_IOS(7_0);
    @property(readwrite,NS_NONATOMIC_IOSONLY) CGFloat defaultTabInterval NS_AVAILABLE_IOS(7_0);
#endif
    // lable.numberOfLines必须为0，段落样式才生效
    /*=======================段落样式===========================*/
    UILabel *label = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 150, self.view.frame.size.width - 100, 200)];
        label.backgroundColor=[UIColor lightGrayColor];
        label.numberOfLines = 0;
        [self.view addSubview:label];
        label;
    });
    NSString *string = @"Always believe that something wonderful is about \nto happen！";
    //富文本
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    //段落样式
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];

#warning  lable.numberOfLines必须为0，段落样式才生效
    //行间距
    paragraphStyle.lineSpacing = 10.0;
    //段落间距
    paragraphStyle.paragraphSpacing = 20.0;
#if 0
    //书写方式
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    //首行缩紧
    paragraphStyle.firstLineHeadIndent = 10.0;
    //除首行之外其他行缩进
    paragraphStyle.headIndent = 50.0;
    //每行容纳字符的宽度
    paragraphStyle.tailIndent = 200.0;
#endif
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    label.attributedText = attributedString;
    
    
    
#if 0
    NSForegroundColorAttributeName      //文字前景色
    
    NSBackgroundColorAttributeName      //文字背景色
    
    NSLigatureAttributeName      //连体字（NSNumber  @0:无连体，@1:默认连体，系统字体不包含对连体的支持）
    
    NSUnderlineStyleAttributeName　      //下划线
    
    NSStrokeColorAttributeName      //只有在NSStrokeWidthAttributeName设置了值之后才有效（默认字体颜色和前景色一致，如果设置的颜色和前景色不一致则前景色无效）
    
    NSStrokeWidthAttributeName      //设置该属性之后字体变成空心字体，字体边线宽度为value设定的值
    
    NSBaselineOffsetAttributeName      //值为NSNumber类型，表明文字相对于其他文字基准线向上的偏移量
    
    NSUnderlineColorAttributeName      //值为UIColor类型，下划线颜色（只有在NSUnderlineStyleAttributeName的value为@1时有效）
    
    NSUnderlineStyleAttributeName      //值为NSNumber类型，下划线宽度（默认值为@0:下划线宽度为0——不现实下划线，@1:字符串有下划线）
#endif
    
    
#if 0
    
    NSString *const NSFontAttributeName;(字体)
    
    NSString *const NSParagraphStyleAttributeName;(段落)
    
    NSString *const NSForegroundColorAttributeName;(字体颜色)
    
    NSString *const NSBackgroundColorAttributeName;(字体背景色)
    
    NSString *const NSLigatureAttributeName;(连字符)
    
    NSString *const NSKernAttributeName;(字间距)
    
    NSString *const NSStrikethroughStyleAttributeName;(删除线)
    
    NSString *const NSUnderlineStyleAttributeName;(下划线)
    
    NSString *const NSStrokeColorAttributeName;(边线颜色)
    
    NSString *const NSStrokeWidthAttributeName;(边线宽度)
    
    NSString *const NSShadowAttributeName;(阴影)(横竖排版)
    
    NSString *const NSVerticalGlyphFormAttributeName;
#endif
    
    
    
}
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
