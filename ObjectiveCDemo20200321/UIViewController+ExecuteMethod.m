//
//  UIViewController+ExecuteMethod.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/25.
//  Copyright © 2020 远平. All rights reserved.
//

#import "UIViewController+ExecuteMethod.h"

@implementation UIViewController (ExecuteMethod)

- (void)executeSelectorWith:(NSString *)selText {
    SEL sel = NSSelectorFromString(selText);
    [self performSelector:sel];
}

@end
