//
//  NSString+Chinese.h
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/5/3.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

/**
 * @author hsj, 16-05-03 22:05:48
 *
 * 本例来自：http://www.jianshu.com/p/18cc511b5828
 */
#import <Foundation/Foundation.h>

@interface NSString (Chinese)

///判断是否是纯汉字
-(BOOL)isChinese;

///判断是否含有汉字
-(BOOL)includeChinese;

@end
