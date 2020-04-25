//
//  SGHTimerProxy.h
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/25.
//  Copyright © 2020 远平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGHTimerProxy : NSProxy

@property (nonatomic, weak) id target;
//lgProxy.target = self;

@end

NS_ASSUME_NONNULL_END
