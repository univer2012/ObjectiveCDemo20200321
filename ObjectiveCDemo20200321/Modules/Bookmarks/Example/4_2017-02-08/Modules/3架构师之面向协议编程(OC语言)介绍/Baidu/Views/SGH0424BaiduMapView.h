//
//  SGH0424BaiduMapView.h
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/4/24.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGH0424MapView.h"


//遵循地图协议
//遵循协议的目的是，在外部使用的是协议
@interface SGH0424BaiduMapView : NSObject<SGH0424MapView>

- (instancetype)initWithFrame:(CGRect)frame;

@end
