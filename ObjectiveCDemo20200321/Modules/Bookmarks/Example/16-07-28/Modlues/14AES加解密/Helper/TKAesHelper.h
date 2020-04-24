//
//  TKAesHelper.h
//  AESDemo
//
//  Created by huangaengoln on 16/6/14.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKAesHelper : NSObject
/**
 *  Aes加密
 *
 *  @param data 数据
 *  @param key    秘钥
 *
 *  @return 加密后的数据
 */
+(NSData *)dataWithAesEncryptData:(NSData *)data withKey:(NSString *)key;


@end
