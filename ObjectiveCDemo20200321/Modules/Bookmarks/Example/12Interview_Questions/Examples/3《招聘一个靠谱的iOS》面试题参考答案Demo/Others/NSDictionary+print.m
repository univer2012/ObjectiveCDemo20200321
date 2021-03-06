//
//  NSDictionary+print.m
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/11/23.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "NSDictionary+print.h"

@implementation NSDictionary (print)
-(void)print {
    NSMutableString *result = [NSMutableString stringWithString:@"{"];
    //使用快速枚举语法来遍历NSDictionary
    //循环计数器将一次等于该NSDictionary的每个key
    for (id key in self) {
        [result appendString:[key description]];
        [result appendString:@"="];
        //使用下标访问法根据key来获取对应的value
        [result appendString:[self[key] description]];
        [result appendString:@", "];
    }
    //获取字符串长度
    NSUInteger len = [result length];
    //去掉字符串最后的两个字符
    [result deleteCharactersInRange:NSMakeRange(len - 2, 2)];
    [result appendString:@"}"];
    NSLog(@"%@", result);
}
@end
