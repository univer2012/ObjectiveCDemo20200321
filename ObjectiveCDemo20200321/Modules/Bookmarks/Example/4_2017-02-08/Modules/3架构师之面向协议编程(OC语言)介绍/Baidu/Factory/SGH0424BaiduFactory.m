//
//  SGH0424BaiduFactory.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/4/24.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0424BaiduFactory.h"
#import "SGH0424BaiduMapView.h"

//#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
//#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
@interface SGH0424BaiduFactory ()

//@property(nonatomic)BMKMapManager *mapManager;

@end


@implementation SGH0424BaiduFactory


- (instancetype)init
{
    self = [super init];
    if (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            //初始化百度地图SDK
//            // 要使用百度地图，请先启动BaiduMapManager
//            _mapManager = [[BMKMapManager alloc]init];
//            // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
//            BOOL ret = [_mapManager start:@"b2B1Xd9bcG7fEQhxQZ8kDe230H5GpC9o"  generalDelegate:nil];
//            if (!ret) {
//                NSLog(@"manager start failed!");
//            }
        });
    }
    return self;
}

-(id<SGH0424MapView>)getMapView:(CGRect)frame {
    return [[SGH0424BaiduMapView alloc]initWithFrame:frame];
}

@end
