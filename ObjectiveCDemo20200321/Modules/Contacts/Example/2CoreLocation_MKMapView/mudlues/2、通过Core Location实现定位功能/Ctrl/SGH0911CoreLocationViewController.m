//
//  SGH0911CoreLocationViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 16/9/11.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0911CoreLocationViewController.h"
#import <MapKit/MapKit.h>

@interface SGH0911CoreLocationViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>
@property(nonatomic, strong)MKMapView *mapView;
//位置管理器
@property(nonatomic,strong)CLLocationManager *locationManager;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)NSString *titleString;

@end

@implementation SGH0911CoreLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mapView = ({
        MKMapView *mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
        [mapView setDelegate:self];
        [mapView setShowsUserLocation:YES];
        [mapView setMapType:MKMapTypeStandard];
        [self.view addSubview:mapView];
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(p_longPressed:)];
        [mapView addGestureRecognizer:longPressGestureRecognizer];
        mapView;
    });
    
    _textField = ({
        UITextField *textField = [UITextField new];
        [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
        [textField setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:textField];
        textField;
    });
    
    UIButton *button = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor orangeColor]];
        [button setTitle:@"查找" forState:UIControlStateNormal];
        [button setTranslatesAutoresizingMaskIntoConstraints:NO];
        [button addTarget:self action:@selector(p_theButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_textField][button(100)]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textField, button)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_textField(30)]-(-30)-[button(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textField, button)]];
    
    //检测定位功能是否开启
    if ([CLLocationManager locationServicesEnabled]) {
        if (!_locationManager) {
            _locationManager = [CLLocationManager new];
            if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [_locationManager requestWhenInUseAuthorization];
                [_locationManager requestAlwaysAuthorization];
            }
            //设置代理
            [_locationManager setDelegate:self];
            //设置定位精度
            [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
            //设置距离筛选
            [_locationManager setDistanceFilter:100];
            //开始定位
            [_locationManager startUpdatingLocation];
            //设置开始识别方向
            [_locationManager startUpdatingHeading];
            
        }
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您没有开启定位功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    
}
#pragma mark - 响应事件
-(void)p_longPressed:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [recognizer locationInView:_mapView];
        CLLocationCoordinate2D coordinate2D = [_mapView convertPoint:point toCoordinateFromView:_mapView];
        [_mapView removeAnnotations:_mapView.annotations];
        CLLocation *location = [[CLLocation alloc]initWithLatitude:coordinate2D.latitude longitude:coordinate2D.longitude];
        [self p_reverseGeocoder:location];
        
    }
}

-(void)p_theButtonPressed:(id)sender {
    [_textField resignFirstResponder];
    if ([_textField.text length] == 0) {
        return;
    }
    [self p_geocoder:_textField.text];
}
#pragma mark - Geocoder
//反地理编码
-(void)p_reverseGeocoder:(CLLocation *)currentLocation {
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count == 0) {
            NSLog(@"error");
        }
        else {
            CLPlacemark *placemark = placemarks.firstObject;
            self.titleString = placemark.name;
            MKPointAnnotation *pointAnnotation = [MKPointAnnotation new];
            [pointAnnotation setTitle:placemark.name];
            [pointAnnotation setCoordinate:CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude)];
            [_mapView addAnnotation:pointAnnotation];
            
            NSLog(@"placemark : %@", [[placemark addressDictionary] objectForKey:@"City"]);
        }
    }];
}
//地理编码
-(void)p_geocoder:(NSString *)str {
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder geocodeAddressString:str completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count == 0) {
            NSLog(@"error");
        }
        else {
            CLPlacemark *placemark = placemarks.firstObject;
            MKCoordinateRegion coordinateRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude), MKCoordinateSpanMake(0.1, 0.1));
            [_mapView setRegion:[_mapView regionThatFits:coordinateRegion]];
            
            MKPointAnnotation *pointAnnotation = [MKPointAnnotation new];
            [pointAnnotation setTitle:placemark.name];
            [pointAnnotation setCoordinate:CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude)];
            [_mapView addAnnotation:pointAnnotation];
        }
    }];
}

#pragma mark - CLLocationManagerDelegate
//授权状态发生改变的时候执行
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusDenied: {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"定位功能没有开启" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
            break;
            
        default:
            break;
    }
}

//定位成功以后调用
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [_locationManager stopUpdatingLocation];
    CLLocation *location = [locations lastObject];
    
    MKCoordinateRegion coordinateRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), MKCoordinateSpanMake(0.1, 0.1));
    [_mapView setRegion:[_mapView regionThatFits:coordinateRegion] animated:YES];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"error : %@",error);
}

#pragma mark - MKMapViewDelegate
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *key = @"key";
    MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:key];
    if (pinAnnotationView == nil) {
        pinAnnotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key];
        [pinAnnotationView setCanShowCallout:YES];
    }
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        [pinAnnotationView setPinColor:MKPinAnnotationColorRed];
        [((MKUserLocation *)annotation) setTitle:_titleString];
    }
    else {
        [pinAnnotationView setPinColor:MKPinAnnotationColorPurple];
    }
    return pinAnnotationView;
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
