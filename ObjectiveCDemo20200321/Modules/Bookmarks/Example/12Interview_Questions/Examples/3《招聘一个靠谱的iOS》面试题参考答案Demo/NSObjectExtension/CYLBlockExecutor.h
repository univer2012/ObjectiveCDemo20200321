//
//  CYLBlockExecutor.h
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/12/11.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//
// 这个类，可以理解为一个“事件”：当目标对象销毁时，同时要发生的“事件”。借助block执行“事件”。
#import <Foundation/Foundation.h>
typedef void (^voidBlock)(void);
@interface CYLBlockExecutor : NSObject
- (id)initWithBlock:(voidBlock)aBlock;
@end
