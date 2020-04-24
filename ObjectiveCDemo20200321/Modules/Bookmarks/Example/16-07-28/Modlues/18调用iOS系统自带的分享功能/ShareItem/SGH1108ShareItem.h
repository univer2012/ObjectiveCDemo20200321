//
//  SGH1108ShareItem.h
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2016/11/8.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SGH1108ShareItem : NSObject
-(instancetype)initWithData:(UIImage*)img andFile:(NSURL*)file;

@property (nonatomic, strong) UIImage *img;
@property (nonatomic, strong) NSURL *path;

@end
