//
//  SGH0428StringViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/28.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 来自：
 1. [NSString用copy修饰的原因](https://www.cnblogs.com/billios/p/5590607.html)
 2. []()
 */
#import "SGH0428StringViewController.h"

@interface SGH0428StringViewController ()

@property (retain, nonatomic) NSString *retainStr;
@property (copy, nonatomic)   NSString *copyStr;
@property (retain, nonatomic) NSMutableString *retainMStr;
@property (copy, nonatomic)   NSMutableString *copyMStr;

@end

@implementation SGH0428StringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = SHBaseTableTypeMethod;
    //MARK: section 1
    
    NSArray *tempTitleArray = @[
        @"1.验证：属性是retain修饰的，就是浅拷贝，引用计数加1。\n 属性是copy修饰的，就是深拷贝，引用计数等于1（因为从堆里新分配一个内存块）。",
        @"2. 当一个不可变字符串（NSString）赋值给一个字符串属性 （无论这个字符串是NSString还是NSMutableString），就不存在安全性问题，都是深拷贝。 \n 此时无论retain还是copy都无所谓。",
    ];
    NSArray *tempClassNameArray = @[
        @"demo1",
        @"demo2",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@""];
    
    [self.tableView reloadData];
}

//MARK: 2.当一个不可变字符串（NSString）赋值给一个字符串属性（无论这个字符串是NSString还是NSMutableString），就不存在安全性问题，都是深拷贝。 此时无论retain还是copy都无所谓。
- (void)demo2 {
    NSString *str = @"我来了";//[[NSString alloc] initWithString:@"我来了"];//两种方式都一样。都在常量区
    
    self.retainStr  = str;
    self.copyStr    = str;
    self.retainMStr = [str mutableCopy];
    self.copyMStr   = [str mutableCopy];
    
    NSLog(@"retainStr:%@",  self.retainStr);
    NSLog(@"copyStr:%@",    self.copyStr);
    NSLog(@"retainMStr:%@", self.retainMStr);
    NSLog(@"copyMStr:%@",   self.copyMStr);
    
    NSLog(@"\n");
    
    str =@"我走了";//[[NSStringalloc] initWithString:@"我走了"];//两种方式都一样
    
    NSLog(@"retainStr:%@",  self.retainStr);
    NSLog(@"copyStr:%@",    self.copyStr);
    NSLog(@"retainMStr:%@", self.retainMStr);
    NSLog(@"copyMStr:%@",   self.copyMStr);
    
    NSLog(@"\n");
}

//MARK: 1.验证：属性是retain修饰的，就是浅拷贝，引用计数加1。\n 属性是copy修饰的，就是深拷贝，引用计数等于1（因为从堆里新分配一个内存块）。
- (void)demo1 {
    NSMutableString *mStr = [NSMutableString string];
    
    [mStr setString:@"我没变-------"];
    self.retainStr   = mStr;  // 浅拷贝，引用计数加1，
    NSLog(@"%ld",[self.retainStr retainCount]);// 2
    
    self.copyStr     = mStr;    // 深拷贝，
    NSLog(@"%ld",[self.copyStr retainCount]);// 1
    
    self.retainMStr = mStr;   // 浅拷贝，引用计数加1，
    NSLog(@"%ld",[self.retainMStr retainCount]);// 3
    
    self.copyMStr   = mStr;   // 深拷贝
    NSLog(@"%ld",[self.copyMStr retainCount]);// 1
    
    
    
    NSLog(@"retainStr:%@",  self.retainStr);
    NSLog(@"copyStr:%@",    self.copyStr);
    NSLog(@"retainMStr:%@", self.retainMStr);
    NSLog(@"copyMStr:%@",   self.copyMStr);
    
    NSLog(@"\n");
    
    [mStr setString:@"我变了--------"];
    
    NSLog(@"retainStr:%@",  self.retainStr);// 浅拷贝
    NSLog(@"%ld",[self.retainStr retainCount]);// 3
    
    NSLog(@"copyStr:%@",    self.copyStr);// 深拷贝
    NSLog(@"%ld",[self.copyStr retainCount]);// 1
    
    NSLog(@"retainMStr:%@", self.retainMStr);// 浅拷贝
    NSLog(@"%ld",[self.retainMStr retainCount]);// 3
    
    NSLog(@"copyMStr:%@",   self.copyMStr);// 深拷贝
    NSLog(@"%ld",[self.copyMStr retainCount]);// 1
    
    NSLog(@"\n");
}


@end
