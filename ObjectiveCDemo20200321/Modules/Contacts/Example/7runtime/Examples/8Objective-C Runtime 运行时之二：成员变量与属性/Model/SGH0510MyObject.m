//
//  SGH0510MyObject.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/10.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0510MyObject.h"
#import <objc/runtime.h>

static NSMutableDictionary *map = nil;
@implementation SGH0510MyObject

+(void)load {
    map = [NSMutableDictionary dictionary];
    map[@"name1"] = @"name";
    map[@"status1"] = @"status";
    map[@"name2"] = @"name";
    map[@"status2"] = @"status";
}

-(void)setDataWithDic:(NSDictionary *)dic {
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
#if 0
        NSString *propertyKey = @"";//[self propertyForKey:key];
        if (propertyKey) {
            objc_property_t property = class_getProperty([self class], [propertyKey UTF8String]);
            //TODO: 针对特殊数据类型做处理
            NSString *attributeString = [NSString stringWithCString:property_getAttributes((__bridge objc_property_t)(propertyKey)) encoding:NSUTF8StringEncoding];
            //...
            [self setValue:obj forKey:propertyKey];
        }
#endif
    }];
}


@end
