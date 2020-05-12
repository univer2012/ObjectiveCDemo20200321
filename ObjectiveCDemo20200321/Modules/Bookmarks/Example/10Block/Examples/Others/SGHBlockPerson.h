//
//  SGHBlockPerson.h
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/9.
//  Copyright © 2020 远平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGHBlockPerson : NSObject

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) dispatch_block_t block;

@end

NS_ASSUME_NONNULL_END
