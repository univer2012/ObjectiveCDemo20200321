//
//  SGH0324Person.h
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/24.
//  Copyright © 2020 远平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGH0324Person : NSObject {
    @public
    NSString *littleName; //小名
}

@property(assign, nonatomic)int age;

@property(copy,nonatomic)NSString *name;

-(void)changeName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
