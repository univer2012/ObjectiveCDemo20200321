//
//  SGHAFNetworkingViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/12/5.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGHAFNetworkingViewController.h"
#if 1
#import <AFNetworking/AFNetworking.h>
#endif
//#import "AFNetworking.h"
//#import <>

@interface SGHAFNetworkingViewController ()<NSURLSessionDelegate>

@end

@implementation SGHAFNetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"home: %@",NSHomeDirectory());

    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://www.daka.com/resources/image/icon.png"] ;



}
#if 1
- (void)AFNetworkStatus{
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    /*枚举里面四个状态 分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown = -1, 未知
     AFNetworkReachabilityStatusNotReachable = 0, 无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1, 蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2, WiFi
     };   */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block 可以写成switch方便
        //在里面可以随便写事件
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
            default:
                break;
        }
    }] ;

    NSURLSessionConfiguration *sonfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@""];
}
#endif


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
