//
//  YYQKeyChain.h
//  KeyChain-UDID
//
//  Created by YYQ on 14/11/13.
//  Copyright (c) 2014年 YYQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface YYQKeyChain : NSObject

/**
 * @author hsj, 16-05-07 10:05:00
 *
 * 获取唯一标识key的 UDID(其实是UUID)
 * @param uniqueKey
 * @return
 */
+ (NSString *)getUDIDWithUniqueKey:(NSString *)uniqueKey;

///用service 保存 data
+ (void)save:(NSString *)service data:(id)data;

///获取service为key的 UDID(其实是UUID)
+ (id)load:(NSString *)service;

///delete search dictionary
+ (void)delete:(NSString *)service;

@end