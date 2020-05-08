//
//  SGHMRCBlockViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/28.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHMRCBlockViewController.h"


typedef long (^BlockSum)(int, int);

@interface SGHMRCBlockViewController ()

@property (nonatomic,retain)BlockSum retainBlock;
@property (nonatomic,assign)BlockSum assignBlock;

@property (nonatomic,copy)  BlockSum copyBlock;
@property (nonatomic,strong)BlockSum strongBlock;

@end

@implementation SGHMRCBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    BlockSum block1 =^long(int a,int b){
//        return a + b;
//    };
//    self.block1 = block1;
    
    
    
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
        @"2.全局区、栈区、堆区",
    ];
    NSArray *tempClassNameArray = @[
        @"demo1",
        @"demo1_2",
        @"demo1_3",
        @"demo1_4",
        @"demo2",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"MRC模式下的 block"];
    
    [self.tableView reloadData];
    
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
