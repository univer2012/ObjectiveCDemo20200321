//
//  WBButtonLink.h
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/1/29.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 按钮
 */
@interface WBButtonLink : NSObject

@property (nonatomic, strong) NSURL *pic;  ///< 按钮图片URL (需要加_default)
@property (nonatomic, strong) NSString *name; ///< 按钮文本，例如"点评"
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSDictionary *params;

@end

NS_ASSUME_NONNULL_END
