//
//  SGH0618MapNavigationViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/6/18.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0618MapNavigationViewController.h"
#import <MapKit/MapKit.h>

@interface SGH0618MapNavigationViewController ()
///地址
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@end

@implementation SGH0618MapNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
///开始导航
- (IBAction)begin:(id)sender {
    //创建CLGeocoder对象
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder geocodeAddressString:self.addressTextField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       //获取目的地地理坐标
        CLPlacemark *placemark = [placemarks lastObject];
        //Mapkit框架下的地标
        MKPlacemark *mkPlacemark = [[MKPlacemark alloc]initWithPlacemark:placemark];
        //目的地的item
        MKMapItem *mapItem = [[MKMapItem alloc]initWithPlacemark:mkPlacemark];
        MKMapItem *currentmapItem = [MKMapItem mapItemForCurrentLocation];
        NSMutableDictionary *options = [NSMutableDictionary dictionary];
        // MKLaunchOptionsDirectionsModeDriving 导航类型设置为驾车模式
        options[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeDriving;
        //设置地图显示类型为卫星模式
        options[MKLaunchOptionsMapTypeKey] = @(MKMapTypeHybrid);
        options[MKLaunchOptionsShowsTrafficKey] = @(YES);
        
        //打开苹果地图应用
        [MKMapItem openMapsWithItems:@[currentmapItem, mapItem] launchOptions:options];
        
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
