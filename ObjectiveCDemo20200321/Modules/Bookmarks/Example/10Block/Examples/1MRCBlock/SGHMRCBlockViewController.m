//
//  SGHMRCBlockViewController.m
//  OCDemo
//
//  Created by Mac on 2020/4/28.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHMRCBlockViewController.h"

#import "SGHBlockPerson.h"

typedef long (^BlockSum)(int, int);

@interface SGHMRCBlockViewController ()

@property (nonatomic,retain)BlockSum retainBlock;
@property (nonatomic,assign)BlockSum assignBlock;

@property (nonatomic,copy)  BlockSum copyBlock;
@property (nonatomic,strong)BlockSum strongBlock;

@end

@implementation SGHMRCBlockViewController

typedef void(^XBTBlock)(void);
XBTBlock btBlock2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    int base = 100;
    BlockSum block2 = ^long(int a, int b) {
        return base + a + b;
    };
    NSLog(@"1_block2:%@",block2);
    self.retainBlock = block2;
    self.assignBlock = block2;
    self.copyBlock = block2;
    self.strongBlock = block2;
    
    NSLog(@"retainBlock: %@",   self.retainBlock);
    NSLog(@"assignBlock: %@",   self.assignBlock);
    NSLog(@"copyBlock: %@",     self.copyBlock);
    NSLog(@"strongBlock: %@",   self.strongBlock);
    
    
    self.type = SHBaseTableTypeMethod;
    //MARK: section 1
    
    NSArray *tempTitleArray = @[
        @"1.使用retain修饰的属性block - __NSStackBlock__会崩溃",
        @"1_2.使用assign修饰的属性block - __NSStackBlock__会崩溃",
        @"1_3.使用copy修饰的属性block - __NSMallocBlock__不会崩溃",
        @"1_4.使用strong修饰的属性block - __NSMallocBlock__不会崩溃",
    ];
    NSArray *tempClassNameArray = @[
        @"demo1",
        @"demo1_2",
        @"demo1_3",
        @"demo1_4",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"局部变量block分别赋值给retain、assign、copy、strong修饰的属性block的情况"];
    
    //MARK: section 2
    NSArray *tempTitleArray2 = @[
        @"2.全局区、栈区、堆区",
        @"3.GlobalBlock、StackBlock、MallocBlock执行copy后的情况",
        @"5_0.原题：MRC模式下，下列代码的p会执行 `dealloc` 吗？",
        @"5.MRC模式下，下列代码的p会执行 `dealloc` 吗？",
        @"5_2.探究：MRC模式下，StackBlock 不会持有对象p",
    ];
    NSArray *tempClassNameArray2 = @[
        @"demo2",
        @"demo3",
        @"demo5_0",
        @"demo5",
        @"demo5_2",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray2 titleArray:tempTitleArray2 title:@"copy操作、其他"];
    
    [self.tableView reloadData];
    
}

//MARK: 5_2.探究：MRC模式下，StackBlock 不会持有对象p
- (void)demo5_2 {
    typedef void(^XBTBlock)(void);
    XBTBlock btBlock2;
    
    
    SGHBlockPerson *p = [[SGHBlockPerson alloc] init];
    p.age = 10;
    
    btBlock2 = ^{
        NSLog(@"======= %ld",(long)p.age);
    };
    NSLog(@"%@",btBlock2);
    
    
    //测试：StackBlock 是否会持有p
    NSLog(@"retainCount:%ld", [p retainCount]);
    btBlock2 = nil;
    NSLog(@"p:%@, retainCount:%ld", p, [p retainCount]);
    /*output:
     retainCount:1
     p:<SGHBlockPerson: 0x6000039d8ca0>, retainCount:1
     
     结论：说明 StackBlock 不会持有p
     */
    
}

//MARK: 5.MRC模式下，下列代码的p会执行 `dealloc` 吗？
- (void)demo5 {
    typedef void(^XBTBlock)(void);
    XBTBlock btBlock2;
    SGHBlockPerson *p = [[SGHBlockPerson alloc] init];
    p.age = 10;
    
    btBlock2 = ^{
        NSLog(@"======= %ld",(long)p.age);
    };
    btBlock2();
    NSLog(@"%@, p_retainCount: %ld", btBlock2, [p retainCount]);
    
    //需要手动释放p，才会执行SGHBlockPerson的 `dealloc` 方法。
    [p release];
    //NSLog(@"p_retainCount: %ld", [p retainCount]); //手动 `release` p后，再执行`[p retainCount]`会崩溃
}

//MARK: 5_0.原题：MRC模式下，下列代码的p会执行 `dealloc` 吗？
- (void)demo5_0 {
    
    
    SGHBlockPerson *p = [[SGHBlockPerson alloc] init];
    p.age = 10;
    
    btBlock2 = ^{
        NSLog(@"======= %ld",(long)p.age);
    };
    
    NSLog(@"%@",btBlock2);
    
    [p release]; //手动释放p
}

//MARK: 3.GlobalBlock、StackBlock、MallocBlock执行copy后的情况， 以及跟NSString的copy进行比较
/*结论：
 1. `__NSGlobalBlock__` 调用copy操作后，复制效果是：copy后的对象，指针指向原GlobalBlock，引用计数不变。
 2. `__NSStackBlock__`  调用copy操作后，复制效果是：从栈复制到堆；副本存储位置是「堆」。
 3. `__NSMallocBlock__` 调用copy操作后，复制效果是：copy后的对象，指针指向原MallocBlock，引用计数不变。效果跟NSString的copy操作效果一样。
 
 */
- (void)demo3 {
    NSLog(@"__NSGlobalBlock__:");
    BlockSum block1 = ^long(int a,int b){
        return a + b;
    };
    
    BlockSum copy1 = [block1 copy];
    
    NSLog(@"copy前: %@, retainCount:%ld",block1, [block1 retainCount]);
    NSLog(@"copy后: %@, retainCount:%ld",copy1, [copy1 retainCount]);

    
    
    NSLog(@"__NSStackBlock__:");
    int base = 100;
    BlockSum block2 = ^long(int a, int b) {
        return base + a + b;
    };
    BlockSum copy2 = [block2 copy];
    
    NSLog(@"copy前: %@, retainCount:%ld",block2, [block2 retainCount]);
    NSLog(@"copy后: %@, retainCount:%ld",copy2, [copy2 retainCount]);
    
    
    NSLog(@"__NSMallocBlock__:");
    
    BlockSum block3 = copy2;
    BlockSum copy3 = [block3 copy];
    
    NSLog(@"copy前: %@, retainCount:%ld",block3, [block3 retainCount]);
    NSLog(@"copy后: %@, retainCount:%ld",copy3, [copy3 retainCount]);
    
    NSLog(@"NSString:");
    NSString *oriStr = @"origin";
    NSString *copyStr = [oriStr copy];
    NSLog(@"copy前: %p, retainCount:%ld",oriStr, [oriStr retainCount]);
    NSLog(@"copy后: %p, retainCount:%ld",copyStr, [copyStr retainCount]);
    
    /*output:
     
     OCDemo09:14:37.322668+0800 OCDemo[11051:543765] __NSGlobalBlock__:
     OCDemo09:14:37.323002+0800 OCDemo[11051:543765] copy前: <__NSGlobalBlock__: 0x10bb04f80>, retainCount:1
     OCDemo09:14:37.323223+0800 OCDemo[11051:543765] copy后: <__NSGlobalBlock__: 0x10bb04f80>, retainCount:1
     OCDemo09:14:37.323361+0800 OCDemo[11051:543765] __NSStackBlock__:
     OCDemo09:14:37.323539+0800 OCDemo[11051:543765] copy前: <__NSStackBlock__: 0x7ffee43227a8>, retainCount:1
     OCDemo09:14:37.323745+0800 OCDemo[11051:543765] copy后: <__NSMallocBlock__: 0x6000034ff960>, retainCount:1
     OCDemo09:14:37.323973+0800 OCDemo[11051:543765] __NSMallocBlock__:
     OCDemo09:14:37.324373+0800 OCDemo[11051:543765] copy前: <__NSMallocBlock__: 0x6000034ff960>, retainCount:1
     OCDemo09:14:37.325197+0800 OCDemo[11051:543765] copy后: <__NSMallocBlock__: 0x6000034ff960>, retainCount:1
     OCDemo09:14:37.325974+0800 OCDemo[11051:543765] NSString:
     OCDemo09:14:37.326597+0800 OCDemo[11051:543765] copy前: 0x10bb10480, retainCount:-1
     OCDemo09:14:37.327140+0800 OCDemo[11051:543765] copy后: 0x10bb10480, retainCount:-1
     */
}

- (void)demo2 {
    //宏定义一个block
    
    BlockSum block1 =^long(int a,int b){
        return a + b;
    };
    NSLog(@"%@",block1);
    // <__NSGlobalBlock__: 0x1000020b0>

    int base = 100;
    BlockSum block2 = ^long(int a, int b) {
        return base + a + b;
    };
    NSLog(@"%@",block2);
    /*arc和非arc所在的内存位置不同:
     mrc:
     <__NSStackBlock__: 0x7fff5698b070>
     arc:
     <__NSMallocBlock__: 0x10051cf60>  */
    BlockSum block3 = [block2 copy];
    NSLog(@"%@", block3);
    // <__NSMallocBlock__: 0x10051cf60>
}

- (void)demo1_4 {
    self.strongBlock(1,3);
}

- (void)demo1_3 {
    self.copyBlock(1,3);
}

- (void)demo1_2 {
    self.assignBlock(1,3);
}

- (void)demo1 {
    self.retainBlock(1,3);
}





@end
