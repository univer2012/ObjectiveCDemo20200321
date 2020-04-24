//
//  SHUpdateJumpAppStoreVC.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/15.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHUpdateJumpAppStoreVC.h"

@interface SHUpdateJumpAppStoreVC ()

@end

@implementation SHUpdateJumpAppStoreVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
#if 1
    
    // 如果要实现在应用里面跳到appstore的对应评论页面里面的话,只要将下面地址中App_ID替换成自己的id就可以了，其他的地方都不用管。
    // 如果要用Safari浏览器做实验的话可以将地址中的 "itms-apps://" 替换成"http://"即可。
    // 另外也可以尝试地改变其中几个参数的数值，可以看看结果。
    // 注意： 必须使用真机调试，目前来说还是不支持模拟器运行的
    //963463279?mt=8
    
    /*
     NSString *str = [NSString stringWithFormat:
     @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",
     436957167 ];
     [[UIApplication sharedApplication] openURL:[NSURL urlWithString:str]];
     */
    
    NSString * appstoreUrlString =[NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%d", 963463279];//VV
    //[NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d", 963463279 ];
    
    //原来的：@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?mt=8&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software&id=APP_ID";
    //测试华安：
    
    NSURL * url = [NSURL URLWithString:appstoreUrlString];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        NSLog(@"can not open");
    }
#endif
}

@end
