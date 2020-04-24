//
//  SGHMethodSwizzlingObject.h
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/5/3.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGHMethodSwizzlingObject : NSObject

+(void)swizzleMethods:(Class)class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel;

@end
