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
        @"1.查看`self.array`的运行时类型是什么",
    ];
    NSArray *tempClassNameArray2 = @[
        @"sec2demo1",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray2 titleArray:tempTitleArray2 title:@"这个写法会出什么问题： `@property (copy) NSMutableArray *array;`"];
    
    [self.tableView reloadData];
}
//MARK: 这个写法会出什么问题： `@property (copy) NSMutableArray *array;`
//MARK: 1.查看`self.array`的运行时类型是什么
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
