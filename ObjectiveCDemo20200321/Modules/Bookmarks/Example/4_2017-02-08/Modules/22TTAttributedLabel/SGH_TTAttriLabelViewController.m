//
//  SGH_TTAttriLabelViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/1/30.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SGH_TTAttriLabelViewController.h"

#import "TTTAttributedLabel.h"

#import "UILabel+YBAttributeTextTapAction.h"

#import "TYAttributedLabel.h"



@interface SGH_TTAttriLabelViewController ()<TTTAttributedLabelDelegate, YBAttributeTapActionDelegate,TYAttributedLabelDelegate>

@end

@implementation SGH_TTAttriLabelViewController

#pragma mark - YBAttributeTapActionDelegate
- (void)yb_tapAttributeInLabel:(UILabel *)label string:(NSString *)string range:(NSRange)range index:(NSInteger)index {
    NSLog(@"string: %@",string);
}
#pragma mark - TYAttributedLabelDelegate
- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)textStorage atPoint:(CGPoint)point{
    
    if ([textStorage isKindOfClass:[TYLinkTextStorage class]]) {
        /** 获取linkData  */
        NSNumber *linkData = ((TYLinkTextStorage*)textStorage).linkData;
        switch (linkData.integerValue) {
            case 1: {
            }
                break;
            case 2: {
            }
                break;
            case 3: {
            }
                break;
                
            default:
                break;
        }
//        NSString *linkStr = ((TYLinkTextStorage*)textStorage).linkData;
//        if ([linkStr hasPrefix:@"http:"]) {
//            [ [ UIApplication sharedApplication] openURL:[ NSURL URLWithString:linkStr]];
//        }
        //获取被点中的文字
        NSRange rang = [textStorage range];
        NSString *msg = attributedLabel.text;
        msg = [msg substringWithRange:rang];
        NSLog(@"---->%@",msg);
        if ([msg isEqualToString:@"期待"]) {
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.baidu.com/"]];
            
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#if 0
    NSString *oneString = @"1. 通过AppStore充值书币，可以查看";
    NSString *oneActionString = @"充值引导帮助 ";
    NSString *twoString = @" 。\n2. 苹果政策规定iOS上的书币不能在其它终端使用。 \n3. 充值过程可能会有延迟到账的情况，如果长时间未到账，请 从“我的”一“意见反馈”里进行反馈，客服人员会进行处理。\n4. 本页面显示的赠送书币，为相应充值方式的最高金额 赠送数量。 \n5. 点击充值，代表您已阅读过 ";
    NSString *twoActionString = @"《用户协议》";
    NSString *threeString = @"和";
    NSString *threeActionString = @"《隐私协议》";
    NSString *bottomString = [NSString stringWithFormat:@"%@%@%@%@%@%@",oneString,oneActionString,twoString, twoActionString, threeString, threeActionString];
    
    TYAttributedLabel *bottomLabel = ({
        TYAttributedLabel *label = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 0)];
        //链接高亮背景颜色
        label.highlightedLinkBackgroundColor = UIColor.clearColor;
        label.font = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
        label.textColor = [UIColor colorWithHexString:@"#999999"];
        //label.numberOfLines = 1;
        label.lineBreakMode = kCTLineBreakByTruncatingTail;
        label.delegate = self;
        //NSString *text = @"\t总有一天你将破蛹而出，成长得比人们期待的还要美丽。\n";
        [label setText:bottomString];
        [label sizeToFit];
        [self.view addSubview:label];
        label;
    });
    /** 只改变文字颜色、大小  */
//    TYTextStorage *textStorage = [[TYTextStorage alloc]init];
//    textStorage.range = [text rangeOfString:@"总有一天你将破蛹而出"];
//    textStorage.textColor = [UIColor orangeColor];
//    textStorage.font = [UIFont systemFontOfSize:16];
//    [label addTextStorage:textStorage];
    
    /** 链接的响应  */
    TYLinkTextStorage *oneLinkStorage = ({
        TYLinkTextStorage *storage = [[TYLinkTextStorage alloc]init];
        storage.range = [bottomString rangeOfString:oneActionString];
        storage.textColor = [UIColor colorWithHexString:@"#D3392C"];
        storage.underLineStyle = kCTUnderlineStyleNone;
        storage.linkData = @(1);
        storage;
    });
    [bottomLabel addTextStorage:oneLinkStorage];
    
    TYLinkTextStorage *twoLinkStorage = ({
        TYLinkTextStorage *storage = [[TYLinkTextStorage alloc]init];
        storage.range = [bottomString rangeOfString:twoActionString];
        storage.textColor = [UIColor colorWithHexString:@"#D3392C"];
        storage.underLineStyle = kCTUnderlineStyleNone;
        storage.linkData = @(2);
        storage;
    });
    [bottomLabel addTextStorage:twoLinkStorage];
    
    TYLinkTextStorage *threeLinkStorage = ({
        TYLinkTextStorage *storage = [[TYLinkTextStorage alloc]init];
        storage.range = [bottomString rangeOfString:threeActionString];
        storage.textColor = [UIColor colorWithHexString:@"#D3392C"];
        storage.underLineStyle = kCTUnderlineStyleNone;
        storage.linkData = @(3);
        storage;
    });
    [bottomLabel addTextStorage:threeLinkStorage];
#endif
    
    
    
    
    
    
#if 0
    NSString *oneString = @"1. 通过AppStore充值书币，可以查看";
    NSString *oneActionString = @"充值引导帮助 ";
    NSString *twoString = @" 。\n\
    2. 苹果政策规定iOS上的书币不能在其它终端使用。 \n\
    3. 充值过程可能会有延迟到账的情况，如果长时间未到账，请 从“我的”一“意见反馈”里进行反馈，客服人员会进行处理。\n\
    4. 本页面显示的赠送书币，为相应充值方式的最高金额 赠送数量。 \n\
    5. 点击充值，代表您已阅读过 ";
    NSString *twoActionString = @"《用户协议》";
    NSString *threeString = @"和";
    NSString *threeActionString = @"《隐私协议》";
    
    NSString *bottomString = [NSString stringWithFormat:@"%@%@%@%@%@%@",oneString,oneActionString,twoString, twoActionString, threeString, threeActionString];
    /** 内容的宽度  */
    CGFloat contentWidth = SGHDeviceManager.screenWidth - 30;
    CGSize stringSize = [SHUtility boundingRactWithSize:CGSizeMake(contentWidth, CGFLOAT_MAX) font:[UIFont systemFontOfSize:12 weight:UIFontWeightLight] content:bottomString];
    
    NSMutableAttributedString *bottomAttString = [[NSMutableAttributedString alloc] initWithString:bottomString];
    [bottomAttString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#D3392C"]} range:[bottomString rangeOfString:oneActionString]];
    [bottomAttString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#D3392C"]} range:[bottomString rangeOfString:twoActionString]];
    [bottomAttString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#D3392C"]} range:[bottomString rangeOfString:threeActionString]];
    
    kBlockSelf
    UILabel *bottomLabel = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 100, contentWidth, stringSize.height)];
        label.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
        label.textColor = [UIColor colorWithHexString:@"#999999"];
        label.numberOfLines = 0;
        label.backgroundColor = UIColor.yellowColor;
        [blockSelf.view addSubview:label];
        label;
    });
    bottomLabel.attributedText = bottomAttString;
    
    [bottomLabel yb_addAttributeTapActionWithStrings:@[oneActionString, twoActionString, threeActionString] delegate:self];
#endif
    
    
    
#if 1
    NSString *text=@"弱者普遍易怒如虎，而且容易暴怒。强者通常平静如水，并且相对平和。一个内心不强大的人，自然内心不够平静。内心不平静的人，处处是风浪。再小的事，都会被无限放大。一个内心不强大的人，心中永远缺乏安全感  https://github.com/TTTAttributedLabel/TTTAttributedLabel  15112345678  2017-05-06 天安门";
    
    TTTAttributedLabel *label = ({
        TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, 200)];
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        [self.view addSubview:label];
        label.text = text;
        
        label.delegate = self;
        //设置行间距
        label.lineSpacing = 8;
        //可自动识别url，显示为蓝色+下划线
        //label.enabledTextCheckingTypes = NSTextCheckingTypeLink;
        //此属性可以不显示下划线，点击的颜色默认为红色
        label.linkAttributes = @{(NSString *)kCTUnderlineStyleAttributeName : @(NO)};
        //此属性可以改变点击的颜色
        label.activeLinkAttributes = @{(NSString *)kCTForegroundColorAttributeName: [UIColor colorWithHexString:@"#D3392C"]};
        label;
    });
    
    __block NSString * twoSelsectString = @"一个内心不强大的人，心中永远缺乏安全感";
    __block NSRange twoSelRange = [text rangeOfString:twoSelsectString];
    
    
    //设置需要点击的文字的颜色大小
    [label setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        /** ============ twoSelsectString ==================  */
        //得到需要点击的文字的位置
        //NSRange selRange1=[text rangeOfString:twoSelsectString];
        //设定可点击文字的的大小
//        UIFont *selFont1=[UIFont systemFontOfSize:14];
//        CTFontRef selFontRef1 = CTFontCreateWithName((__bridge CFStringRef)selFont1.fontName, selFont1.pointSize, NULL);
        //设置可点击文本的大小
//        [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)selFontRef1 range:twoSelRange];
        //设置可点击文本的颜色
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor colorWithHexString:@"#D3392C"] CGColor] range:twoSelRange];
        //设置可点击文本的背景颜色
        //[mutableAttributedString addAttribute:(NSString*)kCTBackgroundColorAttributeName value:(id)[[UIColor redColor] CGColor] range:selRange1];
        
//        CFRelease(selFontRef1);
        

        return mutableAttributedString;
    }];
    
    /** ============ transitInformation ==================  */
    //给  强者通常平静如水   添加点击事件
    [label addLinkToTransitInformation:@{@"select": @(1)} withRange:twoSelRange];
    
    /** ============ phoneNumber ==================  */
//    //给 电话号码 添加点击事件
//    NSRange telRange=[text rangeOfString:@"15112345678"];
//    [label addLinkToPhoneNumber:@"15112345678" withRange:telRange];
//
//    /** ============ date ==================  */
//    //给  时间  添加点击事件
//    NSRange dateRange=[text rangeOfString:@"2017-05-06"];
//    [label addLinkToDate:[NSDate date] withRange:dateRange];
//
//    /** ============ address ==================  */
//    //给  天安门  添加点击事件
//    NSRange addressRange=[text rangeOfString:@"天安门"];
//    [label addLinkToAddress:@{@"address":@"天安门",@"longitude":@"116.2354",@"latitude":@"38.2145"} withRange:addressRange];
#endif
}

#pragma TTTAttributedLabel Delegate

//文字的点击事件
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components {
    NSLog(@"didSelectLinkWithTransitInformation :%@",components);
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    NSLog(@"didSelectLinkWithURL :%@",url);
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithDate:(NSDate *)date {
    NSLog(@"didSelectLinkWithDate :%@",date);
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithAddress:(NSDictionary *)addressComponents {
    NSLog(@"didSelectLinkWithAddress :%@",addressComponents);
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithPhoneNumber:(NSString *)phoneNumber {
    NSLog(@"didSelectLinkWithPhoneNumber :%@",phoneNumber);
}



//文字的长按事件
- (void)attributedLabel:(TTTAttributedLabel *)label didLongPressLinkWithURL:(NSURL *)url atPoint:(CGPoint)point {
    NSLog(@"didLongPressLinkWithURL  :%@",url);
}

- (void)attributedLabel:(TTTAttributedLabel *)label didLongPressLinkWithDate:(NSDate *)date atPoint:(CGPoint)point {
    NSLog(@"didLongPressLinkWithDate  :%@",date);
    
}

- (void)attributedLabel:(TTTAttributedLabel *)label didLongPressLinkWithAddress:(NSDictionary *)addressComponents atPoint:(CGPoint)point {
    NSLog(@"didLongPressLinkWithAddress  :%@",addressComponents);
    
}

- (void)attributedLabel:(TTTAttributedLabel *)label didLongPressLinkWithPhoneNumber:(NSString *)phoneNumber atPoint:(CGPoint)point {
    NSLog(@"didLongPressLinkWithPhoneNumber  :%@",phoneNumber);
    
}

- (void)attributedLabel:(TTTAttributedLabel *)label didLongPressLinkWithTransitInformation:(NSDictionary *)components atPoint:(CGPoint)point {
    NSLog(@"didLongPressLinkWithTransitInformation  :%@",components);
    
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
