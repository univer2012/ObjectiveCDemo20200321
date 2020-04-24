//
//  SGH0424MapEngine.h
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/4/26.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SGH0424MapFactory.h"

//SDK 工厂引擎
@interface SGH0424MapEngine : NSObject

//获取具体的工厂(父类引用指向子类的实例)
//OOP 思想
-(id<SGH0424MapFactory>)getMapFactory;

@end
