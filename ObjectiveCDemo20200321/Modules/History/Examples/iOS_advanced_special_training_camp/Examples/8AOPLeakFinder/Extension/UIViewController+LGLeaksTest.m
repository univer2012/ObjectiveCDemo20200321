//
//  UIViewController+LGLeaksTest.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/25.
//  Copyright © 2020 远平. All rights reserved.
//

#import "UIViewController+LGLeaksTest.h"

#import <objc/runtime.h>
#import "NSObject+LGSwizzling.h"


const char * LGVCFLAG = "LGVCFLAG";

@implementation UIViewController (LGLeaksTest)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSEL:@selector(viewWillAppear:) withSEL:@selector(lg_viewWillAppear:)];
        
        [self swizzleSEL:@selector(viewDidDisappear:) withSEL:@selector(lg_viewDidDisAppear:)];
    });
}

- (void)lg_viewWillAppear:(BOOL)animate {
    [self lg_viewWillAppear:animate];
    
    objc_setAssociatedObject(self, LGVCFLAG, @(NO), OBJC_ASSOCIATION_ASSIGN);
}

- (void)lg_viewDidDisAppear:(BOOL)animate {
    [self lg_viewWillAppear:animate];
    if ([objc_getAssociatedObject(self, LGVCFLAG) boolValue]) {
        //pop
        [self willDealloc];
    }
}

@end
