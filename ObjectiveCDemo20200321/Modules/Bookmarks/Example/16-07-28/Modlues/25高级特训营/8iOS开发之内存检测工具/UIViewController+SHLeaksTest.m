//
//  UIViewController+SHLeaksTest.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/3/1.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "UIViewController+SHLeaksTest.h"

#import <objc/runtime.h>

@implementation UIViewController (SHLeaksTest)
/** 1、交换方法  */
+ (void)load {
    //load的本质是调用一次，为什么写单例呢？
    //因为有一次我做了方法交换，然后我的同事又触发了一次。所以为了保证x程序的健壮性，习惯把单例写上。
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}

- (void)lg_viewWillAppear:(BOOL)animate {
    
}

@end
