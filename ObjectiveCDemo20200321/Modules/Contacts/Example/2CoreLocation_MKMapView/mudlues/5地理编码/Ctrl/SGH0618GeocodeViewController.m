//
//  SGH0618GeocodeViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/6/18.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0618GeocodeViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface SGH0618GeocodeViewController ()
//地址
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
//经度
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;
//纬度
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;
//详细地址
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation SGH0618GeocodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"输入地址即可";
    // Do any additional setup after loading the view from its nib.
}

///地理编码
- (IBAction)geocoder:(id)sender {
    //创建编码对象
    CLGeocoder *geocoder = [CLGeocoder new];
    //判断是否为空
    if (self.addressTextField.text.length == 0) {
        return;
    }
    
    [geocoder geocodeAddressString:self.addressTextField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error != nil || placemarks.count == 0) {
            return ;
        }
        //创建placemark对象
        CLPlacemark *placemark = [placemarks firstObject];
        //赋值经度
        self.longitudeTextField.text = [NSString stringWithFormat:@"%f", placemark.location.coordinate.longitude];
        //赋值纬度
        self.latitudeTextField.text = [NSString stringWithFormat:@"%f", placemark.location.coordinate.latitude];
        
        //赋值详细地址
        self.textView.text = placemark.name;
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
