//
//  SGH0729Button.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/8/1.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0729Button.h"

@implementation SGH0729Button

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageWidth = 40;
    CGFloat imageHeight = 47;
    CGFloat imageX = (contentRect.size.width - imageWidth) * 0.5;
    CGFloat imageY = 20;
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

@end
