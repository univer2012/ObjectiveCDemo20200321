//
//  WBURL.h
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/1/29.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WBPicture.h"

NS_ASSUME_NONNULL_BEGIN

/**
 链接
 */
@interface WBURL : NSObject

@property (nonatomic, assign) BOOL result;
@property (nonatomic, strong) NSString *shortURL; ///< 短域名 (原文)
@property (nonatomic, strong) NSString *oriURL;   ///< 原始链接
@property (nonatomic, strong) NSString *urlTitle; ///< 显示文本，例如"网页链接"，可能需要裁剪(24)
@property (nonatomic, strong) NSString *urlTypePic; ///< 链接类型的图片URL
@property (nonatomic, assign) int32_t urlType; ///< 0:一般链接 36地点 39视频/图片
@property (nonatomic, strong) NSString *log;
@property (nonatomic, strong) NSDictionary *actionLog;
@property (nonatomic, strong) NSString *pageID; ///< 对应着 WBPageInfo
@property (nonatomic, strong) NSString *storageType;
//如果是图片，则会有下面这些，可以直接点开看
@property (nonatomic, strong) NSArray<NSString *> *picIds;
@property (nonatomic, strong) NSDictionary<NSString *, WBPicture *> *picInfos;
@property (nonatomic, strong) NSArray<WBPicture *> *pics;

@end

NS_ASSUME_NONNULL_END
