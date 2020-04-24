//
//  SGH0506Test.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/6.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0506Test.h"
#import <objc/runtime.h>

void TestMetaClass(id self, SEL _cmd) {
    NSLog(@"This object is %p", self);
    NSLog(@"Class id %@, super class is %@", [self class], [self superclass]);
    
    Class currentClass = [self class];
    for (int i = 0; i < 4; i++) {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = objc_getClass((__bridge void *)currentClass);
    }
    
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", objc_getClass((__bridge void *)[NSObject class]));
}


@implementation SGH0506Test

-(void)ex_registerClassPair {
    Class newClass = objc_allocateClassPair([NSError class], "TestClass", 0);
    class_addMethod(newClass, @selector(testMetaClass), (IMP)TestMetaClass, "v@:");
    objc_registerClassPair(newClass);
    
    id instance = [[newClass alloc] initWithDomain:@"some domain" code:0 userInfo:nil];
    [instance performSelector:@selector(testMetaClass)];
}

@end
/*
 这个例子是在运行时创建了一个NSError的子类TestClass，然后为这个子类添加一个方法testMetaClass，这个方法的实现是TestMetaClass函数。
 
 
 运行后，打印结果是
 2017-05-06 09:16:02.210 ObjectiveCDemo160728[6892:5692761] This object is 0x60000024bee0
 2017-05-06 09:16:02.211 ObjectiveCDemo160728[6892:5692761] Class id TestClass, super class is NSError
 2017-05-06 09:16:02.211 ObjectiveCDemo160728[6892:5692761] Following the isa pointer 0 times gives 0x6000002443e0
 2017-05-06 09:16:02.211 ObjectiveCDemo160728[6892:5692761] Following the isa pointer 1 times gives 0x0
 2017-05-06 09:16:02.212 ObjectiveCDemo160728[6892:5692761] Following the isa pointer 2 times gives 0x0
 2017-05-06 09:16:02.212 ObjectiveCDemo160728[6892:5692761] Following the isa pointer 3 times gives 0x0
 2017-05-06 09:16:02.212 ObjectiveCDemo160728[6892:5692761] NSObject's class is 0x10a54fe58
 2017-05-06 09:16:02.212 ObjectiveCDemo160728[6892:5692761] NSObject's meta class is 0x0
 
 
 我们在for循环中，我们通过objc_getClass来获取对象的isa，并将其打印出来，依此一直回溯到NSObject的meta-class。分析打印结果，可以看到最后指针指向的地址是0x0，即NSObject的meta-class的类地址。
 
 
 这里需要注意的是：我们在一个类对象调用class方法是无法获取meta-class，它只是返回类而已。
 */
