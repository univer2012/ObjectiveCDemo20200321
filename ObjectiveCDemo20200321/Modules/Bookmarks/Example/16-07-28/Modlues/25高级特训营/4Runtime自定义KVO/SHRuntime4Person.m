//
//  SHRuntime4Person.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/2/27.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHRuntime4Person.h"

#import <objc/message.h>

@implementation SHRuntime4Person

//- (void)setName:(NSString *)name {
//    _name = name;
//    NSLog(@"custom");
//}


void setterMethod(id self,SEL _cmd, NSString *name){
    //1、调用父类方法
    //2、通知观察者调用`observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context`
    
    struct objc_super superClass = {
        self,
        class_getSuperclass([self class]),
    };
    objc_msgSendSuper(&superClass, _cmd, name);
    //获取观察者
    id observer = objc_getAssociatedObject(self, (__bridge const void *)@"objc");
    //通知改变
    NSString *methodName = NSStringFromSelector(_cmd);
    NSString *key = getValueKey(methodName);
    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:), key, self, @{key: name},nil);
}

NSString *getValueKey(NSString *setter) {
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *key = [setter substringWithRange:range];
    NSString *letter = [[key substringToIndex:1] lowercaseString];
    
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:letter];
    return  key;
}


- (void)lg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    //创建一个类
    NSString *oldName = NSStringFromClass([self class]);
    NSString *newName = [NSString stringWithFormat:@"CutomKVO_%@",oldName];
    //Swift是一门静态性语言
    Class cutomClass = objc_allocateClassPair([self class], newName.UTF8String, 0);
    objc_registerClassPair(cutomClass);
    
    //修改 isa指针
    object_setClass(self, cutomClass);
    //重写set 方法
    NSString *methodName = [NSString stringWithFormat:@"set%@:",keyPath.capitalizedString];
    SEL sel = NSSelectorFromString(methodName);
    class_addMethod(cutomClass, sel, setterMethod, "v@:@");
    //设置关联 观察者
    objc_setAssociatedObject(self, (__bridge const void *)@"objc", observer, OBJC_ASSOCIATION_ASSIGN);
}

@end
