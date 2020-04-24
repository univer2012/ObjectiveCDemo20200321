//
//  WBTimelineItem.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/1/29.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "WBTimelineItem.h"

@implementation WBTimelineItem

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"hasVisible" : @"hasvisible",
             @"previousCursor" : @"previous_cursor",
             @"uveBlank" : @"uve_blank",
             @"hasUnread" : @"has_unread",
             @"totalNumber" : @"total_number",
             @"maxID" : @"max_id",
             @"sinceID" : @"since_id",
             @"nextCursor" : @"next_cursor"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"statuses" : [WBStatus class]};
}

@end
