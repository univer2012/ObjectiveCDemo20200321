//
//  SGHRuntimeExperimentViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/24.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHRuntimeExperimentViewController.h"

@interface SGHRuntimeExperimentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *controllersArray;
@property(nonatomic,strong)NSMutableArray *titlesArray;

@end

@implementation SGHRuntimeExperimentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.tableView=({
        UITableView *tableView=[UITableView new];
        [self.view addSubview:tableView];
        tableView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView;
    });
    _controllersArray= [@[
        @"SGH0506OCRuntime1ViewController",
        @"SGH0510Runtime2ViewController",
        @"SGH0511Runtime3ViewController",
        @"SGH0512Runtime4ViewController",
        @"SGH0512Runtime5ViewController",
        @"SGH0515Runtime6ViewController",
        @"SGH0515ClassViewController",
        @"SGHRuntimeAttriMethodViewController",
        @"SGHMethodSwizzlingViewController",
        @"SGHModelTransformViewController",
    ] mutableCopy];
    
    self.titlesArray=[@[
        @"6、Objective-C Runtime 运行时之一：类与对象",
        @"8、Objective-C Runtime 运行时之二：成员变量与属性",
        @"9、Objective-C Runtime 运行时之三：方法与消息",
        @"10、Objective-C Runtime 运行时之四：Method Swizzling",
        @"11、Objective-C Runtime 运行时之五：协议与分类",
        @"12、Objective-C Runtime 运行时之六：拾遗",
        @"14、Runtime方法的使用—Class篇",
        @"runtime获取私有属性强制更改私有属性以及获取私有方法",
        @"iOS runtime实战应用：Method Swizzling",
        @"runtime+KVC实现多层字典模型转换",
    ] mutableCopy];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _controllersArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier=@"CellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.textLabel.text=_titlesArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class cls=NSClassFromString(_controllersArray[indexPath.row]);
    if (cls) {
        UIViewController *vc = [cls new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
