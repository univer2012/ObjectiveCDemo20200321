//
//  Person.m
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/12/1.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "ReliableiOSPerson.h"

@implementation ReliableiOSPerson
+(void)load {
    NSLog(@"%s", __func__);
}
+(void)initialize {
    [super initialize];
    NSLog(@"%s %@", __func__, [self class]);
}
- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%s", __func__);
    }
    return self;
}
@end
