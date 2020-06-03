//
//  CTMediator+A.h
//  A_Category
//
//  Created by casa on 2016/12/10.
//  Copyright © 2016年 casa. All rights reserved.
//
/*
这个文件，是SGH_CTMediatorViewController 要去Avc。拿Avc的方法
*/
#import <CTMediator/CTMediator.h>
#import <UIKit/UIKit.h>

@interface CTMediator (A)
// Objective-C -> Category -> Swift
- (UIViewController *)A_Category_Swift_ViewControllerWithCallback:(void(^)(NSString *result))callback;

// Objective-C -> Category -> Objective-C
- (UIViewController *)A_Category_Objc_ViewControllerWithCallback:(void(^)(NSString *result))callback;

@end
