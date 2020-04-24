//
//  SH1902Person.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/2/22.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SH1902Person.h"

#import "SH1902SpareWheel.h"

#import <objc/runtime.h>

@implementation SH1902Person

void sendMessage(id self, SEL _cmd, NSString *msg) {
    NSLog(@"___%@",msg);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    //1、匹配方法
//    NSString *methodName = NSStringFromSelector(sel);
//    if ([methodName isEqualToString:@"sendMessage:"]) {
//        /**
//         v     ----- 代表 void
//         @     ----- 代表 id self
//         :     ----- 代表 SEL _cmd
//         @     ----- 代表 NSString *msg    */
//        class_addMethod(self, sel, (IMP)sendMessage, "v@:@");
//    }
    return NO;
}
/** 快速转发  */
- (id)forwardingTargetForSelector:(SEL)aSelector {
//    NSString *methodName = NSStringFromSelector(aSelector);
//    if ([methodName isEqualToString:@"sendMessage:"]) {
//        return [SH1902SpareWheel new];
//    }
    return [super forwardingTargetForSelector:aSelector];
}

/** 慢速转发  */
//1、方法签名
//2、消息转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSString *methodName = NSStringFromSelector(aSelector);
    if ([methodName isEqualToString:@"sendMessage:"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}
/** 消息转发  */
- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    SEL sel = [anInvocation selector];
//    SH1902SpareWheel *tempObj = [SH1902SpareWheel new];
//    if ([tempObj respondsToSelector:sel]) {
//        [anInvocation invokeWithTarget:tempObj];
//    }
//    else {
//        [super forwardInvocation:anInvocation];
//    }
    [super forwardInvocation:anInvocation];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"找不到方法");
}

@end
