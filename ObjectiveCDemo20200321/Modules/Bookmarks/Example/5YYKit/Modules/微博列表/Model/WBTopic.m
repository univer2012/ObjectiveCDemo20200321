//
//  WBTopic.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/1/29.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "WBTopic.h"

@implementation WBTopic

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"topicTitle" : @"topic_title",
             @"topicURL" : @"topic_url"};
}

@end
