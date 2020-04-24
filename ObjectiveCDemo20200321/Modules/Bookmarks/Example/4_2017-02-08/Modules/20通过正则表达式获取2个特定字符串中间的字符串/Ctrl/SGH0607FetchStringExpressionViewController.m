//
//  SGH0607FetchStringExpressionViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/6/7.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0607FetchStringExpressionViewController.h"
#import "RegexKitLite.h"
#import "Person.h"

@interface SGH0607FetchStringExpressionViewController ()

@end

@implementation SGH0607FetchStringExpressionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    Person *perosn = [perosn name];
    perosn.name = @"name";
//   [perosn observeValueForKeyPath:@"name" ofObject:<#(nullable id)#> change:<#(nullable NSDictionary<NSKeyValueChangeKey,id> *)#> context:<#(nullable void *)#>];
    
    
    /*-----------测试导航栏模糊的问题-------------*/
    UIView *view = [UIView new];
    view.frame = CGRectMake(100, 100, 100, 100);
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    self.navigationController.navigationBar.translucent = NO;//    Bar的模糊效果，默认为YES
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    /*-----------结束-------------*/
    
    
    
    /*-------------------------------------------*/
    //缓存工程版本号
    static NSString *kShortVersiongIdentifier = @"TKHA_CFBundleShortVersionString";
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //获取当前工程版本号
    NSString *shortVersionString = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //获取旧的工程版本号 。 一开始没有值，也是可以的
    NSString *oldShortVersionString = (NSString *)[[NSUserDefaults standardUserDefaults]objectForKey:kShortVersiongIdentifier];
    //[TKCacheHelper getCustomItemWithKey:kShortVersiongIdentifier];
    //如果当前工程版本号 大于> 旧的工程版本号，说明原生升级了。---> 此时应该显示工程版本号
    if (oldShortVersionString.length > 0 &&
        [shortVersionString compare:oldShortVersionString options:NSNumericSearch] == NSOrderedDescending) {
        //删除对h5更新完成后的缓存
        [[NSUserDefaults standardUserDefaults] setObject:[NSDictionary dictionary] forKey:@"wc_pre_h5_cache"];
        //[TKCacheHelper setCustomItem:[NSDictionary dictionary] withKey:@"wc_pre_h5_cache"];
    }
    //缓存当前工程版本号，以便原生升级后，跟升级后的版本号作对比
    [[NSUserDefaults standardUserDefaults] setObject:shortVersionString forKey:kShortVersiongIdentifier];
    //[TKCacheHelper setCustomItem:shortVersionString withKey:kShortVersiongIdentifier];
    
    /*-------------------------------------------*/
    
    
    
    NSString *str = @"oauth_token=1a1de4ed4fca40599c5e5cfe0f4fba97&oauth_token_secret=3118a84ad910967990ba50f5649632fa&name=foolshit";
    //@"test<img src=\"111.png\">test<ima src=\"222.jpg\">test<ima src=\"333.png\">testtest";
    NSString *regex = @"oauth_token=(\\w+)&oauth_token_secret=(\\w+)&name=(\\w+)";
    //@"[^src=\"]+(?=\">)";
    NSArray *arr = [str componentsSeparatedByRegex:regex];
                    //componentsSeparatedByRegex:regex];
    NSLog(@"arr: %@",arr);
    
    BOOL bo = [str isMatchedByRegex:regex];
    NSLog(@"bo: %@",(bo ? @"yes": @"no"));
    
    //是可以的
//    NSString *matchedString1 = [str stringByMatching:regex capture:1L];
//    NSString *matchedString2 = [str stringByMatching:regex capture:2L];
//    NSString *matchedString3 = [str stringByMatching:regex capture:3L];
    
    
    NSString *resultStr = [self p_matchString:@"commonlocal,www/m/ygt/index.html?isDirectExit=true#!/me/serviceHall.html" toRegexString:@"\\w*m/(\\w+)/index.html\\w*"];
    
    
    
    NSArray *resultArr = [@"commonlocal,www/m/ygt/index.html?isDirectExit=true#!/me/serviceHall.html" componentsSeparatedByRegex:@"(\\w*)[www/]?m/\\w*"];
    NSArray *resultStr2 = [@"commonlocal,www/m/ygt/index.html?isDirectExit=true#!/me/serviceHall.html" stringByMatching:@"(\\w*)[www/]?m/\\w*" capture:0];
    
    
    
    NSString *string = @"<a href=\"http\">这是要截取的内容</a>";
    NSRange startRange = [string rangeOfString:@"\">"];
    NSRange endRange = [string rangeOfString:@"</"];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    NSString *result = [string substringWithRange:range];
    NSLog(@"%@",result);
    
}

-(NSString *)p_matchString:(NSString *)string toRegexString:(NSString *)regexStr {
    return [string stringByMatching:regexStr capture:1L];
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
