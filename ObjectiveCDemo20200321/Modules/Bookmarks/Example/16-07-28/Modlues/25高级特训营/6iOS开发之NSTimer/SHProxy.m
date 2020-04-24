//
//  SHProxy.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/2/28.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHProxy.h"

#import <objc/runtime.h>

@implementation SHProxy

//第3点 慢速转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}
- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
