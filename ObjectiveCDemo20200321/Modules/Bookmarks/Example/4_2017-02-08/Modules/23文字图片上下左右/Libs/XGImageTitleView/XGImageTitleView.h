//
//  XGImageTitleView.h
//  xglc
//
//  Created by sengoln huang on 2018/2/6.
//  Copyright © 2018年 深圳市温馨港湾网络技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    XGViewEdgeInsetsStyleImageLeading = 8,
    XGViewEdgeInsetsStyleImageTrailing,
    XGViewEdgeInsetsStyleImageTop,
    XGViewEdgeInsetsStyleImageBottom
} XGViewEdgeInsetsStyle;

@interface XGImageTitleView : UIView

@property(nonatomic, assign)CGSize imageSize;
@property(nonatomic, assign)BOOL hasSetImage;//是否设置图片了 默认为NO

@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UILabel *titleLabel;

@property(nonatomic,getter=isSelected) BOOL selected; 






- (void)xg_distributeViewsWithStyle:(XGViewEdgeInsetsStyle)style fixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;


@end
