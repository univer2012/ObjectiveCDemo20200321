//
//  SGH0324Person.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/24.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGH0324Person.h"
#import <Foundation/NSKeyValueObserving.h>

@implementation SGH0324Person

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name=@"default";
    }
    return self;
}
-(void)changeName:(NSString *)name {
    if ([_name isEqualToString:name]) {
        return;
    }
    NSLog(@"%s",__func__);
    [self willChangeValueForKey:@"name"];
    _name=name;
    [self didChangeValueForKey:@"name"];
}
//这里重写  + (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
//没有什么卵用，只是方便查看调用顺序。因为auto这个方法只和setter相关，而现在是调用自定义方法并且内部直接访问成员变量。
//至于内部设置的那个name拦截，纯属为了娱乐😂
+(BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
//    return YES;
    NSLog(@"%s",__func__);
    if ([key isEqualToString:@"name"]) {
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}
//+(BOOL)automaticallyNotifiesObserversForKey:(NSString *)key;
//控制是否自动发送通知，如果返回NO，KVO无法自动运作，需手动触发。因为前两个方法默认是在setter中实现的（用KVO做键值观察后，系统会在运行时重写被观察对象属性的setter），即：

-(void)setName:(NSString *)name {
    if ([_name isEqualToString:name]) {
        return;
    }
    [self willChangeValueForKey:@"name"];
    _name=name;
    [self didChangeValueForKey:@"name"];
}

@end
