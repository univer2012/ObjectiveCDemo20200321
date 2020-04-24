//
//  SGH0618DistanceViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/6/18.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0618DistanceViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface SGH0618DistanceViewController ()
@property(nonatomic, strong)CLLocationManager *locationManager;

@end

@implementation SGH0618DistanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建位置管理器
    CLLocationManager *locationManager = [CLLocationManager new];
    self.locationManager = locationManager;
    
    //判断当前设备版本是否大于或等于8.0
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        //持续授权
        //[locationManager requestAlwaysAuthorization];
        //使用期间授权
        [locationManager requestWhenInUseAuthorization];
    }
    //iOS 9.0以后苹果提供的新属性
    if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
        //是否允许后台定位
        locationManager.allowsBackgroundLocationUpdates = YES;
    }
    
    //开始定位
    [locationManager stopUpdatingLocation];
    //比较两点距离
    [self p_compareDistance];
    
}
///比较两地之间距离(直线距离)
-(void)p_compareDistance {
  //北京（116.3，39.9）
    CLLocation *location1 = [[CLLocation alloc]initWithLatitude:39.9 longitude:116.3];
    //郑州（113.42，34.44）
    CLLocation *location2 = [[CLLocation alloc]initWithLatitude:34.44 longitude:113.42];
    //比较北京距离郑州的距离
    CLLocationDistance locationDistance = [location1 distanceFromLocation:location2];
    //单位是m/s 所以这里需要除以1000
    NSLog(@"北京距离郑州的距离为 : %f", locationDistance / 1000);
    
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
