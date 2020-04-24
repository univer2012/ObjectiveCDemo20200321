//
//  WBPicture.h
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/1/29.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WBPictureMetadata.h"

NS_ASSUME_NONNULL_BEGIN
/**
 图片
 */
@interface WBPicture : NSObject

@property (nonatomic, strong) NSString *picID;
@property (nonatomic, strong) NSString *objectID;
@property (nonatomic, assign) int photoTag;
@property (nonatomic, assign) BOOL keepSize; ///< YES:固定为方形 NO:原始宽高比
@property (nonatomic, strong) WBPictureMetadata *thumbnail;  ///< w:180
@property (nonatomic, strong) WBPictureMetadata *bmiddle;    ///< w:360 (列表中的缩略图)
@property (nonatomic, strong) WBPictureMetadata *middlePlus; ///< w:480
@property (nonatomic, strong) WBPictureMetadata *large;      ///< w:720 (放大查看)
@property (nonatomic, strong) WBPictureMetadata *largest;    ///<       (查看原图)
@property (nonatomic, strong) WBPictureMetadata *original;   ///<
@property (nonatomic, assign) WBPictureBadgeType badgeType;

@end

NS_ASSUME_NONNULL_END
