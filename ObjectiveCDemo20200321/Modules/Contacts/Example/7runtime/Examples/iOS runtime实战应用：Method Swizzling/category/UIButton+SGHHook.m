//
//  UIButton+SGHHook.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/5/3.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "UIButton+SGHHook.h"
#import <objc/runtime.h>

@implementation UIButton (SGHHook)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class selfClass = [self class];
        
        SEL oriSEL = @selector(sendAction:to:forEvent:);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);
        
        SEL cusSEL = @selector(mySendAction:to:forEvent:);
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

-(void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    //额外添加你要做的事情
    NSLog(@"%s",__func__);
    //
    [self mySendAction:action to:target forEvent:event];
}

@end
