//
//  UIButton+SHDistribute.m
//  ObjectiveCDemo160728
//
//  Created by sengoln huang on 2019/2/14.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "UIButton+SHDistribute.h"

#import <UIKit/UIKit.h>

#import <Masonry/Masonry.h>

@implementation UIButton (SHDistribute)

- (void)distributeViewsWithStyle:(SHViewEdgeInsetsStyle)style fixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing
{
    NSDictionary *attribute = @{NSFontAttributeName:self.titleLabel.font};
    
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:attribute];
    
    CGSize imgSize = self.imageView.image.size;
    
    CGFloat halfFixedSpace = fixedSpacing * 0.5;
    
//    __block typeof(self) weakSelf = self;
    switch (style) {
        case SHViewEdgeInsetsStyleLeading: {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -halfFixedSpace, 0, halfFixedSpace);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, halfFixedSpace, 0, -halfFixedSpace);
            
            
            CGFloat buttonHeight = self.bounds.size.height;
            if (buttonHeight < imgSize.height) {
                buttonHeight = imgSize.height;
            }
            if (buttonHeight < titleSize.height) {
                buttonHeight = titleSize.height;
            }
            
            self.bounds = CGRectMake(0, 0, leadSpacing + imgSize.width + fixedSpacing + titleSize.width + tailSpacing, buttonHeight);
        }
            break;
        case SHViewEdgeInsetsStyleTop: {
            //使图片和文字居左上角
            self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            
            CGFloat buttonWidth = self.bounds.size.width;
            
            //调整图片
            float iVOffsetY = leadSpacing;//(buttonHeight - imgSize.height + titleSize.height) / 2.0;
            float iVOffsetX = (buttonWidth - imgSize.width) / 2.0;
            [self setImageEdgeInsets:UIEdgeInsetsMake(iVOffsetY, iVOffsetX, 0, 0)];
            //调整文字
            float titleOffsetY = iVOffsetY + imgSize.height + fixedSpacing;
            float titleOffsetX = 0;
            if (imgSize.width >= buttonWidth / 2.0) {
                //如果图片的宽度超过或等于button宽度的一半
                titleOffsetX = -(imgSize.width + titleSize.width - buttonWidth / 2.0 - titleSize.width / 2.0);
            } else {
                titleOffsetX = buttonWidth / 2.0 - imgSize.width - titleSize.width / 2.0;
            }
            [self setTitleEdgeInsets:UIEdgeInsetsMake(titleOffsetY , titleOffsetX, 0, 0)];
            
            if (buttonWidth < imgSize.width) {
                buttonWidth = imgSize.width;
            }
            if (buttonWidth < titleSize.width) {
                buttonWidth = titleSize.width;
            }
            
            self.bounds = CGRectMake(0, 0, buttonWidth, leadSpacing + imgSize.height + fixedSpacing + titleSize.height + tailSpacing);
            
        }
            break;
        case SHViewEdgeInsetsStyleTrialing: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imgSize.width + halfFixedSpace), 0, (imgSize.width + halfFixedSpace));
            self.imageEdgeInsets = UIEdgeInsetsMake(0, (titleSize.width + halfFixedSpace), 0, -(titleSize.width + halfFixedSpace));
            
            CGFloat buttonHeight = self.bounds.size.height;
            if (buttonHeight < imgSize.height) {
                buttonHeight = imgSize.height;
            }
            if (buttonHeight < titleSize.height) {
                buttonHeight = titleSize.height;
            }
            
            self.bounds = CGRectMake(0, 0, leadSpacing + imgSize.width + fixedSpacing + titleSize.width + tailSpacing, buttonHeight);
            
        }
            break;
        case SHViewEdgeInsetsStyleBottom: {
            //使图片和文字居左上角
            self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            
            CGFloat buttonWidth = self.bounds.size.width;
            
            //调整文字
            float titleOffsetY = leadSpacing;//iVOffsetY + imgSize.height + fixedSpacing;
            float titleOffsetX = 0;
            if (imgSize.width >= buttonWidth / 2.0) {
                //如果图片的宽度超过或等于button宽度的一半
                titleOffsetX = -(imgSize.width + titleSize.width - buttonWidth / 2.0 - titleSize.width / 2.0);
            } else {
                titleOffsetX = buttonWidth / 2.0 - imgSize.width - titleSize.width / 2.0;
            }
            [self setTitleEdgeInsets:UIEdgeInsetsMake(titleOffsetY , titleOffsetX, 0, 0)];
            //调整图片
            float iVOffsetY = titleOffsetY + titleSize.height + fixedSpacing;
            float iVOffsetX = (buttonWidth - imgSize.width) / 2.0;
            [self setImageEdgeInsets:UIEdgeInsetsMake(iVOffsetY, iVOffsetX, 0, 0)];
            
            if (buttonWidth < imgSize.width) {
                buttonWidth = imgSize.width;
            }
            if (buttonWidth < titleSize.width) {
                buttonWidth = titleSize.width;
            }
            self.bounds = CGRectMake(0, 0, buttonWidth, leadSpacing + imgSize.height + fixedSpacing + titleSize.height + tailSpacing);
            
            
        }
            break;
    }
}

@end
