//
//  WBTopic.h
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/1/29.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 话题
 */
@interface WBTopic : NSObject

@property (nonatomic, strong) NSString *topicTitle; ///< 话题标题
@property (nonatomic, strong) NSString *topicURL; ///< 话题链接 sinaweibo://

@end

NS_ASSUME_NONNULL_END
