//
//  SGH0424MapFactory.h
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/4/24.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGH0424MapView.h"

@protocol SGH0424MapFactory <NSObject>

-(id<SGH0424MapView>)getMapView:(CGRect)frame;

@end
