//
//  SGH0618AnnotationViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/6/18.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0618AnnotationViewController.h"
#import <MapKit/MapKit.h>
#import "SGH0618Annotation.h"

@interface SGH0618AnnotationViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end



@implementation SGH0618AnnotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    SGH0618Annotation *annotatin = [SGH0618Annotation new];
    annotatin.coordinate = CLLocationCoordinate2DMake(39.0, 116);
    annotatin.title = @"我是副标题";
    annotatin.subtitle = @"我是子标题";
    
    self.mapView.delegate = self;
    //添加大头针到背景
    [self.mapView addAnnotation:annotatin];
    
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
        if (error != nil || placemarks.count == 0) {
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
