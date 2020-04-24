//
//  WBPicture.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/1/29.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "WBPicture.h"

@implementation WBPicture

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"picID" : @"pic_id",
             @"keepSize" : @"keep_size",
             @"photoTag" : @"photo_tag",
             @"objectID" : @"object_id",
             @"middlePlus" : @"middleplus"};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    WBPictureMetadata *meta = _large ? _large : _largest ? _largest : _original;
    _badgeType = meta.badgeType;
    return YES;
}

@end
