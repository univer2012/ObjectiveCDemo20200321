//
//  WBTag.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/1/29.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "WBTag.h"

@implementation WBTag

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"tagHidden" : @"tag_hidden",
             @"tagName" : @"tag_name",
             @"tagScheme" : @"tag_scheme",
             @"tagType" : @"tag_type",
             @"urlTypePic" : @"url_type_pic"};
}

@end
