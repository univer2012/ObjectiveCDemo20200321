//
//  XGImageTitleView.m
//  xglc
//
//  Created by sengoln huang on 2018/2/6.
//  Copyright © 2018年 深圳市温馨港湾网络技术有限公司. All rights reserved.
//

#import "XGImageTitleView.h"

#import <Masonry/Masonry.h>

@interface XGImageTitleView()

@end

@implementation XGImageTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        __block typeof(self) weakSelf = self;
        UIImageView *imageView = ({
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView sizeToFit];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [weakSelf addSubview:imageView];
            imageView;
        });
        _imageView = imageView;
        UILabel *titleLabel = ({
            UILabel *label = [UILabel new];
            [label sizeToFit];
            //label.textColor = HEXCOLOR(0xa8a8a8);
            label.font = [UIFont systemFontOfSize:10];
            [weakSelf addSubview:label];
            label;
        });
        _titleLabel = titleLabel;
    }
    return self;
}

- (void)rectViewsWithStyle:(XGViewEdgeInsetsStyle)style fixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing
{
    __block typeof(self) weakSelf = self;
    switch (style) {
        case XGViewEdgeInsetsStyleImageTop: {
            
        }
            break;
        case XGViewEdgeInsetsStyleImageLeading: {
            
        }
            break;
        case XGViewEdgeInsetsStyleImageBottom: {
            
        }
            break;
        case XGViewEdgeInsetsStyleImageTrailing: {
            
            
        }
            break;
    }
}

- (void)xg_distributeViewsWithStyle:(XGViewEdgeInsetsStyle)style fixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    __block typeof(self) weakSelf = self;
    switch (style) {
        case XGViewEdgeInsetsStyleImageTop: {
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf).offset( leadSpacing );
                //make.centerX.equalTo(weakSelf);
                if (self.imageSize.height) {
                    make.size.mas_equalTo( self.imageSize );
                }
                //make.width.equalTo(weakSelf);
                make.leading.trailing.equalTo(weakSelf);
            }];
            
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.imageView.mas_bottom).offset( fixedSpacing );
                //make.centerX.equalTo(weakSelf);
                make.bottom.equalTo(weakSelf).offset( -tailSpacing );//lessThanOrEqualTo
                //make.width.equalTo(weakSelf);
                make.leading.trailing.equalTo(weakSelf);
            }];
        }
            break;
        case XGViewEdgeInsetsStyleImageLeading: {
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(weakSelf).offset( leadSpacing );
                //make.centerY.equalTo(weakSelf);
                //make.height.equalTo(weakSelf);
                make.top.bottom.equalTo(weakSelf);
                if (self.imageSize.height) {
                    make.size.mas_equalTo( self.imageSize );
                }
                
            }];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(weakSelf.imageView.mas_trailing).offset( fixedSpacing );
                make.top.bottom.equalTo(weakSelf);//为解决Height and vertical position are ambiguous for ...
                //为解决：XGImageTitleView has ambiguous layout.
                //make.trailing.lessThanOrEqualTo(weakSelf).offset( -tailSpacing );
                make.trailing.equalTo(weakSelf).offset( -tailSpacing );
                //make.height.equalTo(weakSelf);
            }];
        }
            break;
        case XGViewEdgeInsetsStyleImageBottom: {
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(weakSelf).offset( -leadSpacing );
                make.centerX.equalTo(weakSelf);
                if (self.imageSize.height) {
                    make.size.mas_equalTo( self.imageSize );
                }
            }];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(weakSelf.imageView.mas_top).offset( -fixedSpacing );
                make.centerX.equalTo(weakSelf);
                make.top.equalTo(weakSelf).offset( tailSpacing );
            }];
        }
            break;
        case XGViewEdgeInsetsStyleImageTrailing: {
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.trailing.equalTo(weakSelf).offset( -leadSpacing );
                make.centerY.equalTo(weakSelf);
                if (self.imageSize.height) {
                    make.size.mas_equalTo( self.imageSize );
                }
                make.height.equalTo(weakSelf);
            }];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.trailing.equalTo(weakSelf.imageView.mas_leading).offset( -fixedSpacing );
                make.leading.equalTo(weakSelf).offset( tailSpacing );
                make.centerY.equalTo(weakSelf);
                make.height.equalTo(weakSelf);
            }];
            
        }
            break;
    }
}

@end
