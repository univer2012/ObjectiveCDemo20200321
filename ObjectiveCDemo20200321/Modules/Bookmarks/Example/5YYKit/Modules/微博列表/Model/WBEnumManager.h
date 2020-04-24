//
//  WBEnumManager.h
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/1/29.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#ifndef WBEnumManager_h
#define WBEnumManager_h

/// 认证方式
typedef NS_ENUM(NSUInteger, WBUserVerifyType){
    WBUserVerifyTypeNone = 0,     ///< 没有认证
    WBUserVerifyTypeStandard,     ///< 个人认证，黄V
    WBUserVerifyTypeOrganization, ///< 官方认证，蓝V
    WBUserVerifyTypeClub,         ///< 达人认证，红星
};


/// 图片标记
typedef NS_ENUM(NSUInteger, WBPictureBadgeType) {
    WBPictureBadgeTypeNone = 0, ///< 正常图片
    WBPictureBadgeTypeLong,     ///< 长图
    WBPictureBadgeTypeGIF,      ///< GIF
};

#endif /* WBEnumManager_h */
