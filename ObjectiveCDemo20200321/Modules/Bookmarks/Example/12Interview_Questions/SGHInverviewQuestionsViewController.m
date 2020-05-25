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

#import "Girl.h"
#import "Girl+Ex.h"

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
        @"2.用category 来暴露主类的私有方法",
    ];
    NSArray *tempClassNameArray3 = @[
        @"sec3demo1",
        @"sec3demo2",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray3 titleArray:tempTitleArray3 title:@"Category"];
    
    //MARK: section 4
    NSArray *tempTitleArray4 = @[
        @"1.暴力破解法 - 两层for循环，获取差值中最大值",
        @"2.贪心算法 - 先获取数组中最小值，然后做差值的出最大差价",
    ];
    NSArray *tempClassNameArray4 = @[
        @"sec4demo1",
        @"sec4demo2",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray4 titleArray:tempTitleArray4 title:@"iOS算法提升之四(买卖股票的最佳时机)"];
    
    [self.tableView reloadData];
}

//MARK: 2.贪心算法 - 先获取数组中最小值，然后做差值的出最大差价
- (void)sec4demo2 {
    NSArray *arr = @[@7, @1, @5, @3, @6, @4];
    function2(arr);
}
/**
动态规划
 1.获取最少购入价格
 2.判断最大售出价格
 **/
void function2(NSArray *dataArr) {
    int min = [dataArr[0] intValue];    //最小值
    int maxPrice = 0;   //最大赚取
    int startIndex = 0;
    int saleIndex = 0;
    
    
 
    for (int i = 1 ; i < dataArr.count; i++) {
        int indexi = [dataArr[i] intValue];
        //首先获取最少购入价格
        if (min > indexi) {
            min = indexi;
            //获取最大售出价格
        } else if (indexi - min > maxPrice) {
            /**
             切记这个开始位置，不是min的位置，
             如果数组NSArray *arr = @[@7,@2,@5,@13,@1,@5,@3,@6,@4,@8];
             是上面的话，min最终结果是1， startIndex应该是2的位置
             **/
            startIndex = [dataArr containsObject:@(min)];
            saleIndex = i;
            maxPrice = indexi - min;
        }
    }
    
    NSLog(@"第%d天买入，第%d天卖出，最大赚取max ----%d ",startIndex+1,saleIndex +1,maxPrice);
}


//MARK: - section 4
//MARK: 1.暴力破解法 - 两层for循环，获取差值中最大值
- (void)sec4demo1 {
    NSArray *arr = @[@7, @1, @5, @3, @6, @4];
    function1(arr);
}
/**
 暴力破解法，二次for循环获取差值最大值
 **/
void function1(NSArray *dataArr) {
    int max = 0;
    int startIndex = 0;
    int saleIndex = 0;
 
    for (int i = 0 ; i < dataArr.count; i++) {
        for (int j = i+1; j<dataArr.count; j++) {
            //获取第j天股票价格
            int indexj = [dataArr[j] intValue];
            //获取第i天股票价格
            int indexi = [dataArr[i] intValue];
            int priceSpread  = indexj - indexi;
            if (priceSpread > max) {
                startIndex = i;
                saleIndex = j;
            }
            max = max> priceSpread ? max : priceSpread;
            
        }
        
    }
    NSLog(@"第%d天买入，第%d天卖出，最大赚取max ----%d ",startIndex+1,saleIndex +1,max);
}


//MARK:2.用category 来暴露主类的私有方法 和私有属性
- (void)sec3demo2 {
    Girl *person = [Girl new];
    [person runText];
    person.littleName = @"小明";
    /*output:
     分类暴露私有方法成功!!!
     私有属性暴露成功!
     */
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
    /* 结构如下：
                                  v4
                                 /
     self.view -- v1 -- v2 -- v3
                                 \
                                  v5 -- v6 -- v7
     */
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
