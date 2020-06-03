//
//  CTMediator+A.m
//  A_Category
//
//  Created by casa on 2016/12/10.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "CTMediator+A.h"

@implementation CTMediator (A)

// Objective-C -> Category -> Swift
//执行swift文件 `Target_A` 的 `Action_Category_ViewController` 方法
- (UIViewController *)A_Category_Swift_ViewControllerWithCallback:(void (^)(NSString *))callback
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"callback"] = callback;
    params[kCTMediatorParamsKeySwiftTargetModuleName] = NSBundle.mainBundle.infoDictionary[@"CFBundleExecutable"];
    //@"A_swift";
    
    return [self performTarget:@"A" action:@"Category_ViewController" params:params shouldCacheTarget:NO];
}

// Objective-C -> Category -> Objective-C
//执行OC文件 `Target_A` 的 `Action_Category_ViewController` 方法
- (UIViewController *)A_Category_Objc_ViewControllerWithCallback:(void (^)(NSString *))callback
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"callback"] = callback;
    return [self performTarget:@"A" action:@"Category_ViewController" params:params shouldCacheTarget:NO];
}

@end
