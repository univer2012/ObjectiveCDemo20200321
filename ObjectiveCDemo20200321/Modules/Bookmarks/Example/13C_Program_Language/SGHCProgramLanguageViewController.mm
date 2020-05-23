//
//  SGHCProgramLanguageViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/8.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHCProgramLanguageViewController.h"

@interface SGHCProgramLanguageViewController ()

@end

@implementation SGHCProgramLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = SHBaseTableTypeMethod;
    
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"1.打印十进制、八进制、十六进制",
        @"2. `char s[]`字符串的sizeof 和 strlen值",
        @"3.计算`int i = 5, j = 6, m = i+++j;`中m的值",
        @"4.double类型强转为int",
        @"5.看程序写结果-第5题",
        @"6.看程序写结果-第6题",
    ];
    NSArray *tempClassNameArray = @[
        @"demo1",
        @"demo2",
        @"demo3",
        @"demo4",
        @"demo5",
        @"demo6",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"C语言程序设计（第2版）第2章 C语言基础-练习题"];
    
    //MARK: section 2
    NSArray *tempTitleArray2 = @[
        @"1.计算数组a的长度：`sizeof(a) / sizeof(a[0]);`，但这个计算的长度不一定准确。",
    ];
    NSArray *tempClassNameArray2 = @[
        @"sec2demo1",

    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray2 titleArray:tempTitleArray2 title:@"计算数组、字典的长度"];
    
    [self.tableView reloadData];
}
//MARK: - section 2
//MARK: 1.计算数组a的长度：`sizeof(a) / sizeof(a[0]);`，但这个计算的长度不一定准确。
//来自：[数组的长度，C语言获取数组长度详解](http://c.biancheng.net/view/186.html)
- (void)sec2demo1 {
    int a[10] = {0};
    
    for (int i = 0; i < 10; i++) {
        printf("%d ",a[i]);
    }
    printf("\n");
    
    int cnt = sizeof(a) / sizeof(a[0]);
    printf("cnt = %d\n", cnt);
    
    //=========== 注意
    int a1[10] = {1, 2, 3, 4, 5};
    for (int i = 0; i < 10; i++) {
        printf("%d ",a1[i]);
    }
    printf("\n");
    
    int cnt1 = sizeof(a1) / sizeof(a1[0]);
    printf("cnt1 = %d\n", cnt1);
    ///我们只初始化了五个元素，但是 sizeof(a)/sizeof(a[0]) 求出的是 10，而不是 5。
    ///换句话说，我们无法通过 sizeof(a)/sizeof(a[0]) 求出数组中有多少个有意义的数据。
    
}

//MARK: 6.看程序写结果-第6题
- (void)demo6 {
    int i, j, x, y;
    i = 5, j = 7;
    x = ++i;
    y = j++;
    printf("%d,%d, %d,%d \n",i,j,x,y);
    /*output:
    6,8, 6,7
    */
}

//MARK: 5.看程序写结果-第5题
- (void)demo5 {
    int a=2,b=4,c=6,x, y;
    y = (x=a+b),(b+c);
    printf("y=%d,x=%d \n",y, x);
    /*output:
    y=6,x=6
    */
}
//MARK: 4.double类型强转为int
- (void)demo4 {
    double f = 3.14159;
    int n;
    n = (int)(f + 10) % 3; //应理解为: (int)(f + 10) 之后再对 3 取余
    printf("%d \n",n);
    /*output:
     1
     */
}
//MARK: 3.计算`int i = 5, j = 6, m = i+++j;`中m的值
- (void)demo3 {
    int i = 5, j = 6, m = i+++j; ///应理解为: m = (i++)+j
    ///因为 自增、自减运算符的优先级高于双目的基本算术运算符，其结合性为右结合。
    printf("%d,%d,%d\n",i,j,m);
    /*output:
    6,6,11
    */
}

//MARK: 2. `char s[]`字符串的sizeof 和 strlen值
- (void)demo2 {
    char s[] = "ab\n\\\'\r\b";
    printf("%d,%d \n",sizeof(s), strlen(s));
    /*output:
    8,7
    */
}

//MARK: 1.打印十进制、八进制、十六进制
- (void)demo1 {
    int a,b,c;
    a = 20;
    b = 027;
    c = 0x3F;
    printf("%d, %d, %d\n",a, b, c); //打印为十进制的数
    printf("%o, %o, %o\n",a, b, c); //打印为八进制的数
    printf("%x, %x, %x\n",a, b, c); //打印为十六进制的数
}



@end
