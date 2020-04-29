//
//  SGHStackMallocViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/29.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHStackMallocViewController.h"


@interface SGHStackMallocViewController ()

@end

@implementation SGHStackMallocViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeMethod;
    //MARK: section 1
    
    NSArray *tempTitleArray = @[
        @"1.内存中的栈区主要用于分配局部变量空间，处于相对较高的地址， 其栈地址是向下增长的； \n而堆区则主要用于分配程序员申请的内存空间，堆地址是向上增长的。",
        @"2.当本次函数调用结束后，遵循“先进后出”（或者称为“后进先出”）的规则， 局部变量先出栈，然后是参数，最后栈顶指针指向最开始保存的地址",
    ];
    NSArray *tempClassNameArray = @[
        @"demo1",
        @"demo2",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@""];
    
    [self.tableView reloadData];
}

//MARK: 2.当本次函数调用结束后，遵循“先进后出”（或者称为“后进先出”）的规则， 局部变量先出栈，然后是参数，最后栈顶指针指向最开始保存的地址
- (void)demo2 {
    int i = 1;
    f(i);
}

void f(int i) {
    printf("%d,%d,%d,%d\n",i, i++, i++, i++);
}

//MARK: 1.内存中的栈区主要用于分配局部变量空间，处于相对较高的地址， 其栈地址是向下增长的； \n而堆区则主要用于分配程序员申请的内存空间，堆地址是向上增长的。
- (void)demo1 {
    testStackAndMallocMemory();
}

void testStackAndMallocMemory(void) {
    /*在栈上分配*/
    int  i1=0;
    int  i2=0;
    int  i3=0;
    int  i4=0;
    printf("栈：向下\n");
    printf("i1=0x%08x\n",&i1);
    printf("i2=0x%08x\n",&i2);
    printf("i3=0x%08x\n",&i3);
    printf("i4=0x%08x\n\n",&i4);
     printf("--------------------\n\n");
    /*在堆上分配*/
    char  *p1 = (char *)malloc(4);
    char  *p2 = (char *)malloc(4);
    char  *p3 = (char *)malloc(4);
    char  *p4 = (char *)malloc(4);
    printf("p1=0x%08x\n",p1);
    printf("p2=0x%08x\n",p2);
    printf("p3=0x%08x\n",p3);
    printf("p4=0x%08x\n",p4);
    printf("堆：向上\n\n");
    /*释放堆内存*/
    free(p1);
    p1=NULL;
    free(p2);
    p2=NULL;
    free(p3);
    p3=NULL;
    free(p4);
    p4=NULL;
    
}

@end
