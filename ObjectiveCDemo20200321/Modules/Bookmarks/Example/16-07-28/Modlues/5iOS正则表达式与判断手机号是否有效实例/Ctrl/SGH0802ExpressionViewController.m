//
//  SGH0802ExpressionViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/8/2.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0802ExpressionViewController.h"

@interface SGH0802ExpressionViewController ()<UITextFieldDelegate>

@end

@implementation SGH0802ExpressionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self p_methodTwo];
    
    [self p_methodThree];
    
    [self p_methodFour];
    
    //判断手机号码是否有效
    UITextField *phoneTextField = ({
        UITextField *textField = [UITextField new];
        textField.frame = CGRectMake(75, 80, self.view.frame.size.width - 150, 40);
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = @"请输入手机号";
        textField.delegate = self;
        textField;
    });
    [self.view addSubview:phoneTextField];
    
#if 0
    
    NSDictionary *dic = @{@"endtime": @"2016-8-1 10:20:30",
                          @"show_type": @"1"};
    BOOL shouldAlert = NO;  //默认不显示
    NSDateFormatter *endTimeFormatter = [NSDateFormatter new];
    [endTimeFormatter setDateFormat:@"YYYY-MM-DD hh:mm:ss"];
    
    NSDate *endTimeDate = [endTimeFormatter dateFromString:@"2016-8-1 10:20:30"];
    NSDate * nowDate = [NSDate date];  //现在的时间
    NSComparisonResult result = [endTimeDate compare:nowDate];
    if (result != NSOrderedAscending) { // 升序
        //nowDate 没有比 endTimeDate 大 nowDate <= endTimeDate
        //可以显示
        if ([dic[@"show_type"] isEqualToString:@"2"]) {
            //每次弹出
            shouldAlert = YES;
            
        } else if ([dic[@"show_type"] isEqualToString:@"1"]) {
            //只弹一次
            shouldAlert=YES;
            
        } else if ([dic[@"show_type"] isEqualToString:@"0"]) {
            //不弹出
            shouldAlert=NO;
        }
    } else {
        shouldAlert=NO;
    }
#endif
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            [textField resignFirstResponder];
        }
    }
    
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField {
    NSString *message = [NSString string];
    if ([self p_isMobileNumber:textField.text]) {
        message = @"正确的手机号";
    }
    else {
        message = @"您输入的手机号有误，请重新输入";
    }
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

#pragma mark -  判断手机号码是否有效
// 正则判断手机号码地址格式
- (BOOL)p_isMobileNumber:(NSString *)mobileNum {
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    BOOL isMobileNum = [regextestmobile evaluateWithObject:mobileNum];
    NSLog(@"isMobileNum : %@",(isMobileNum ? @"YES" : @"NO"));
    return isMobileNum;
}



#pragma mark - 方法
/*
 方法二、NSString实例方法
 使用rangeOfString:options:方法可以做到，具体看例子：
 
 rangeOfString:options:会返回一个NSRange，用来接收匹配的范围，当匹配不到结果时，将会返回一个NSIntegerMax最大值，也就是NSNotFound，因此我们可以用它来判断用户输入的内容是否符合规则。
 */
-(void)p_methodTwo {
    NSString *phoneNo = @"13143503442";
    NSRange range = [phoneNo rangeOfString:@"^1[3]\\d{9}$" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        NSLog(@"%@", [phoneNo substringWithRange:range]);
    }
    //
}



/*
 方法三、NSRegularExpression类创建正则表达式
 
 这个例子是从字符串里检索出以“@”开头“.”结尾的区间字符串，最后检索出来的字符串结尾包括“.”，因此此例子最终输出结果为“qq.”
 */
-(void)p_methodThree {
    NSString *url = @"1229436624@qq.com";
    NSError *error;
    // 创建NSRegularExpression对象并指定正则表达式
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^@]*\\." options:0 error:&error];
    if (!error) { // 如果没有错误
        // 获取特特定字符串的范围
        NSTextCheckingResult *match = [regex firstMatchInString:url options:0 range:NSMakeRange(0, [url length])];
        if (match) {
            // 截获特定的字符串
            NSString *result = [url substringWithRange:match.range];
            NSLog(@"%@",result);
        }
    } else { // 如果有错误，则把错误打印出来
        NSLog(@"error - %@", error);
    }
}

/*
 方法四、NSRegularExpression类之抓取多个结果
 当一个字符串有多个符合特定规则的字符，我们可以分别获取到符合特定规则的字符：
 
 从指定字符串中获取以“-”开头以“.”结尾的字符，因为可能有多个符合特定规则的字符串，因此我们需要把它们遍历出来，具体输出结果如下：
 */
-(void)p_methodFour {
//    NSString *regex = @"\\-\\d*\\.";
//    NSString *str = @"-34023242.-34203020.";
    
    NSString *regex = @"www/m/\\d*/index.html#!";
    NSString *str = @"www/m/mall/index.html#!/userCenter/userInfo.html?ModuleName=me";
    
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    // 对str字符串进行匹配
    NSArray *matches = [regular matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    // 遍历匹配后的每一条记录
    for (NSTextCheckingResult *match in matches) {
        NSRange range = [match range];
        NSString *mStr = [str substringWithRange:range];
        NSLog(@"%@", mStr);
    }
    
    NSArray *toPageArray = [str componentsSeparatedByString:@"#!"];
    NSString *classModuleName = [[toPageArray[0] stringByReplacingOccurrencesOfString:@"www/m/" withString:@""] stringByReplacingOccurrencesOfString:@"/index.html" withString:@""];
    NSLog(@"classModuleName : %@", classModuleName);
    
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
