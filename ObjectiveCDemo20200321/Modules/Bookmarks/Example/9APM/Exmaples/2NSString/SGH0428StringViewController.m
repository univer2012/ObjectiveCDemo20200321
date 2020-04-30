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
@property (strong, nonatomic)   NSString *strongStr;
@property (assign, nonatomic)   NSString *assignStr;


@property (retain, nonatomic) NSMutableString *retainMStr;
@property (copy, nonatomic)   NSMutableString *copyMStr;
@property (strong, nonatomic)   NSMutableString *strongMStr;
@property (assign, nonatomic)   NSMutableString *assignMStr;

@end

@implementation SGH0428StringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = SHBaseTableTypeMethod;
    //MARK: section 1
    
    NSArray *tempTitleArray = @[
        @"1.验证：属性是retain修饰的，就是浅拷贝，引用计数加1。\n 属性是copy修饰的，就是深拷贝，引用计数等于1（因为从堆里新分配一个内存块）。",
        @"2. 当一个不可变字符串（NSString）赋值给一个字符串属性 （无论这个字符串是NSString还是NSMutableString），就不存在安全性问题，都是深拷贝。 \n 此时无论retain还是copy都无所谓。",
        @"3.用NSMutableString，赋值strong修饰的NSString，赋值strong修饰的NSMutableString",
        @"4.用NSMutableString，赋值assign修饰的NSString，赋值assign修饰的NSMutableString",
    ];
    NSArray *tempClassNameArray = @[
        @"demo1",
        @"demo2",
        @"demo3",
        @"demo4",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@""];
    
    [self.tableView reloadData];
}

//MARK: 4.用NSMutableString，赋值assign修饰的NSString，赋值assign修饰的NSMutableString
/*
 结论：用NSMutableString的mStr，赋值assign修饰的NSString, 和assign修饰的NSMutableString：
    不是浅拷贝也不是深拷贝。只是简单地把指针指向mStr的内存地址。
    所以引用计数一直是1，且随着mStr的改变而改变。
 */
- (void)demo4 {
    NSMutableString *mStr = [NSMutableString string];
    
    [mStr setString:@"我没变-------"];
    NSLog(@"mStr:%p",mStr);
    
    self.assignStr   = mStr;                                                //浅拷贝，引用计数加1
    NSLog(@"%p,---:%ld", self.assignStr, [self.assignStr retainCount]);     //2

    self.assignMStr   = mStr;                                               //浅拷贝，引用计数加1
    NSLog(@"%p,---:%ld", self.assignMStr, [self.assignMStr retainCount]);   //3
    
    NSLog(@"assignStr:%@",  self.assignStr);
    NSLog(@"assignMStr:%@",    self.assignMStr);
    
    [mStr setString:@"我变了--------"];
    
    NSLog(@"assignStr:%@",  self.assignStr);        //浅拷贝
    NSLog(@"%ld",[self.assignStr retainCount]);     //3
    
    NSLog(@"assignMStr:%@",  self.assignMStr);      //浅拷贝
    NSLog(@"%ld",[self.assignMStr retainCount]);    //3
    
}

//MARK: 3.用NSMutableString，赋值strong修饰的NSString，赋值strong修饰的NSMutableString
/*
 结论：用NSMutableString的mStr，赋值strong修饰的NSString, 和strong修饰的NSMutableString：
   都是浅拷贝，引用计数加1，都会随着mStr的改变而改变。
 */
- (void)demo3 {
    NSMutableString *mStr = [NSMutableString string];
    
    [mStr setString:@"我没变-------"];
    NSLog(@"mStr:%p",mStr);
    
    self.strongStr   = mStr;                                                //浅拷贝，引用计数加1
    NSLog(@"%p,---:%ld", self.strongStr, [self.strongStr retainCount]);     //2

    self.strongMStr   = mStr;                                               //浅拷贝，引用计数加1
    NSLog(@"%p,---:%ld", self.strongMStr, [self.strongMStr retainCount]);   //3
    
    NSLog(@"strongStr:%@",  self.strongStr);
    NSLog(@"strongMStr:%@",    self.strongMStr);
    
    [mStr setString:@"我变了--------"];
    
    NSLog(@"strongStr:%@",  self.strongStr);        //浅拷贝
    NSLog(@"%ld",[self.strongStr retainCount]);     //3
    
    NSLog(@"strongMStr:%@",  self.strongMStr);      //浅拷贝
    NSLog(@"%ld",[self.strongMStr retainCount]);    //3
    
}

//MARK: 2.当一个不可变字符串（NSString）赋值给一个字符串属性（无论这个字符串是NSString还是NSMutableString），就不存在安全性问题，都是深拷贝。 此时无论retain还是copy都无所谓。
/*
 结论：用NSString的str，赋值retain修饰的NSString, 和retain修饰的NSMutableString：
 都是深拷贝，引用计数等于1，不会随着mStr的改变而改变。
 
 结论：用NSString的str，赋值copy修饰的NSString, 和copy修饰的NSMutableString：
 都是深拷贝，引用计数等于1，不会随着mStr的改变而改变。
 */
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
/*
 结论：用NSMutableString的mStr，赋值retain修饰的NSString, 和retain修饰的NSMutableString：
 都是浅拷贝，引用计数加1，都会随着mStr的改变而改变。
 
 结论：用NSMutableString的mStr，赋值copy修饰的NSString, 和copy修饰的NSMutableString：
 都是深拷贝，引用计数等于1，不会随着mStr的改变而改变。
 */
- (void)demo1 {
    NSMutableString *mStr = [NSMutableString string];
    
    [mStr setString:@"我没变-------"];
    NSLog(@"mStr:%p",mStr);
    
    /// ================ NSString
    self.retainStr   = mStr;  // 浅拷贝，引用计数加1，
    NSLog(@"%p,---:%ld", self.retainStr, [self.retainStr retainCount]);// 2
    
    self.copyStr     = mStr;    // 深拷贝，
    NSLog(@"%p,---:%ld", self.copyStr, [self.copyStr retainCount]);// 1
    
    /// ================ NSMutableString
    self.retainMStr = mStr;   // 浅拷贝，引用计数加1，
    NSLog(@"%p,---:%ld", self.retainMStr, [self.retainMStr retainCount]);// 3
    
    self.copyMStr   = mStr;   // 深拷贝
    NSLog(@"%p,---:%ld", self.copyMStr, [self.copyMStr retainCount]);// 1
    
    
    
    NSLog(@"retainStr:%@",  self.retainStr);
    NSLog(@"copyStr:%@",    self.copyStr);
    NSLog(@"retainMStr:%@", self.retainMStr);
    NSLog(@"copyMStr:%@",   self.copyMStr);
    
    NSLog(@"\n");
    
    [mStr setString:@"我变了--------"];
    
    /// ================ NSString
    NSLog(@"retainStr:%@",  self.retainStr);// 浅拷贝
    NSLog(@"%ld",[self.retainStr retainCount]);// 3
    
    NSLog(@"copyStr:%@",    self.copyStr);// 深拷贝
    NSLog(@"%ld",[self.copyStr retainCount]);// 1
    
    /// ================ NSMutableString
    NSLog(@"retainMStr:%@", self.retainMStr);// 浅拷贝
    NSLog(@"%ld",[self.retainMStr retainCount]);// 3
    
    NSLog(@"copyMStr:%@",   self.copyMStr);// 深拷贝
    NSLog(@"%ld",[self.copyMStr retainCount]);// 1
    
    NSLog(@"\n");
}


@end
