//
//  SGHBlockPrincipleViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/25.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHBlockPrincipleViewController.h"

@interface SGHBlockPrincipleViewController ()

@end

@implementation SGHBlockPrincipleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = SHBaseTableTypeMethod;
    
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"1.局部变量截获 是值截获",
        @"1_2.局部对象变量也是一样，截获的是值，而不是指针。 在外部将其置为nil，对block没有影响，而该对象调用方法会影响。",
        @"2.局部静态变量截获，是指针截获。",
        @"3.全局变量，静态全局变量截获：不截获,直接取值。",
    ];
    NSArray *tempClassNameArray = @[
        @"demo1",
        @"demo1_2",
        @"demo2",
        @"demo3",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"block"];
    
    //MARK: section 2
    NSArray *tempTitleArray2 = @[
        @"1.不使用外部变量的block是全局block",
        @"2.使用外部变量并且未进行copy操作的block，是栈block",
        @"2_2.日常开发，常用于这种情况，是栈block",
        @"3.对栈block进行copy操作，就是堆block，而对全局block进行copy， 仍是全局block",
        @"3_2. 第2个例子--- __NSMallocBlock__",
        @"3_3. 第3个例子",
    ];
    NSArray *tempClassNameArray2 = @[
        @"sec2demo1",
        @"sec2demo2",
        @"sec2demo2_2",
        @"sec2demo3",
        @"sec2demo3_2",
        @"sec2demo3_3",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray2 titleArray:tempTitleArray2 title:@"Block的类型"];
    
    [self.tableView reloadData];
}

- (void)sec2demo3_3 {
    [self test2WithBlock:^{
        NSLog(@"%@",self);
    }];
}

- (void)test2WithBlock:(dispatch_block_t)block {
    block();
    
    dispatch_block_t tempBlock = block;
    
    NSLog(@"%@,%@",[block class],[tempBlock class]);
}

- (void)sec2demo3_2 {
    NSInteger num = 10;

    void (^mallocBlock)(void) = ^{
        NSLog(@"stackBlock:%zd",num);
    };

    NSLog(@"%@",[mallocBlock class]);
    //__NSMallocBlock__
}

//MARK: 3.对栈block进行copy操作，就是堆block，而对全局block进行copy， 仍是全局block
- (void)sec2demo3 {
    void (^globalBlock)(void) = ^{
        NSLog(@"globalBlock");
    };
    
    NSLog(@"%@",[globalBlock class]);
    //__NSGlobalBlock__
}

//MARK: 2_2.日常开发，常用于这种情况，是栈block
- (void)sec2demo2_2 {
    [self testWithBlock:^{
        NSLog(@"%@",self);
    }];
}
- (void)testWithBlock:(dispatch_block_t)block {
    block();
    NSLog(@"%@",[block class]);
}

//MARK: 2.使用外部变量并且未进行copy操作的block，是栈block
- (void)sec2demo2 {
    NSInteger num = 10;
    NSLog(@"%@",[^{
        NSLog(@"stackBlock:%zd",num);
    } class]);
}

//MARK: 1.不使用外部变量的block是全局block
- (void)sec2demo1 {
    NSLog(@"%@",[^{
        NSLog(@"globalBlock");
    } class]);
}

//MARK: 3.全局变量，静态全局变量截获：不截获,直接取值。
static NSInteger num3 = 300;

NSInteger num4 = 3000;

- (void)demo3 {
    NSInteger num = 30;
    
    static NSInteger num2 = 3;
    
    __block NSInteger num5 = 30000;
    
    void(^block)(void) = ^{
        
        NSLog(@"%zd",num);//局部变量
        
        NSLog(@"%zd",num2);//静态变量
        
        NSLog(@"%zd",num3);//全局变量
        
        NSLog(@"%zd",num4);//全局静态变量
        
        NSLog(@"%zd",num5);//__block修饰变量
    };
    
    block();
}

//MARK: 2.局部静态变量截获，是指针截获。
- (void)demo2 {
    static  NSInteger num = 3;
    
    NSInteger(^block)(NSInteger) = ^NSInteger(NSInteger n){
        
        return n*num;
    };
    
    num = 1;
    
    NSLog(@"%zd",block(2));
}

//MARK: 1_2.局部对象变量也是一样，截获的是值，而不是指针。 在外部将其置为nil，对block没有影响，而该对象调用方法会影响。
- (void)demo1_2 {
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
    
    void(^block)(void) = ^{
        
        NSLog(@"%@",arr);//局部变量
        [arr addObject:@"4"];
    };
    
    [arr addObject:@"3"];
    
    arr = nil;
    
    block();
}

//MARK: 1.局部变量截获 是值截获
- (void)demo1 {
    NSInteger num = 3;
    
    NSInteger(^block)(NSInteger) = ^NSInteger(NSInteger n){
        
        return n*num;
    };
    
    num = 1;
    
    NSLog(@"%zd",block(2));
    /*output:
     6
     */
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
