//
//  CYLUser.m
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/12/11.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//
/**
 * 来自：
[《招聘一个靠谱的iOS》面试题参考答案](https://blog.csdn.net/csdn15150525313/article/details/47316239)
*/
#import "CYLUser.h"

#import "NSObject+CYLRunAtDealloc.h"
#import <objc/runtime.h>

// .m文件
// http://weibo.com/luohanchenyilong/
// https://github.com/ChenYilong
//
@interface CYLUser()
@property(nonatomic,weak)NSObject *object;
@end
@implementation CYLUser {
    NSMutableSet *_friends;
}
-(void)setName:(NSString *)name {
    _name = [name copy];
}
-(void)setObject:(NSObject *)object {
    objc_setAssociatedObject(self, "object", object, OBJC_ASSOCIATION_ASSIGN);
    [object cyl_runAtDealloc:^{
        _object = nil;
    }];
}

- (instancetype)initWithName:(NSString *)name age:(int)age sex:(CYLSex)sex {
    if(self = [super init]) {
        _name = [name copy];
        _age = age;
        _sex = sex;
        _friends = [[NSMutableSet alloc] init];
    }
    return self;
}

-(void)addFriend:(CYLUser *)user {
    [_friends addObject:user];
}
-(void)removeFriend:(CYLUser *)user {
    [_friends removeObject:user];
}

-(id)copyWithZone:(NSZone *)zone {
    CYLUser *copy = [[[self copy] allocWithZone:zone] initWithName:_name age:_age sex:_sex];
    copy->_friends = [_friends mutableCopy];
    return copy;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    CYLUser *copy = [[[self copy]allocWithZone:zone] initWithName:_name age:_age sex:_sex];
    copy->_friends = [[NSMutableSet alloc] initWithSet:_friends copyItems:YES];
    return copy;
}
@end
