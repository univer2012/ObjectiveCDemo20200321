//
//  WBPictureMetadata.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/1/29.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "WBPictureMetadata.h"

@implementation WBPictureMetadata

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cutType" : @"cut_type"};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if ([_type isEqualToString:@"GIF"]) {
        _badgeType = WBPictureBadgeTypeGIF;
    } else {
        if (_width > 0 && (float)_height / _width > 3) {
            _badgeType = WBPictureBadgeTypeLong;
        }
    }
    return YES;
}

@end
