//
//  SGH0618AntiEncodeViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/6/18.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0618AntiEncodeViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface SGH0618AntiEncodeViewController ()
///经度
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;
///纬度
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;
///详细地址
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation SGH0618AntiEncodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"输入经纬度";
}
///反地理编码
- (IBAction)p_antiEncoder:(id)sender {
    //创建地理编码对象
    CLGeocoder *geocoder = [CLGeocoder new];
    //创建位置
    CLLocation *location = [[CLLocation alloc]initWithLatitude:[self.latitudeTextField.text floatValue] longitude:[self.longitudeTextField.text floatValue]];
    
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       //判断是否有错误或者placemarks 是否为空
        if (error != nil || placemarks.count == 0) {
            NSLog(@"%@", error);
            return ;
        }
        for (CLPlacemark *placemark in placemarks) {
            //赋值详细地址
            self.textView.text = placemark.name;
        }
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
