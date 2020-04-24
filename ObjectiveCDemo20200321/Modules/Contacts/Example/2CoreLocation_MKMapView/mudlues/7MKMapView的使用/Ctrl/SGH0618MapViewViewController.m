//
//  SGH0618MapViewViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/6/18.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0618MapViewViewController.h"
#import <MapKit/MapKit.h>

@interface SGH0618MapViewViewController ()<MKMapViewDelegate>
///mapView
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property(nonatomic, strong)CLLocationManager *locationManager;

@end

@implementation SGH0618MapViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CLLocationManager *locationManager = [CLLocationManager new];
    self.locationManager = locationManager;
    
    //请求授权
    [locationManager requestWhenInUseAuthorization];
    
    /*
     MKUserTrackingModeNone = 0, // 不进行用户位置跟踪
     MKUserTrackingModeFollow, // 跟踪用户的位置变化
     MKUserTrackingModeFollowWithHeading  //跟踪用户位置和方向变化
     */
    //设置用户的跟踪模式
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    /*
     MKMapTypeStandard = 0, 标准地图
     MKMapTypeSatellite,    卫星地图
     MKMapTypeHybrid,       鸟瞰地图
     MKMapTypeSatelliteFlyover NS_ENUM_AVAILABLE(10_11, 9_0),
     MKMapTypeHybridFlyover NS_ENUM_AVAILABLE(10_11, 9_0),
     */
    self.mapView.mapType = MKMapTypeStandard;
    
    //实时显示交通路况
    self.mapView.showsTraffic = YES;
    //设置代理
    self.mapView.delegate = self;
    
}

//跟踪到用户位置时会调用该方法
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    //创建编码对象
    CLGeocoder *geocoder = [CLGeocoder new];
    //反地理编码
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error != nil || placemarks.count == 0) {
            return ;
        }
        //获取地标
        CLPlacemark *placemark = [placemarks firstObject];
        //设置标题
        userLocation.title = placemark.locality;
        //设置子标题
        userLocation.subtitle = placemark.name;
        
    }];
}
//当区域改变时调用
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    //获取系统默认定位的经纬度跨度
    
    NSLog(@"纬度跨度 : %f, 经度跨度 : %f", mapView.region.span.latitudeDelta, mapView.region.span.longitudeDelta);
}

///回到当前位置
- (IBAction)backCurrentLocation:(id)sender {
    MKCoordinateSpan span = MKCoordinateSpanMake(0.021251, 0.016093);
    [self.mapView setRegion:MKCoordinateRegionMake(self.mapView.userLocation.coordinate, span) animated:YES];
    
}
///缩小地图
- (IBAction)minMapView:(id)sender {
    //获取纬度跨度并放大一倍
    CGFloat latitudeDelta = self.mapView.region.span.latitudeDelta * 2;
    //获取经度跨度并放大一倍
    CGFloat longitudeDelta = self.mapView.region.span.longitudeDelta * 2;
    //经纬度跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    //设置当前区域
    MKCoordinateRegion region = MKCoordinateRegionMake(self.mapView.centerCoordinate, span);
    
    [self.mapView setRegion:region animated:YES];
}

///放大地图
- (IBAction)maxMapView:(id)sender {
    //获取纬度跨度并缩小一倍
    CGFloat latitudeDelta = self.mapView.region.span.latitudeDelta * 0.5;
    //获取经度跨度并缩小一倍
    CGFloat longitudeDelta = self.mapView.region.span.longitudeDelta * 0.5;
    //经纬度跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    //设置当前区域
    MKCoordinateRegion region = MKCoordinateRegionMake(self.mapView.centerCoordinate, span);
    
    [self.mapView setRegion:region animated:YES];
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
