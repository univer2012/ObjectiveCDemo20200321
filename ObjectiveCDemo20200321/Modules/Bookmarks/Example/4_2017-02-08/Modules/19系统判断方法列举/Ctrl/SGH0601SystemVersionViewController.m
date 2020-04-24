//
//  SGH0601SystemVersionViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/6/1.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0601SystemVersionViewController.h"
//等于
#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
//大于
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
//大于等于
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
//小于
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
//小于等于
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface SGH0601SystemVersionViewController ()

@end

@implementation SGH0601SystemVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self p_systemVersionCompare];
//    [self p_systemVersionProcessInfo];
//    [self p_foundationVersionNumber];
    
    
    NSString *htmlStr = @"www/m/ygt/index.html?isDirectExit=true#!/me/serviceHall.html";
    //@"commonlocal,www/m/ygt/index.html?isDirectExit=true#!/me/serviceHall.html";
    NSString *regexString = @"\\w*(www/)?m/\\w+/index.html\\w*";
    //@"^\\w*m/\\w*/index.html\\w*$";
    //@"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
//   NSArray *array = [self matchString:htmlStr toRegexString:regexString];
    
//    [htmlStr componentsMatchedByRegex:];
//    NSString *matchedString1 = [htmlStr stringByMatching:regexString capture:1L];
//    NSString *matchedString2 = [htmlStr stringByMatching:regexString capture:2L];
//    NSString *matchedString3 = [htmlStr stringByMatching:regexString capture:3L];
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    BOOL isMobileNum = [regextestmobile evaluateWithObject:htmlStr];
    NSLog(@"isMobileNum: %@",(isMobileNum ? @"YES": @"NO"));
    
}

- (NSArray *)matchString:(NSString *)string toRegexString:(NSString *)regexStr
{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray * matches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    //match: 所有匹配到的字符,根据() 包含级
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSTextCheckingResult *match in matches) {
        
        for (int i = 0; i < [match numberOfRanges]; i++) {
            //以正则中的(),划分成不同的匹配部分
            NSString *component = [string substringWithRange:[match rangeAtIndex:i]];
            
            [array addObject:component];
            
        }
        
    }
    
    return array;
}



-(void)p_foundationVersionNumber {
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_8_4) {
        // do stuff for iOS 9 and newer
        NSLog(@"当前系统大于iOS 8.4");
    }
    else {
        NSLog(@"当前系统为小于或登录iOS 8.4");
        // do stuff for older versions than iOS 9
    }
}

-(void)p_systemVersionProcessInfo {
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){.majorVersion = 9, .minorVersion = 1, .patchVersion = 0}]) {
        NSLog(@"Hello from > iOS 9.1");
    }
    if ([NSProcessInfo.processInfo isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){9,3,0}]) { NSLog(@"Hello from > iOS 9.3");
    }
}


-(void)p_systemVersionCompare {
    if (SYSTEM_VERSION_EQUAL_TO(@"10.3")) {
        NSLog(@"当前系统是iOS 10.3");
    }
    if (SYSTEM_VERSION_GREATER_THAN(@"10.3")) {
        NSLog(@"当前系统大于iOS 10.3");
    }
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.3")) {
        NSLog(@"当前系统大于或等于iOS 10.3");
    }
    if (SYSTEM_VERSION_LESS_THAN(@"10.3")) {
        NSLog(@"当前系统小于iOS 10.3");
    }
    if (SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(@"10.3")) {
        NSLog(@"当前系统小于或等于iOS 10.3");
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
