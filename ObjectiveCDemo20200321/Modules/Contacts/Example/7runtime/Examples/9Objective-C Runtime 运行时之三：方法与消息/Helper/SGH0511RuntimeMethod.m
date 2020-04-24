//
//  SGH0511RuntimeMethod.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/11.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0511RuntimeMethod.h"

@interface SGH0511RuntimeMethodHelper:NSObject

-(void)method2;

@end

@implementation SGH0511RuntimeMethodHelper

-(void)method2 {
    NSLog(@"%@, %p", self, _cmd);
}



@end

#pragma mark -

@implementation SGH0511RuntimeMethod {
    SGH0511RuntimeMethodHelper *_helper;
}
+(instancetype)object {
    return [[self alloc]init];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _helper = [[SGH0511RuntimeMethodHelper alloc]init];
    }
    return self;
}

-(void)test {
    [self performSelector:@selector(method2)];
}


- (BOOL)respondsToSelector:(SEL)aSelector   {
    if ( [super respondsToSelector:aSelector] )
        return YES;
    else {
        /* Here, test whether the aSelector message can     
         *            
         * be forwarded to another object and whether that  
         *            
         * object can respond to it. Return YES if it can.  
         */
        //在这里，测试aSelector消息是否可以被转发到另一个对象，以及这个对象是否可以响应它。可以响应则返回YES。
    }
    return NO;
}

-(id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"forwardingTargetForSelector");
    NSString *selectorString = NSStringFromSelector(aSelector);
    //将消息转发给_helper来处理
    if ([selectorString isEqualToString:@"method2"]) {
        return _helper;
    }
    return [super forwardingTargetForSelector:aSelector];
}


-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        if ([SGH0511RuntimeMethodHelper instancesRespondToSelector:aSelector]) {
            signature = [SGH0511RuntimeMethodHelper instanceMethodSignatureForSelector:aSelector];
        }
    }
    return signature;
}

-(void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([SGH0511RuntimeMethodHelper instancesRespondToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_helper];
    }
}

@end
