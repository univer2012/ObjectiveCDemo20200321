//
//  SGHTechnologyExplorationViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/24.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHTechnologyExplorationViewController.h"

@interface SGHTechnologyExplorationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *controllersArray;
@property(nonatomic,strong)NSMutableArray *titlesArray;

@end

@implementation SGHTechnologyExplorationViewController

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
    _controllersArray = [@[
        @"SGHNetworkChangeViewController",
        @"SGHUIFontViewController",
        @"SHGAboutNavigationViewController",
        @"SGHDataPickerViewController",
        @"SGHPopoverPresentationController",
        @"SGHPresentTransitionStyleViewController",
        @"SGHPickerViewViewController",
        @"SGHTableViewStyleGroupedViewController",
        @"SGHSocketClientViewController",
        @"SGHSocketSeverViewController",
        @"SGH0409ThreadViewController",
        @"SGH0413URLCacheViewController",
    ] mutableCopy];
    
    self.titlesArray = [@[
        @"用苹果官网提供的Reachability监听网路变化",
        @"所有苹果字体显示的样式",
        @"有关NavigationController的设置",
        @"UIDatePickerDemo",
        @"UIPopoverPresentationController Demo",
        @"presentViewController转场样式",
        @"UIPickerView的使用",
        @"tableViewStyleGrouped的使用",
        @"socket通信，客户端",
        @"socket通信，服务端",
        @"多线程篇：NSThread",
        @"NSURLCache、缓存机制的理解与实现，数据库离线缓存和多图片缓存；",
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
    
    NSString *className = _controllersArray[indexPath.row];
    
    if ([className  isEqualToString: @"SHRAC1ViewController"] ||
        [className  isEqualToString: @"SGHSocketClientViewController"] ||
        [className  isEqualToString: @"SGHSocketSeverViewController"]) {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:className];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        Class cls=NSClassFromString(className);
        if (cls) {
            UIViewController *vc = [cls new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

@end
