//
//  SGHNetworkChangeViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/4/26.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHNetworkChangeViewController.h"
#import "Reachability.h"

@interface SGHNetworkChangeViewController ()
@property(nonatomic,strong)Reachability *conn;

@end

@implementation SGHNetworkChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    self.conn = [Reachability reachabilityForInternetConnection];
    [self.conn startNotifier];
    
}
-(void)networkStateChange {
    [self checkNetworkState];
}
-(void)checkNetworkState {
    //1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    //2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    //3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) { //有wifi
        NSLog(@"有wifi");
    }
    else if ([conn currentReachabilityStatus] != NotReachable) {    //没有使用wifi，使用手机自带网络进行上网
        NSLog(@"使用手机自带网络进行上网");
    }
    else {  //没有网络
        NSLog(@"没有网络");
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
