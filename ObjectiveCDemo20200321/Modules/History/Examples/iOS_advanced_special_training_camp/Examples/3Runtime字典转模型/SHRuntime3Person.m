//
//  SHRuntime3Person.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/2/27.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHRuntime3Person.h"

#import <objc/message.h>

@implementation SHRuntime3Person
/** 模型转字典  */
// key - value
//set方法
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        for (NSString *key in dic.allKeys) {
            id value = dic[key];
            //objc_msgSend(id, sel, value)
            NSString *methodName = [NSString stringWithFormat:@"set%@:",key.capitalizedString];
            SEL sel = NSSelectorFromString(methodName);
            if (sel) {
                
                ((void(*)(id, SEL, id))objc_msgSend)(self, sel, value);
            }
        }
    }
    return self;
}

/** 字典转模型
 字典里面需要 key - value
 key : class_getPropertyList()
 value : get方法（objc_msgSend）
 */
- (NSDictionary *)convertModelToDic {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(self, &count);
    if (count != 0) {
        NSMutableDictionary *tempDic = [@{} mutableCopy];
        for (int i = 0; i < count; i++) {
            const void *propertyName = property_getName(properties[i]);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            SEL sel = NSSelectorFromString(name);
            if (sel) {
                id value = ((id(*)(id, SEL))objc_msgSend)(self, sel);
                if (value) {
                    tempDic[name] = value;
                } else {
                    tempDic[name] = @"";
                }
            }
        }
        return tempDic;
    }
    free(properties);
    return nil;
}

@end
