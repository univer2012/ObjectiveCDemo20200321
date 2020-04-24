//
//  WBTag.h
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/1/29.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 标签
 */
@interface WBTag : NSObject

@property (nonatomic, strong) NSString *tagName; ///< 标签名字，例如"上海·上海文庙"
@property (nonatomic, strong) NSString *tagScheme; ///< 链接 sinaweibo://...
@property (nonatomic, assign) int32_t tagType; ///< 1 地点 2其他
@property (nonatomic, assign) int32_t tagHidden;
@property (nonatomic, strong) NSURL *urlTypePic; ///< 需要加 _default

@end

NS_ASSUME_NONNULL_END
