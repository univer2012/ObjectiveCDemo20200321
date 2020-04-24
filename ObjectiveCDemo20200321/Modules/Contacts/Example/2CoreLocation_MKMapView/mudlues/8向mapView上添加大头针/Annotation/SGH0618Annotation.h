//
//  SGH0618Annotation.h
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/6/18.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SGH0618Annotation : NSObject<MKAnnotation>
///经纬度
@property(nonatomic)CLLocationCoordinate2D coordinate;
///标题
@property(nonatomic,copy)NSString *title;
///副标题
@property(nonatomic,copy)NSString *subtitle;

@end
