//
//  SGH0428CopyViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/28.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 来自：
 1. [浅谈浅拷贝和深拷贝和字符串属性copy修饰的原因](https://www.jianshu.com/p/a865436d84bb)
 */
#import "SGH0428CopyViewController.h"

@interface SGH0428CopyViewController ()

@end

@implementation SGH0428CopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeMethod;
    //MARK: section 1
    
    NSArray *tempTitleArray = @[
        @"1.对NSString进行copy操作进行的是浅拷贝、mutableCopy操作进行的是深拷贝",
        @"1_2.对NSMutableString进行的copy和mutableCopy都是深拷贝。",
        @"2.对NSArray进行copy操作进行的是浅拷贝、mutableCopy操作进行的是深拷贝",
        @"2_2.对NSMutableArray进行的copy和mutableCopy都是深拷贝。",
    ];
    NSArray *tempClassNameArray = @[
        @"demo1",
        @"demo1_2",
        @"demo2",
        @"demo2_2",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@""];
    
    [self.tableView reloadData];
}

//MARK: 2_2.对NSMutableArray进行的copy和mutableCopy都是深拷贝。
- (void)demo2_2 {
    NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithArray:@[@"aaa",@"bbb",@"ccc"]];
    NSArray *copyArray = [mutableArray copy];
    NSArray *mutableCopy = [mutableArray mutableCopy];
    NSLog(@"%p---%p---%p",mutableArray,copyArray,mutableCopy);

    //打印：0x600003746820---0x600003744b70---0x6000037449f0
}
//MARK: 2.对NSArray进行copy操作进行的是浅拷贝、mutableCopy操作进行的是深拷贝
- (void)demo2 {
    NSArray *array = @[@"baseStr",@"baseStr2",@"baseStr3"];
    NSArray *copyArray = [array copy];
    NSArray *mutableCopy = [array mutableCopy];
    NSLog(@"%p---%p---%p",array,copyArray,mutableCopy);
    
    //打印：0x60000368adc0---0x60000368adc0---0x60000368aa30

}
//MARK: 1_2.对NSMutableString进行的copy和mutableCopy都是深拷贝。
- (void)demo1_2 {
    NSMutableString *mutableStr = [NSMutableString stringWithString:@"默认的字符串"];
    NSString *baseStr = [mutableStr copy];
    NSMutableString *mutableBaseStr = [mutableStr mutableCopy];
    NSLog(@"%p---%p---%p",mutableStr,baseStr,mutableBaseStr);

    //打印：0x600003746880---0x600003744030---0x600003745aa0
}

//MARK: 1.对NSString进行copy操作进行的是浅拷贝、mutableCopy操作进行的是深拷贝
- (void)demo1 {
    NSString *baseStr = @"默认的字符串";
    NSString *copyStr = [baseStr copy];
    NSString *mutableCopyStr = [baseStr mutableCopy];
    NSLog(@"%p---%p---%p",baseStr,copyStr,mutableCopyStr);
    
    //打印：0x106f8b1a0---0x106f8b1a0---0x600003691740
}


@end
