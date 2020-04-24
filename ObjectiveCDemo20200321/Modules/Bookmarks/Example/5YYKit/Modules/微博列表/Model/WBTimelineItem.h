//
//  WBTimelineItem.h
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/1/29.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WBStatus.h"

NS_ASSUME_NONNULL_BEGIN
/**
 一次API请求的数据
 */
@interface WBTimelineItem : NSObject

@property (nonatomic, strong) NSArray *ad;
@property (nonatomic, strong) NSArray *advertises;
@property (nonatomic, strong) NSString *gsid;
@property (nonatomic, assign) int32_t interval;
@property (nonatomic, assign) int32_t uveBlank;
@property (nonatomic, assign) int32_t hasUnread;
@property (nonatomic, assign) int32_t totalNumber;
@property (nonatomic, strong) NSString *sinceID;
@property (nonatomic, strong) NSString *maxID;
@property (nonatomic, strong) NSString *previousCursor;
@property (nonatomic, strong) NSString *nextCursor;
@property (nonatomic, strong) NSArray<WBStatus *> *statuses;

@end

NS_ASSUME_NONNULL_END
