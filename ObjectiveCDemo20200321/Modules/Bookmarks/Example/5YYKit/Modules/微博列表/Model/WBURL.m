//
//  WBURL.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/1/29.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "WBURL.h"

@implementation WBURL

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"oriURL" : @"ori_url",
             @"urlTitle" : @"url_title",
             @"urlTypePic" : @"url_type_pic",
             @"urlType" : @"url_type",
             @"shortURL" : @"short_url",
             @"actionLog" : @"actionlog",
             @"pageID" : @"page_id",
             @"storageType" : @"storage_type",
             @"picIds" : @"pic_ids",
             @"picInfos" : @"pic_infos"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"picIds" : [NSString class],
             @"picInfos" : [WBPicture class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    // 自动 model-mapper 不能完成的，这里可以进行额外处理
    _pics = nil;
    if (_picIds.count != 0) {
        NSMutableArray *pics = [NSMutableArray new];
        for (NSString *picId in _picIds) {
            WBPicture *pic = _picInfos[picId];
            if (pic) {
                [pics addObject:pic];
            }
        }
        _pics = pics;
    }
    return YES;
}

@end
