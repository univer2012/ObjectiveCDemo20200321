//
//  UIView+SGHTapGesture.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/10.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "UIView+SGHTapGesture.h"
#import <objc/runtime.h>

static NSString *kDTActionHandlerTapGestureKey = @"kDTActionHandlerTapGestureKey";
static NSString *kDTActionHandlerTapBlockKey = @"kDTActionHandlerTapBlockKey";

@implementation UIView (SGHTapGesture)

-(void)setTapActionWithBlock:(void (^)(void))block {
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(__handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

-(void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        if (action) {
            action();
        }
    }
}

@end
