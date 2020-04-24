//
//  TKUpdateHelperCache.h
//  TKApp_XDTX
//
//  Created by huangaengoln on 16/3/26.
//  Copyright © 2016年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKUpdateHelperCache : NSObject


//存账号
+(void)saveAccount:(NSString *)userName plistFileName:(NSString *)plistFileName;

//读取多有文件
+(NSArray *)readAllAccountWithPlistFileName:(NSString *)plistFileName;

//删除一个账号
+(void)deleteAccount:(NSString *)userName plistFileName:(NSString *)plistFileName;

@end
