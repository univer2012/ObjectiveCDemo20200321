//
//  SGH0503MRCPerson.h
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/3.
//  Copyright © 2020 远平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGH0503MRCPerson : NSObject

@property (nonatomic, assign)int age;

@property (nonatomic, strong)NSString *name;

@property (nonatomic, copy)NSString *fatherName;

@property (nonatomic, retain)NSString *motherName;

@end

NS_ASSUME_NONNULL_END
