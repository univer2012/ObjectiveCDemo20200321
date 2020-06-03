//
//  CTMediator+B.h
//  B_Category
//
//  Created by 赵希帆 on 2017/8/16.
//  Copyright © 2017年 赵希帆. All rights reserved.
//
/*
 这个文件，是Avc 要去Bvc。拿Bvc的方法
 */
#import <Foundation/Foundation.h>
#import <CTMediator/CTMediator.h>

@interface CTMediator (B)

- (UIViewController *)B_viewControllerWithContentText:(NSString *)contentText;

@end
