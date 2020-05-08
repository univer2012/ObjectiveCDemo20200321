//
//  SGHInverviewQuestionsViewController.m
//  ObjectiveCDemo
//
//  Created by Mac on 2020/4/30.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHInverviewQuestionsViewController.h"

#import "UIView+NeastPublicView.h"

#import "ObjectiveCDemo20200321-Swift.h"

#import "SGH0503ARCPerson.h"
#import "SGH0503MRCPerson.h"

#import "SGHInverviewQuestionsViewController+Ex1.h"
#import "SGHInverviewQuestionsViewController+Ex2.h"

@interface SGHInverviewQuestionsViewController ()

@property (copy) NSMutableArray *array;

@end

@implementation SGHInverviewQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = SHBaseTableTypeMethod;
    
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"1_1.寻找最近公共view",
        @"1_2.寻找最近公共view-将一个路径中的所有点先放进 NSSet 中",
        @"1_3.寻找最近公共view \n使用类似归并排序的思想，用两个「指针」，分别指向两个路径的根节点，然后从根节点开始，找第一个不同的节点，第一个不同节点的上一个公共节点，就是我们的答案。",
        @"1_4.swift-使用 UIView 的 `isDescendant` 方法来简化我们的代码",
        @"1_5.swift-利用 Optinal 的 flatMap 方法",
    ];
    NSArray *tempClassNameArray = @[
        @"demo1_1",
        @"demo1_2",
        @"demo1_3",
        @"demo1_4",
        @"demo1_5",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"寻找最近公共view"];
    
    //MARK: section 2
    NSArray *tempTitleArray2 = @[
        @"1.这个写法会出什么问题： `@property (copy) NSMutableArray *array;` \n查看`self.array`的运行时类型是什么",
        @"2.重写setter方法",
    ];
    NSArray *tempClassNameArray2 = @[
        @"sec2demo1",
        @"sec2demo2",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray2 titleArray:tempTitleArray2 title:@""];
    
    //MARK: section 3
    NSArray *tempTitleArray3 = @[
        @"1. 两个category有同一个方法，调用该方法时， 由编译器决定执行哪个方法，执行编译器最后编译的方法。",
    ];
    NSArray *tempClassNameArray3 = @[
        @"sec3demo1",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray3 titleArray:tempTitleArray3 title:@"Category"];
    
    [self.tableView reloadData];
}

//MARK: section 3 Category
//MARK: 1. 两个category有同一个方法，调用该方法时， 由编译器决定执行哪个方法，执行编译器最后编译的方法。
///如果在`Build Phases` --> `Compile Sources` 中，SGHInverviewQuestionsViewController+Ex1在上面， SGHInverviewQuestionsViewController+Ex2在下面，则执行Ex2中的run方法。
///反之，则执行Ex1中的 `run`方法。
///
///现在是Ex1在上面，Ex在下面，所以输出结果是：Ex2_run
- (void)sec3demo1 {
    [self run];
}

//MARK: 2.重写setter方法
- (void)sec2demo2 {
    
    NSLog(@"1、ARC-NSMutableString赋值");
    NSMutableString *mutStr = [[NSMutableString alloc] initWithString:@"ARC开始我没变"];
    
    SGH0503ARCPerson * arcPerson = [[SGH0503ARCPerson alloc] init];
    arcPerson.name = mutStr;
    arcPerson.fatherName = mutStr;
    arcPerson.motherName = mutStr;
    NSLog(@"mutStr:%p,\n name:%p,\n fatherName:%p,\n motherName:%p",mutStr, arcPerson.name, arcPerson.fatherName, arcPerson.motherName);
    
    ///========
    NSLog(@"2、ARC-NSString赋值");
    NSString *str = @"ARC开始我没变";
    
    SGH0503ARCPerson * arcPerson2 = [[SGH0503ARCPerson alloc] init];
    arcPerson2.name = str;
    arcPerson2.fatherName = str;
    arcPerson2.motherName = str;
    NSLog(@"str:%p,\n name:%p,\n fatherName:%p,\n motherName:%p",str, arcPerson2.name, arcPerson2.fatherName, arcPerson2.motherName);
    
    ///========
    NSLog(@"3、MRC-NSMutableString赋值");
    
    SGH0503MRCPerson * mrcPerson = [[SGH0503MRCPerson alloc] init];
    mrcPerson.name = mutStr;
    mrcPerson.fatherName = mutStr;
    mrcPerson.motherName = mutStr;
    NSLog(@"mutStr:%p,\n name:%p,\n fatherName:%p,\n motherName:%p",mutStr, mrcPerson.name, mrcPerson.fatherName, mrcPerson.motherName);
    
    ///========
    NSLog(@"4、MRC-NSString赋值");
    
    SGH0503MRCPerson * mrcPerson2 = [[SGH0503MRCPerson alloc] init];
    mrcPerson2.name = str;
    mrcPerson2.fatherName = str;
    mrcPerson2.motherName = str;
    NSLog(@"str:%p,\n name:%p,\n fatherName:%p,\n motherName:%p",str, mrcPerson2.name, mrcPerson2.fatherName, mrcPerson2.motherName);
}


//MARK: 1.这个写法会出什么问题： `@property (copy) NSMutableArray *array;` \n1.查看`self.array`的运行时类型是什么
- (void)sec2demo1 {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@1,@2,nil];
    self.array = array;
    [self.array removeObjectAtIndex:0];
}


//MARK: 1_5.swift-利用 Optinal 的 flatMap 方法
- (void)demo1_5 {
    UIView *v1 = [self addViewWith:self.view tag:1];
    UIView *v2 = [self addViewWith:v1 tag:2];
    UIView *v3 = [self addViewWith:v2 tag:3];
    
    UIView *v4 = [self addViewWith:v3 tag:4];
    
    UIView *v5 = [self addViewWith:v3 tag:5];
    UIView *v6 = [self addViewWith:v5 tag:6];
    UIView *v7 = [self addViewWith:v6 tag:7];
    
    UIView *publicV = [v4 commonSuperview_2Of:v7];
    NSLog(@"publicV:%@",publicV);
}
//MARK: 1_4.swift-使用 UIView 的 `isDescendant` 方法来简化我们的代码
- (void)demo1_4 {
    UIView *v1 = [self addViewWith:self.view tag:1];
    UIView *v2 = [self addViewWith:v1 tag:2];
    UIView *v3 = [self addViewWith:v2 tag:3];
    
    UIView *v4 = [self addViewWith:v3 tag:4];
    
    UIView *v5 = [self addViewWith:v3 tag:5];
    UIView *v6 = [self addViewWith:v5 tag:6];
    UIView *v7 = [self addViewWith:v6 tag:7];
    
    UIView *publicV = [v4 commonSuperview_1Of:v7];
    NSLog(@"publicV:%@",publicV);
}

//MARK: 1_3.寻找最近公共view \n使用类似归并排序的思想，用两个「指针」，分别指向两个路径的根节点，然后从根节点开始，找第一个不同的节点，第一个不同节点的上一个公共节点，就是我们的答案。
- (void)demo1_3 {
    
    UIView *v1 = [self addViewWith:self.view tag:1];
    UIView *v2 = [self addViewWith:v1 tag:2];
    UIView *v3 = [self addViewWith:v2 tag:3];
    
    UIView *v4 = [self addViewWith:v3 tag:4];
    
    UIView *v5 = [self addViewWith:v3 tag:5];
    UIView *v6 = [self addViewWith:v5 tag:6];
    UIView *v7 = [self addViewWith:v6 tag:7];
    
    UIView *publicV = [UIView commonView_3:v4 andView:v7];
    NSLog(@"publicV:%@",publicV);
    
}

//MARK: 1_2.寻找最近公共view-将一个路径中的所有点先放进 NSSet 中
- (void)demo1_2 {
    
    UIView *v1 = [self addViewWith:self.view tag:1];
    UIView *v2 = [self addViewWith:v1 tag:2];
    UIView *v3 = [self addViewWith:v2 tag:3];
    
    UIView *v4 = [self addViewWith:v3 tag:4];
    
    UIView *v5 = [self addViewWith:v3 tag:5];
    UIView *v6 = [self addViewWith:v5 tag:6];
    UIView *v7 = [self addViewWith:v6 tag:7];
    
    UIView *publicV = [UIView commonView_2:v4 andView:v7];
    NSLog(@"publicV:%@",publicV);
    
}

//MARK: 1_1.寻找最近公共view
- (void)demo1_1 {
    
    UIView *v1 = [self addViewWith:self.view tag:1];
    UIView *v2 = [self addViewWith:v1 tag:2];
    UIView *v3 = [self addViewWith:v2 tag:3];
    
    UIView *v4 = [self addViewWith:v3 tag:4];
    
    UIView *v5 = [self addViewWith:v3 tag:5];
    UIView *v6 = [self addViewWith:v5 tag:6];
    UIView *v7 = [self addViewWith:v6 tag:7];
    
    UIView *publicV = [UIView commonView_1:v4 andView:v7];
    NSLog(@"publicV:%@",publicV);
    
}

- (UIView *)addViewWith:(UIView *)superV tag:(NSInteger)tag {
    UIView *view = [UIView new];
    view.tag = tag;
    [superV addSubview:view];
    return view;
}


@end
