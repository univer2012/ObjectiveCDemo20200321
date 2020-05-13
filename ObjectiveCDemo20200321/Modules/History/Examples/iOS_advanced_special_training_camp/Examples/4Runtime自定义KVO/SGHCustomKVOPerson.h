//
//  SGHCustomKVOPerson.h
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/13.
//  Copyright © 2020 远平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGHCustomKVOPerson : NSObject

@property(nonatomic, copy)NSString *name;

///自定义KVO
- (void)lg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;

@end

NS_ASSUME_NONNULL_END
