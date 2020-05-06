//
//  UIViewController+Description.h
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/24.
//  Copyright © 2020 远平. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Description)

- (UILabel *)showDescWith:(NSString *)text;

- (UIButton *)buildBtnWith:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
