//
//  SGHRealizePrincipleAndAnalysisVC.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/15.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHRealizePrincipleAndAnalysisVC.h"

#import "SGHisaMan.h"

#import <libkern/OSAtomic.h>

@interface SGHRealizePrincipleAndAnalysisVC ()

@property (nonatomic, copy) NSString *name;

@property (atomic, copy) NSString *nameOne; //解决方案1

@property (nonatomic, copy) NSString *nameTwo; //解决方案2

@end

@implementation SGHRealizePrincipleAndAnalysisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = SHBaseTableTypeMethod;
    
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"1.Tagged Pointer技术",
        @"2_1. Tagged Pointer技术 的 一道面试题 - 第1段代码(会崩溃)",
        @"2_2. Tagged Pointer技术 的 一道面试题 - 第2段代码",
        @"2_3. Tagged Pointer技术 的 一道面试题 - 第1段代码的解决方案1：\n 把`nonatomic`改为`atomic`。",
        @"2_4. Tagged Pointer技术 的 一道面试题 - 第1段代码的解决方案2：\n 在异步复制时进行加锁和解锁即可。",
    ];
    NSArray *tempClassNameArray = @[
        @"dec1demo1",
        @"dec1demo2_1",
        @"dec1demo2_2",
        @"dec1demo2_3",
        @"dec1demo2_4",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"内存管理"];
    
    
    //MARK: section 2
    NSArray *tempTitleArray2 = @[
        @"1.打印一下一个`SGHisaMan`类对象所占据的内存大小",
        @"2.使用结构体位域优化代码",
        @"3.使用共用体优化代码",
    ];
    NSArray *tempClassNameArray2 = @[
        @"sec2demo1",
        @"sec2demo2",
        @"sec2demo3",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray2 titleArray:tempTitleArray2 title:@"isa本质"];
    
    
    [self.tableView reloadData];
}

//MARK: 3.使用共用体优化代码
- (void)sec2demo3 {
    NSLog(@"SGHisaMan3_size: %zd", class_getInstanceSize([SGHisaMan3 class]) );
    
    SGHisaMan3 *man = [[SGHisaMan3 alloc] init];
    man.tall = NO;
    man.rich = NO;
    man.handsome = YES;
    NSLog(@"tall:%d,\n rich:%d, \n handsome:%d",man.isTall, man.isRich, man.isHandsome);
}

//MARK: 2.使用结构体位域优化代码
- (void)sec2demo2 {
    NSLog(@"SGHisaMan2_size: %zd", class_getInstanceSize([SGHisaMan2 class]) );
    
    SGHisaMan2 *man = [[SGHisaMan2 alloc] init];
    man.tall = NO;
    man.rich = NO;
    man.handsome = YES;
    NSLog(@"tall:%d,\n rich:%d, \n handsome:%d",man.isTall, man.isRich, man.isHandsome);
}

//MARK: - section 2
//MARK: 1.打印一下一个`SGHisaMan`类对象所占据的内存大小
- (void)sec2demo1 {
    NSLog(@"SGHisaMan_size: %zd", class_getInstanceSize([SGHisaMan class]) );
    
    SGHisaMan *man = [[SGHisaMan alloc] init];
    man.tall = NO;
    man.rich = NO;
    man.handsome = YES;
    NSLog(@"tall:%d,\n rich:%d, \n handsome:%d",man.isTall, man.isRich, man.isHandsome);
}


//MARK: 2_4. Tagged Pointer技术 的 一道面试题 - 第1段代码的解决方案2：\n 在异步复制时进行加锁和解锁即可。
- (void)dec1demo2_4 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue, ^{
            self.nameTwo = [NSString stringWithFormat:@"asdasdefafdfa"];
        });
    }
    NSLog(@"end");
}

- (void)setNameTwo:(NSString *)nameTwo {
    if (_nameTwo != nameTwo) { //在异步复制时进行加锁和解锁
        OSSpinLock spinLock = OS_SPINLOCK_INIT;
        OSSpinLockLock(&spinLock);
        _nameTwo = [nameTwo copy];
        OSSpinLockUnlock(&spinLock);
    }
}

 //MARK: 2_3. Tagged Pointer技术 的 一道面试题 - 第1段代码的解决方案1：\n 把`nonatomic`改为`atomic`。
- (void)dec1demo2_3 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue, ^{
            self.nameOne = [NSString stringWithFormat:@"asdasdefafdfa"];
        });
    }
    NSLog(@"end");
}

 //MARK: 2_2. Tagged Pointer技术 的 一道面试题 - 第2段代码
- (void)dec1demo2_2 {
    //第2段代码
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue, ^{
            self.name = [NSString stringWithFormat:@"abc"];
        });
    }
    NSLog(@"end");
}

 //MARK: 2_1. Tagged Pointer技术 的 一道面试题 - 第1段代码(会崩溃)
- (void)dec1demo2_1 {
    //第1段代码
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue, ^{
            self.name = [NSString stringWithFormat:@"asdasdefafdfa"];
        });
    }
    NSLog(@"end");
    
    
}

//MARK: - section 1
//MARK: 1.Tagged Pointer技术
/*
 为了节省内存和提高执行效率，苹果提出了`Tagged Pointer`的概念，用于优化`NSNumber`、`NSDate`、`NSString`等小对象的存储。
 
 1. 在没有使用`Tagged Pointer`之前，内存中包括一个占8字节的指针变量 `number`，和一个占16字节的`NSNumber`对象，指针变量 `number` 指向 `NSNumber` 对象的地址。这样需要耗费24个字节内存空间。
 2. 使用`Tagged Pointer`之后，`NSNumber`指针里面存储的数据变成了：`Tag + Data`，也就是将数据直接存储在了指针中。
 */
- (void)dec1demo1 {
    NSNumber *number1 = @1;
    NSNumber *number2 = @2;
    NSNumber *number3 = @3;
    NSNumber *number4 = @4;
    NSNumber *number5 = @5;
    NSNumber *number6 = @6;
    NSNumber *number7 = @(0xFFFFFFFFFFFFFFFF);
    
    NSLog(@"number1:%p", number1);
    NSLog(@"number2:%p", number2);
    NSLog(@"number3:%p", number3);
    NSLog(@"number4:%p", number4);
    NSLog(@"number5:%p", number5);
    NSLog(@"number6:%p", number6);
    NSLog(@"number7:%p", number7);
    /*output:
     number1:0xec9027b7fa830f82
     number2:0xec9027b7fa830fb2
     number3:0xec9027b7fa830fa2
     number4:0xec9027b7fa830fd2
     number5:0xec9027b7fa830fc2
     number6:0xec9027b7fa830ff2
     number7:0x600003e716e0
     
     注：注意从右往左第2个值。
     */
}


@end
