//
//  UIImage+SGHHook.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/5/3.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "UIImage+SGHHook.h"
#import <objc/runtime.h>

@implementation UIImage (SGHHook)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class selfClass = object_getClass([self class]);
        SEL oriSEL = @selector(imageNamed:);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);
        
        SEL cusSEL = @selector(myImageNamed:);
        Method cusMethod = class_getInstanceMethod(selfClass, cusSEL);
        
        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if (addSucc) {
            class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }
        else {
            method_exchangeImplementations(oriMethod, cusMethod);
        }
    });
}

+(UIImage *)myImageNamed:(NSString *)name {
    NSString *newName = [NSString stringWithFormat:@"%@%@", @"new_", name];
    return [self myImageNamed:newName];
}

@end
