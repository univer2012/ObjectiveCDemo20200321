//
//  SGHPerson.m
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/12/13.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//
/**
 * 来自：
[《招聘一个靠谱的iOS》面试题参考答案](https://blog.csdn.net/csdn15150525313/article/details/47316239)
*/
#import "SGHReliableiOSPerson.h"

@implementation SGHReliableiOSPerson
@synthesize firstName = _firstName;
@synthesize lastName = _lastName;

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
-(void)setLastName:(NSString *)lastName {
    _lastName = @"";
}
-(NSString *)lastName {
    return @"";
}

@end
