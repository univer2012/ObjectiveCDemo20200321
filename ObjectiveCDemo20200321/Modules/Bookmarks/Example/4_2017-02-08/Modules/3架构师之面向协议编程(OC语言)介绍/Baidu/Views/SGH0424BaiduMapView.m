//
//  SGH0424BaiduMapView.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/4/24.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0424BaiduMapView.h"

//#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
//#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

//百度具体的实现类(专门用于处理百度地图MapView)
//用来管理百度地图MapView
@interface SGH0424BaiduMapView ()
//@property(nonatomic)BMKMapView* mapView;

@end

@implementation SGH0424BaiduMapView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        //初始化百度地图MapView
//        _mapView = [[BMKMapView alloc]initWithFrame:frame];
    }
    return self;
}

-(UIView *)getView {
//    return _mapView;
    return [UIView new];
}

@end
