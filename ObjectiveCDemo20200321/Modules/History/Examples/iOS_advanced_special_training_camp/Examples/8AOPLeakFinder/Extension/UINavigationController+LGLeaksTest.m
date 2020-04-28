//
//  UINavigationController+LGLeaksTest.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/25.
//  Copyright © 2020 远平. All rights reserved.
//

#import "UINavigationController+LGLeaksTest.h"

#import <objc/runtime.h>
#import "NSObject+LGSwizzling.h"

@implementation UINavigationController (LGLeaksTest)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self swizzleSEL:@selector(popViewControllerAnimated:) withSEL:@selector(lg_popViewControllerAnimated:)];
    });
    
}

- (UIViewController *)lg_popViewControllerAnimated:(BOOL)animated {
    UIViewController *popVC = [self lg_popViewControllerAnimated:animated];
    if (popVC) {
        extern const char *LGVCFLAG;
        objc_setAssociatedObject(popVC, LGVCFLAG, @(YES), OBJC_ASSOCIATION_ASSIGN);
    }
    return popVC;
}

@end
