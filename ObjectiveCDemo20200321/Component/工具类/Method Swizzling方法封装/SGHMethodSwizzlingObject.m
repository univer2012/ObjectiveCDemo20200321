//
//  SGHMethodSwizzlingObject.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/5/3.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHMethodSwizzlingObject.h"
//#import <objc/objc.h>
#import <objc/runtime.h>

@implementation SGHMethodSwizzlingObject

+(void)swizzleMethods:(Class)class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel {
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method swizMethod = class_getInstanceMethod(class, swizSel);
    BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else {
        method_exchangeImplementations(origMethod, swizMethod);
    }
}

@end
