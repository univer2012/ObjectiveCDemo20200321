//
//  SGHMemoryManagementViewController+MRC.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/18.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHMemoryManagementViewController+MRC.h"

@implementation SGHMemoryManagementViewController (MRC)

//MARK: - section 2
//MARK: 1.实例化NSAutoreleasePool
- (void)sec2demo1 {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    id obj = [[NSObject alloc] init];
    [obj autorelease];
    NSLog(@"执行[obj autorelease]后: %lu", (unsigned long)[obj retainCount]);
    [pool drain];
    
    //NSLog(@"drain后: %lu", (unsigned long)[obj retainCount]);
}

//MARK: 5.模拟类方法`array`的实现
- (void)sec1demo5 {
    id obj = [NSMutableArray t_array];
    NSLog(@"初始化: %lu", (unsigned long)[obj retainCount]);
}


//MARK: 4.无法释放 非自己持有的对象（会崩溃）
- (void)sec1demo4 {
    // 释放一个不属于自己的对象
    id obj = [NSMutableArray array];
    NSLog(@"初始化: %lu", (unsigned long)[obj retainCount]);
    
    // obj没有进行retain操作而进行release操作， 然后autoreleasePool也会对其进行一次release操作，导致奔溃。
    //后面会讲到autorelease。
    [obj release];
    
    //NSLog(@"执行[obj release]后: %lu", (unsigned long)[obj retainCount]);
}

//MARK: 3.不再需要自己持有对象时释放（会崩溃）
- (void)sec1demo3 {
    id obj = [NSMutableArray array];
    NSLog(@"初始化: %lu", (unsigned long)[obj retainCount]);
    
    [obj retain];
    NSLog(@"执行[obj retain]后: %lu", (unsigned long)[obj retainCount]);
    
    // 当obj不在需要持有的对象，那么，obj应该发送release消息
    [obj release];
    NSLog(@"执行[obj release]后: %lu", (unsigned long)[obj retainCount]);
    
    // 释放了对象还进行释放,会导致奔溃
    [obj release];
}

//MARK: 2.非自己生成的对象，自己也能持有
- (void)sec1demo2 {
    // NSMutableArray通过类方法array产生了对象(并没有使用alloc、new、copy、 mutableCopt来产生对象),因此该对象不属于obj自身产生的
    // 因此，需要使用retain方法让对象计数器+1,从而obj可以持有该对象(尽管该对象不是他产生的)
    id obj = [NSMutableArray array];
    NSLog(@"初始化: %lu", (unsigned long)[obj retainCount]);
    
    [obj retain];
    NSLog(@"执行[obj retain]后: %lu", (unsigned long)[obj retainCount]);
}



@end


@implementation NSMutableArray (CustomArr)

+ (instancetype)t_array {
    //自己持有对象
    id obj = [[NSMutableArray alloc]init];
    
    [obj autorelease];
    
    //取得的对象存在，但自己不持有对象
    return obj;
}

@end
