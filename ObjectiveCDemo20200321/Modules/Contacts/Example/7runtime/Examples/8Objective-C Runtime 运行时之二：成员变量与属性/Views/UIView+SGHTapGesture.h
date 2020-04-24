//
//  UIView+SGHTapGesture.h
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/10.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SGHTapGesture)
-(void)setTapActionWithBlock:(void (^)(void))block;

@end
