//
//  SGH170506MyClass.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/6.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH170506MyClass.h"

@interface SGH170506MyClass () {
    NSInteger _instance1;
    NSString *_instance2;
}
@property(nonatomic,assign) NSUInteger integer;

@end

@implementation SGH170506MyClass

+(void)classMethod1 {
    
}

-(void)method1 {
    NSLog(@"call method method1");
}

-(void)method2 {
    
}

-(void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2 {
    NSLog(@"arg1: %ld, arg2: %@", arg1, arg2);
}

@end
