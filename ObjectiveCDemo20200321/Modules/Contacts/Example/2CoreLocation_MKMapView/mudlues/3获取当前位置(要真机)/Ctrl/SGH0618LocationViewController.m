//
//  SGH0618LocationViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/6/18.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0618LocationViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface SGH0618LocationViewController ()<CLLocationManagerDelegate>
@property(nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation SGH0618LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化locationManager管理器对象
    CLLocationManager * locationManager = [CLLocationManager new];
    self.locationManager = locationManager;
    
    //判断当前设备定位服务是否打开
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"设备尚未打开定位服务");
    }
    
    //判断当前设备版本大于iOS8以后的话执行里面的方法
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        //持续授权
        [locationManager requestAlwaysAuthorization];
        
        //当用户使用的时候授权
        [locationManager requestWhenInUseAuthorization];
    }
    
    //或者使用这种方式，判断是否存在这个方法，如果存在就执行，没有的话就忽略
    //if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
    //   [locationManager requestWhenInUseAuthorization];
    //}
    
    //设置代理
    locationManager.delegate = self;
    //设置定位的精度
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置定位的频率，这里我们设置精度为10，也就是10米定位一次
    CLLocationDistance distance = 10;
    //给精度赋值
    locationManager.distanceFilter = distance;
    //开始启动定位
    [locationManager startUpdatingLocation];
    
    
}

#pragma mark - CLLocationManagerDelegate

//当位置发生改变的时候调用（上面我们设置的是10米，也就是当位置发生 >10 米的时候该代理方法就会调用）
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //取出第一个位置
    CLLocation *location = [locations firstObject];
    NSLog(@"%@", location.timestamp);
    
    //位置坐标
    CLLocationCoordinate2D coordinate = location.coordinate;
    //经度，纬度，海拔，航向，速度
    NSLog(@"longitude : %f, latitude : %f, altitude : %f, course : %f, speed : %f", coordinate.longitude, coordinate.latitude,location.altitude, location.course, location.speed);
    
    //如果不需要实时定位，使用完即可关闭定位服务
    //[_locationManager stopUpdatingLocation];
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
