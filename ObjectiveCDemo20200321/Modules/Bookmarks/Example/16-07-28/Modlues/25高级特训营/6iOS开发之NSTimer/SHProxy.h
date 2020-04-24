//
//  SHProxy.h
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/2/28.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHProxy : NSProxy

/** Description  */
@property (nonatomic, weak)id target;
//lgProxy.target = self;

@end

NS_ASSUME_NONNULL_END
