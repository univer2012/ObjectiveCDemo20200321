//
//  NSObject+LGSwizzling.h
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/25.
//  Copyright © 2020 远平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LGSwizzling)

- (void)willDealloc;

+ (void)swizzleSEL:(SEL)originSEL withSEL:(SEL)swizzlingSEL;

@end

NS_ASSUME_NONNULL_END
