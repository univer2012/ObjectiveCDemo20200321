//
//  SGHARCBlockViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/8.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 来自：1.[ARC 下引用计数的打印](https://blog.csdn.net/yishabeier152/article/details/52326487)
 */
#import "SGHARCBlockViewController.h"

#import <CoreFoundation/CoreFoundation.h>

#import "SGHBlockPerson.h"

@interface SGHARCBlockViewController ()

@end

int kGlobalNumA = 10;
NSMutableString *kGlobalMtableString = @"origin";

@implementation SGHARCBlockViewController


typedef void(^XBTBlock)(void);
XBTBlock btBlock;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeMethod;
    
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"1.在ARC下打印出 NSStackBlock",
        @"2.block访问全局变量时，是否拷贝了全局变量？\n答：没有拷贝全局变量",
        @"3.一直往父类方向打印block的class",
        @"4.MallocBlock执行copy后的情况，以及跟NSString的copy进行比较",
        @"5_0.原题：ARC模式下，下列代码的p会执行 `dealloc` 吗？",
        @"5.ARC模式下，下列代码的p会执行 `dealloc` 吗？",
        @"5_2.探究：ARC模式下，MallocBlock 会持有对象p",
    ];
    NSArray *tempClassNameArray = @[
        @"demo1",
        @"demo2",
        @"demo3",
        @"demo4",
        @"demo5_0",
        @"demo5",
        @"demo5_2",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"ARC模式下的 block"];
    
    [self.tableView reloadData];
}
//MARK: 5_2.探究：ARC模式下，MallocBlock 会持有对象p
- (void)demo5_2 {
    typedef void(^XBTBlock)(void);
    XBTBlock btBlock;
    
    SGHBlockPerson *p = [[SGHBlockPerson alloc] init];
    p.age = 10;
    
    NSLog(@"retainCount:%ld", (long)CFGetRetainCount((__bridge  CFTypeRef)p));  //retainCount:1
    btBlock = ^{
        NSLog(@"======= %ld",(long)p.age);
    };
    
    NSLog(@"%@",btBlock);
    
    //测试：MallocBlock 是否会持有p
    NSLog(@"retainCount:%ld", (long)CFGetRetainCount((__bridge  CFTypeRef)p));
    btBlock = nil;
    NSLog(@"p:%@, retainCount:%ld", p, (long)CFGetRetainCount((__bridge  CFTypeRef)p));
    /*output:
      retainCount:3
      p:<SGHBlockPerson: 0x600002275720>, retainCount:2
      Person - dealloc
     
     结论：说明 MallocBlock 会持有p
     */
}


//MARK: 5.ARC模式下，下列代码的p会执行 `dealloc` 吗？
- (void)demo5 {
    typedef void(^XBTBlock)(void);
    XBTBlock btBlock;
    SGHBlockPerson *p = [[SGHBlockPerson alloc] init];
    p.age = 10;
    
    btBlock = ^{
        NSLog(@"======= %ld",(long)p.age);
    };
    btBlock();
    NSLog(@"%@, p_retainCount: %ld",btBlock, (long)CFGetRetainCount((__bridge  CFTypeRef)p));
}

//MARK: 5_0.原题：ARC模式下，下列代码的p会执行 `dealloc` 吗？
- (void)demo5_0 {
    
    SGHBlockPerson *p = [[SGHBlockPerson alloc] init];
    p.age = 10;
    
    btBlock = ^{
        NSLog(@"======= %ld",(long)p.age);
    };
    
    NSLog(@"%@, p_retainCount: %ld",btBlock, (long)CFGetRetainCount((__bridge  CFTypeRef)p));
}

//MARK: 4.MallocBlock执行copy后的情况，以及跟NSString的copy进行比较
/*结论：
 `__NSMallocBlock__` 调用copy操作后，复制效果是：copy后的对象，指针指向原MallocBlock，引用计数不变。
 效果跟NSString的copy操作效果一样。
 */
- (void)demo4 {
    typedef long (^BlockSum)(int, int);
    
    NSLog(@"__NSMallocBlock__:");
    int base = 100;
    BlockSum block2 = ^long(int a, int b) {
        return base + a + b;
    };
    BlockSum copy2 = [block2 copy];
    
    NSLog(@"copy前: %@, retainCount:%ld",block2, (long)CFGetRetainCount((__bridge  CFTypeRef)block2));
    NSLog(@"copy后: %@, retainCount:%ld",copy2, (long)CFGetRetainCount((__bridge  CFTypeRef)copy2));
    
    
    
    NSLog(@"NSString:");
    NSString *oriStr = @"origin";
    NSString *copyStr = [oriStr copy];
    NSLog(@"copy前: %p, retainCount:%ld",oriStr, (long)CFGetRetainCount((__bridge  CFTypeRef)oriStr));
    NSLog(@"copy后: %p, retainCount:%ld",copyStr, (long)CFGetRetainCount((__bridge  CFTypeRef)copyStr));
    
}

//MARK: 3.一直往父类方向打印block的class
- (void)demo3 {
    void (^block1)(void) = ^{
        NSLog(@"block1");
    };
    NSLog(@"%@",[block1 class]);
    NSLog(@"%@",[[block1 class] superclass]);
    NSLog(@"%@",[[[block1 class] superclass] superclass]);
    NSLog(@"%@",[[[[block1 class] superclass] superclass] superclass]);
    NSLog(@"%@",[[[[[block1 class] superclass] superclass] superclass] superclass]);
}

//MARK: 2.block访问全局变量时，是否拷贝了全局变量？\n答：没有拷贝全局变量
- (void)demo2 {
    void (^blcok)(void) = ^{
        NSLog(@"abcd %@, num: %d",kGlobalMtableString, kGlobalNumA);
    };
    //ARC下打印引用计数
    NSLog(@"%ld", (long)CFGetRetainCount((__bridge  CFTypeRef)kGlobalMtableString) );
    kGlobalNumA = 20;
    kGlobalMtableString = [@"changed" mutableCopy];
    
    blcok();
    /*output:
     abcd changed, num: 20
     */
}

//MARK: 1.在ARC下打印出 NSStackBlock
- (void)demo1 {
    
    int a = 1;
    void (^blcok1)(void) = ^{
        NSLog(@"abcd %d",a);
    };
    NSLog(@"NSMallocBlock: %@",blcok1);
    
    NSLog(@"NSStackBlock: %@",^{
        NSLog(@"%d",a);
    });
}

@end
