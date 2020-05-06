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

#import "UIViewController+Description.h"

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
    
    NSString *result = @"结论：\n"\
    "1. NSString要用copy修饰，这样赋值者不管是NSString还是NSMutableString，引用计数一直是1，值不会被改变。\n"\
    "2. NSMutableString要用retain或者strong，这样，\n"\
    "用NSMutableString的mStr， 赋值retain或strong修饰的NSMutableString：是浅拷贝，内存地址和mStr一样，引用计数加1，值会随着mStr的改变而改变。\n"\
    "用NSString的str，         赋值retain或strong修饰的NSMutableString：内存地址是新的，引用计数加1，值不会随着str的改变而改变。。";
    
    UILabel *tip = [self showDescWith:result];
    
    [self remakeTableViewConstraintsWith:tip];
    
    self.type = SHBaseTableTypeMethod;
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"1.验证：属性是retain修饰的，就是浅拷贝，引用计数加1。\n 属性是copy修饰的，就是深拷贝，引用计数等于1（因为从堆里新分配一个内存块）。",
        @"3.用NSMutableString，赋值strong修饰的NSString，赋值strong修饰的NSMutableString",
        @"4.用NSMutableString，赋值assign修饰的NSString，赋值assign修饰的NSMutableString",
    ];
    NSArray *tempClassNameArray = @[
        @"demo1",
        @"demo3",
        @"demo4",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"用NSMutableString赋值"];
    
    //MARK: section 2
    NSArray *tempTitleArray2 = @[
        @"1.当一个不可变字符串（NSString）赋值给一个字符串属性（无论这个字符串是NSString还是NSMutableString）， 就不存在安全性问题，都是深拷贝。 \n 此时无论retain还是copy都无所谓。",
        @"2.用NSString，赋值strong修饰的NSString，赋值strong修饰的NSMutableString",
        @"3.用NSString，赋值assign修饰的NSString，赋值assign修饰的NSMutableString",
    ];
    NSArray *tempClassNameArray2 = @[
        @"sec2demo1",
        @"sec2demo2",
        @"sec2demo3",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray2 titleArray:tempTitleArray2 title:@"用NSString赋值"];
    
    [self.tableView reloadData];
}
//MARK: 3.用NSString，赋值assign修饰的NSString，赋值assign修饰的NSMutableString
/*
 结论：用NSString的str，赋值assign修饰的NSString：
    内存地址和str一样，引用计数一直是1，值不会变。
 
 
    用NSString的str，赋值assign修饰的NSMutableString：
    内存地址是新的，引用计数等于1，值不会变。
    
    
 */
- (void)sec2demo3 {
    NSString *str = @"我来了";//[[NSString alloc] initWithString:@"我来了"];//两种方式都一样。都在常量区
    
    NSLog(@"str内存地址：%p,引用计数：%ld, 内容：%@", str, [str retainCount], str);
    
    self.assignStr   = str;                                                //浅拷贝，引用计数加1
    NSLog(@"assignStr内存地址：%p,引用计数：%ld, 内容：%@", self.assignStr, [self.assignStr retainCount], self.assignStr);

    self.assignMStr   = [str mutableCopy];                                               //浅拷贝，引用计数加1
    NSLog(@"assignMStr内存地址：%p,引用计数：%ld, 内容：%@", self.assignMStr, [self.assignMStr retainCount], self.assignMStr);
    
    NSLog(@"\n");
    
    str = @"我走了";//[[NSStringalloc] initWithString:@"我走了"];//两种方式都一样
    
    NSLog(@"assignStr内存地址：%p,引用计数：%ld, 内容：%@", self.assignStr, [self.assignStr retainCount], self.assignStr);
    
    NSLog(@"assignMStr内存地址：%p,引用计数：%ld, 内容：%@", self.assignMStr, [self.assignMStr retainCount], self.assignMStr);
    
}


//MARK: 2.用NSString，赋值strong修饰的NSString，赋值strong修饰的NSMutableString
/*
 结论：用NSString的str，赋值strong修饰的NSString：
   指针指向str的地址，引用计数一直是1，值不会变。
 
 用NSString的str，赋值strong修饰的NSMutableString：
 内存地址是新的，引用计数加1，值不会随着str的改变而改变。
 
 对NSMutableString，retain和strong的结论是一样的。
 */
- (void)sec2demo2 {
    NSString *str = @"我来了";//[[NSString alloc] initWithString:@"我来了"];//两种方式都一样。都在常量区
    
    self.strongStr = str;

    self.strongMStr   = [str mutableCopy];

    
    NSLog(@"内存地址：str=%p, strongStr=%p, strongMStr=%p",str, self.strongStr, self.strongMStr);
    NSLog(@"引用计数：str=%ld, strongStr=%ld, strongMStr=%ld",[str retainCount], [self.strongStr retainCount], [self.strongMStr retainCount]);
    NSLog(@"内容：str=%@, strongStr=%@, strongMStr=%@",str,self.strongStr, self.strongMStr);
    
    NSLog(@"\n");
    
    str = @"我走了";//[[NSStringalloc] initWithString:@"我走了"];//两种方式都一样
    
    
    NSLog(@"内存地址：str=%p, strongStr=%p, strongMStr=%p",str, self.strongStr, self.strongMStr);
    NSLog(@"引用计数：str=%ld, strongStr=%ld, strongMStr=%ld",[str retainCount], [self.strongStr retainCount], [self.strongMStr retainCount]);
    NSLog(@"内容：str=%@, strongStr=%@, strongMStr=%@",str,self.strongStr, self.strongMStr);
}



//MARK: 1.当一个不可变字符串（NSString）赋值给一个字符串属性（无论这个字符串是NSString还是NSMutableString）， 就不存在安全性问题，都是深拷贝。 \n 此时无论retain还是copy都无所谓。
/*
 结论：用NSString的str，赋值retain修饰的NSString：
 指针指向str的地址，引用计数一直是1，值不会变。
 
 用NSString的str，赋值retain修饰的NSMutableString：
 内存地址是新的，引用计数加1，值不会随着str的改变而改变。
 
 结论：用NSString的str，赋值copy修饰的NSString：
 指针指向str的地址，引用计数一直是1，值不会变。
 
 用NSString的str，赋值copy修饰的NSMutableString：
 内存地址是新的，引用计数等于1，值不会随着str的改变而改变。
 */
- (void)sec2demo1 {
    NSString *str = @"我来了";//[[NSString alloc] initWithString:@"我来了"];//两种方式都一样。都在常量区
    
    self.retainStr  = str;
    self.copyStr    = str;
    self.retainMStr = [str mutableCopy];
    self.copyMStr   = [str mutableCopy];
    
    NSLog(@"内存地址：str=%p, retainStr=%p, retainMStr=%p, copyStr=%p, copyMStr=%p",str, self.retainStr, self.retainMStr, self.copyStr, self.copyMStr);
    NSLog(@"引用计数：str=%ld, retainStr=%ld, retainMStr=%ld, copyStr=%ld, copyMStr=%ld",[str retainCount], [self.retainStr retainCount], [self.retainMStr retainCount], [self.copyStr retainCount], [self.copyMStr retainCount]);
    NSLog(@"内容：str=%@, retainStr=%@, retainMStr=%@, copyStr=%@, copyMStr=%@",str, self.retainStr, self.retainMStr, self.copyStr, self.copyMStr);
    
    NSLog(@"\n");
    
    str = @"我走了";//[[NSStringalloc] initWithString:@"我走了"];//两种方式都一样
    
    NSLog(@"内存地址：str=%p, retainStr=%p, retainMStr=%p, copyStr=%p, copyMStr=%p",str, self.retainStr, self.retainMStr, self.copyStr, self.copyMStr);
    NSLog(@"引用计数：str=%ld, retainStr=%ld, retainMStr=%ld, copyStr=%ld, copyMStr=%ld",[str retainCount], [self.retainStr retainCount], [self.retainMStr retainCount], [self.copyStr retainCount], [self.copyMStr retainCount]);
    NSLog(@"内容：str=%@, retainStr=%@, retainMStr=%@, copyStr=%@, copyMStr=%@",str, self.retainStr, self.retainMStr, self.copyStr, self.copyMStr);

}


//MARK: 4.用NSMutableString，赋值assign修饰的NSString，赋值assign修饰的NSMutableString
/*
 结论：用NSMutableString的mStr，赋值assign修饰的NSString, 和assign修饰的NSMutableString：
    不是浅拷贝也不是深拷贝。
    内存地址和mStr一样，引用计数一直是1，值都会随着mStr的改变而改变。
 */
- (void)demo4 {
    NSMutableString *mStr = [NSMutableString string];
    
    [mStr setString:@"我没变-------"];
    NSLog(@"mStr内存地址：%p,引用计数：%ld, 内容：%@", mStr, [mStr retainCount], mStr);
    
    self.assignStr   = mStr;                                                //浅拷贝，引用计数加1
    NSLog(@"assignStr内存地址：%p,引用计数：%ld, 内容：%@", self.assignStr, [self.assignStr retainCount], self.assignStr);

    self.assignMStr   = mStr;                                               //浅拷贝，引用计数加1
    NSLog(@"assignMStr内存地址：%p,引用计数：%ld, 内容：%@", self.assignMStr, [self.assignMStr retainCount], self.assignMStr);
    
    NSLog(@"\n");
    
    [mStr setString:@"我变了--------"];
    
    NSLog(@"assignStr内存地址：%p,引用计数：%ld, 内容：%@", self.assignStr, [self.assignStr retainCount], self.assignStr);
    
    NSLog(@"assignMStr内存地址：%p,引用计数：%ld, 内容：%@", self.assignMStr, [self.assignMStr retainCount], self.assignMStr);
    
}

//MARK: 3.用NSMutableString，赋值strong修饰的NSString，赋值strong修饰的NSMutableString
/*
 结论：用NSMutableString的mStr，赋值strong修饰的NSString, 和strong修饰的NSMutableString：
    都是浅拷贝，内存地址和mStr一样，引用计数加1，值都会随着mStr的改变而改变。
    
    对NSMutableString，retain和strong的结论是一样的。
 */
- (void)demo3 {
    NSMutableString *mStr = [NSMutableString string];
    
    [mStr setString:@"我没变-------"];
    NSLog(@"mStr内存地址：%p,引用计数：%ld, 内容：%@", mStr, [mStr retainCount], mStr);
    
    self.strongStr   = mStr;                                                //浅拷贝，引用计数加1
    NSLog(@"strongStr内存地址：%p,引用计数：%ld, 内容：%@", self.strongStr, [self.strongStr retainCount], self.strongStr);

    self.strongMStr   = mStr;                                               //浅拷贝，引用计数加1
    NSLog(@"strongMStr内存地址：%p,引用计数：%ld, 内容：%@", self.strongMStr, [self.strongMStr retainCount], self.strongMStr);

    NSLog(@"\n");
    [mStr setString:@"我变了--------"];
    
    NSLog(@"strongStr内存地址：%p,引用计数：%ld, 内容：%@", self.strongStr, [self.strongStr retainCount], self.strongStr);
    
    NSLog(@"strongMStr内存地址：%p,引用计数：%ld, 内容：%@", self.strongMStr, [self.strongMStr retainCount], self.strongMStr);
    
}

//MARK: 1.验证：属性是retain修饰的，就是浅拷贝，引用计数加1。\n 属性是copy修饰的，就是深拷贝，引用计数等于1（因为从堆里新分配一个内存块）。
/*
 结论：用NSMutableString的mStr，赋值retain修饰的NSString, 和retain修饰的NSMutableString：
 都是浅拷贝，内存地址和mStr一样，引用计数加1，值都会随着mStr的改变而改变。
 
 结论：用NSMutableString的mStr，赋值copy修饰的NSString, 和copy修饰的NSMutableString：
 都是深拷贝，内存地址和mStr不一样，引用计数等于1，不会随着mStr的改变而改变。
 */
- (void)demo1 {
    NSMutableString *mStr = [NSMutableString string];
    
    [mStr setString:@"我没变-------"];
    NSLog(@"mStr内存地址：%p,引用计数：%ld, 内容：%@", mStr, [mStr retainCount], mStr);
    
    /// ================ NSString
    self.retainStr   = mStr;  // 浅拷贝，引用计数加1，
    NSLog(@"retainStr内存地址：%p,引用计数：%ld, 内容：%@", self.retainStr, [self.retainStr retainCount], self.retainStr);
    
    self.copyStr     = mStr;    // 深拷贝，
    NSLog(@"copyStr内存地址：%p,引用计数：%ld, 内容：%@", self.copyStr, [self.copyStr retainCount], self.copyStr);
    
    /// ================ NSMutableString
    self.retainMStr = mStr;   // 浅拷贝，引用计数加1，
    NSLog(@"retainMStr内存地址：%p,引用计数：%ld, 内容：%@", self.retainMStr, [self.retainMStr retainCount], self.retainMStr);
    
    self.copyMStr   = mStr;   // 深拷贝
    NSLog(@"copyMStr内存地址：%p,引用计数：%ld, 内容：%@", self.copyMStr, [self.copyMStr retainCount], self.copyMStr);
    
    NSLog(@"\n");
    
    [mStr setString:@"我变了--------"];
    
    /// ================ NSString
    NSLog(@"retainStr内存地址：%p,引用计数：%ld, 内容：%@", self.retainStr, [self.retainStr retainCount], self.retainStr);
    
    NSLog(@"copyStr内存地址：%p,引用计数：%ld, 内容：%@", self.copyStr, [self.copyStr retainCount], self.copyStr);
    
    /// ================ NSMutableString
    NSLog(@"retainMStr内存地址：%p,引用计数：%ld, 内容：%@", self.retainMStr, [self.retainMStr retainCount], self.retainMStr);
    
    NSLog(@"copyMStr内存地址：%p,引用计数：%ld, 内容：%@", self.copyMStr, [self.copyMStr retainCount], self.copyMStr);
    
    NSLog(@"\n");
}


@end
