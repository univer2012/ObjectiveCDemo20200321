//
//  SGH0424GaodeFactory.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/4/24.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0424GaodeFactory.h"
#import "SGH0424GaodeMapView.h"

//#import <AMapFoundationKit/AMapFoundationKit.h>

//实现类（实现高德地图工厂：用于管理高德地图需要创建的模块）
@implementation SGH0424GaodeFactory


- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化高德地图SDK
//        [AMapServices sharedServices].apiKey = @"c60dbb5b054048a08face88f4967f0f6";
    }
    return self;
}

-(id<SGH0424MapView>)getMapView:(CGRect)frame {
    return [[SGH0424GaodeMapView alloc]initWithFrame:frame];
}

@end
