//
//  UIButton+SHDistribute.h
//  ObjectiveCDemo160728
//
//  Created by sengoln huang on 2019/2/14.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SHViewEdgeInsetsStyleLeading = 8,
    SHViewEdgeInsetsStyleTop,
    SHViewEdgeInsetsStyleTrialing,
    SHViewEdgeInsetsStyleBottom,
} SHViewEdgeInsetsStyle;

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (SHDistribute)

- (void)distributeViewsWithStyle:(SHViewEdgeInsetsStyle)style fixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;

@end

NS_ASSUME_NONNULL_END
