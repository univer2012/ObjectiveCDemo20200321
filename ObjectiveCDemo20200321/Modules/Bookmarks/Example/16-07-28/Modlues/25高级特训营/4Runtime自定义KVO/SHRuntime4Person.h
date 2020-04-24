//
//  SHRuntime4Person.h
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/2/27.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHRuntime4Person : NSObject

/** name  */
@property (nonatomic, copy)NSString *name;

- (void)lg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;

@end

NS_ASSUME_NONNULL_END
