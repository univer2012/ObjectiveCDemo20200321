//
//  UIViewController+SGH0512Tracking.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/12.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "UIViewController+SGH0512Tracking.h"
#import <objc/runtime.h>

@implementation UIViewController (SGH0512Tracking)

//不用的时候注释，因为这个方法在整个工程都是生效的
//+(void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        // When swizzling a class method, use the following:
//        // Class class = object_getClass((id)self);
//        SEL originalSelector = @selector(viewWillAppear:);
//        SEL swizzledSelector = @selector(xxx_viewWillAppear:);
//        
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        
//        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//        if (didAddMethod) {
//            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        }
//        else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//}

//MARK: Method Swizzling
-(void)xxx_viewWillAppear:(BOOL)animated {
    [self xxx_viewWillAppear:animated];
    NSLog(@"viewWillAppear: %@", self);
}

@end
