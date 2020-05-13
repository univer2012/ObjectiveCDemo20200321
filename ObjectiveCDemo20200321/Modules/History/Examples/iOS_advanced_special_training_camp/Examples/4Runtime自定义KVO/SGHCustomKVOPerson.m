//
//  SGHCustomKVOPerson.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/13.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHCustomKVOPerson.h"
#import <objc/message.h>

@implementation SGHCustomKVOPerson

- (void)setName:(NSString *)name {
    _name = name;
}

//private method C语言
void setterMethod(id self, SEL _cmd, NSString *name) {
    //1.调用父类方法
    //2.通知观察者调用`observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context`
    
    struct objc_super superClass = {
        self,
        class_getSuperclass([self class]),
    };
    objc_msgSendSuper(&superClass, _cmd, name);
    
    
    id observer = objc_getAssociatedObject(self, (__bridge const void *)@"objc");//获取观察者
    
    //通知观察者改变
    NSString *methodName = NSStringFromSelector(_cmd);
    NSString *key = getValueKey(methodName);  //key值是我们的属性名称
    
    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:), key, self, @{key: name}, nil);
    
    
}

//private method C语言
NSString *getValueKey(NSString *setter) {
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *key = [setter substringWithRange:range];      //拿到Name   字符串
    
    NSString *letter = [[key substringToIndex:1] lowercaseString];//拿到首字母小写
    
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:letter];
    return key;
}

///自定义KVO
- (void)lg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    
    //创建一个类
    NSString *oldName = NSStringFromClass([self class]);
    NSString *newName = [NSString stringWithFormat:@"CustomKVO_%@",oldName];
    
    //用objc_allocateClassPair创建一个类
    Class cutomClass = objc_allocateClassPair([self class], newName.UTF8String, 0);//分配 类对
    objc_registerClassPair(cutomClass); //注册 类对
    
    //修改 isa 指针
    object_setClass(self, cutomClass);
    
    //重写 set 方法
    NSString * methodName = [NSString stringWithFormat:@"set%@:",keyPath.capitalizedString]; //1.获取方法名称
    SEL sel = NSSelectorFromString(methodName);   //2.获取方法编号
    
    class_addMethod(cutomClass, sel, (IMP)setterMethod, "v@:@"); //添加方法实现
    
    objc_setAssociatedObject(self, (__bridge const void *)@"objc", observer, OBJC_ASSOCIATION_ASSIGN);  //关联属性
    
}

@end
