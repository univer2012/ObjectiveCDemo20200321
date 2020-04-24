//
//  SGH0618DynaAnnotationViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/6/18.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0618DynaAnnotationViewController.h"
#import <MapKit/MapKit.h>
#import "SGH0618Annotation.h"


@interface SGH0618DynaAnnotationViewController ()<MKMapViewDelegate>
//创建管理者
@property(nonatomic,strong)CLLocationManager *locationManager;
//mapView
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation SGH0618DynaAnnotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //1、创建大头针模型
    SGH0618Annotation *annotation = [SGH0618Annotation new];
    annotation.coordinate = CLLocationCoordinate2DMake(39.9, 116);
    annotation.title = @"北京";
    annotation.subtitle = @"默认显示的为首都北京";
    
    //添加第一个大头针模型
    [self.mapView addAnnotation:annotation];
    //设置代理
    self.mapView.delegate = self;
    
    //请求授权
    self.locationManager = [CLLocationManager new];
    
    //设置用户跟踪模式
    //self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //获取用户点击的位置
    CGPoint point = [[touches anyObject] locationInView:self.mapView];
    //将具体的位置转换为经纬度
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
    //添加大头针
    SGH0618Annotation *annotation = [SGH0618Annotation new];
    annotation.coordinate = coordinate;
    
    //反地理编码
    CLGeocoder *geocoder = [CLGeocoder new];
    CLLocation *location = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error == nil && placemarks.count == 0) {
            NSLog(@"错误信息: %@", error);
            return ;
        }
        //获取地标信息
        CLPlacemark *placemark = [placemarks firstObject];
        //获取标题名称
        annotation.title = placemark.locality;
        //获取副标题名称
        annotation.subtitle = placemark.name;
        
        //添加大头针到地图
        [self.mapView addAnnotation:annotation];
    }];
}

#pragma mark - MKMapViewDelegate

//创建大头针时调用
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    //如果返回空，代表大头针样式交由系统去管理
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *ID = @"annotation";
    //MKAnnotationView 默认没有界面  可以显示图片
    // MKPinAnnotationView有界面  默认不能显示图片
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ID];
        //设置大头针颜色
        annotationView.pinTintColor = [UIColor redColor];
        //设置为动画掉落的效果
        annotationView.animatesDrop = YES;
        //显示详情
        annotationView.canShowCallout = YES;
    }
    return annotationView;
    
    
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
