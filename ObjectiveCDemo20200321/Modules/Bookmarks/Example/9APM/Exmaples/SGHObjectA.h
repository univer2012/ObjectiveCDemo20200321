//
//  SGHObjectA.h
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/27.
//  Copyright © 2020 远平. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SGHObjectB;

NS_ASSUME_NONNULL_BEGIN

@interface SGHObjectA : NSObject

@property (nonatomic, strong)SGHObjectB *objectB;

@property (nonatomic, weak)SGHObjectB *b;

@end

NS_ASSUME_NONNULL_END
