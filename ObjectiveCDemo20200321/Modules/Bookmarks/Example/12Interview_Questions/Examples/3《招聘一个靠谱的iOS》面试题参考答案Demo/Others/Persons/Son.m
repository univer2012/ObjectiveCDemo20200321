//
//  Son.m
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/12/1.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "Son.h"

@implementation Son
- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
        /*output:
        NSStringFromClass([self class]) = Son
        NSStringFromClass([super class]) = Son
         */

    }
    return self;
}
@end
