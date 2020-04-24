//
//  TKUpdateHelperCache.m
//  TKApp_XDTX
//
//  Created by huangaengoln on 16/3/26.
//  Copyright © 2016年 liubao. All rights reserved.
//

#import "TKUpdateHelperCache.h"

@implementation TKUpdateHelperCache

//存账号
+(void)saveAccount:(NSString *)userName plistFileName:(NSString *)plistFileName {
    NSString *filename = [self p_getFileFullPathWithPlistFileName:plistFileName];
    //读文件
    NSMutableArray *array=[NSMutableArray arrayWithContentsOfFile:filename];
    if (array.count <= 0) {
        //创建
        NSFileManager *fm=[NSFileManager defaultManager];
        [fm createFileAtPath:filename contents:nil attributes:nil];
        array = [NSMutableArray array];
    }
    [array addObject:userName];
    //写入文件
    [array writeToFile:filename atomically:YES];
    
}
//读取所有文件
+(NSArray *)readAllAccountWithPlistFileName:(NSString *)plistFileName {
    NSString *filename = [self p_getFileFullPathWithPlistFileName:plistFileName];
    //读文件
     return [NSMutableArray arrayWithContentsOfFile:filename];
}

//删除一个账号
+(void)deleteAccount:(NSString *)userName plistFileName:(NSString *)plistFileName {
    NSString *filename = [self p_getFileFullPathWithPlistFileName:plistFileName];
    //读文件
    NSMutableArray *array=[NSMutableArray arrayWithContentsOfFile:filename];
    if ([array containsObject:userName]) {
        [array removeObject:userName];
    }
    [array writeToFile:filename atomically:YES];
}
//获取文件的全路径
+(NSString *)p_getFileFullPathWithPlistFileName:(NSString *)plistFileName {
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSLog(@"path = %@",path);
    //@"uniform_login_account_cache.plist"
    return [path stringByAppendingPathComponent:plistFileName];
}

@end
