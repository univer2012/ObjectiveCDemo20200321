//
//  Girl+Ex.h
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/8.
//  Copyright © 2020 远平. All rights reserved.
//


#import "Girl.h"

NS_ASSUME_NONNULL_BEGIN

@interface Girl (Ex)

///暴露Girl 的 私有方法 runText
- (void)runText;

///暴露Girl 的 私有属性littleName
@property (nonatomic, copy) NSString *littleName;   //小名

@end

NS_ASSUME_NONNULL_END
