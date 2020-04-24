//
//  EOCFamily.h
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/3.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EOCPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface EOCFamily : NSObject
    
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)EOCPerson *person;
@property(nonatomic, strong)NSMutableArray *eocAry;

@end

NS_ASSUME_NONNULL_END
