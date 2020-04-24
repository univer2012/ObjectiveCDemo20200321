//
//  SGH0424MapEngine.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/4/26.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0424MapEngine.h"
#import "SGH0424BaiduFactory.h"

#import "SGH0424GaodeFactory.h"


//实现类(返回具体的客户端需要的地图)
@implementation SGH0424MapEngine

-(id<SGH0424MapFactory>)getMapFactory {
    //return [[SGH0424BaiduFactory alloc]init];
    return [[SGH0424GaodeFactory alloc]init];
}

@end
