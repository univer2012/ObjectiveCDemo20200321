//
//  SGH160519ViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/5/19.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH160519ViewController.h"

@interface SGH160519ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *controllersArray;
@property(nonatomic,strong)NSMutableArray *titlesArray;

@end

@implementation SGH160519ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.tableView=({
        UITableView *tableView=[UITableView new];
        [self.view addSubview:tableView];
        tableView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView;
    });
    _controllersArray= [@[@"SGHUIKitDynamicsViewController",
                          @"SGH0911CoreLocationViewController",
                          @"SGH0618LocationViewController",
                          @"SGH0618DistanceViewController",
                          @"SGH0618GeocodeViewController",
                          @"SGH0618AntiEncodeViewController",
                          @"SGH0618MapViewViewController",
                          @"SGH0618AnnotationViewController",
                          @"SGH0618DynaAnnotationViewController",
                          @"SGH0618MapNavigationViewController",
                          @"SGH0629AlertViewController",
                          @"SGH0727CollectionViewController",
                          //@"SGH0728CALayerViewController",
                          @"SGH171130RetainCycleTestViewController"
                          ] mutableCopy];
    
    self.titlesArray=[@[@"1WWDC 2013 Session笔记 - UIKit Dynamics入门",
                        @"2、通过Core Location实现定位功能",
                        @"3获取当前位置(要真机)",
                        @"4根据经纬度计算两地的距离(要真机)",
                        @"5地理编码",
                        @"6反地理编码",
                        @"7MKMapView的使用",
                        @"8向mapView上添加大头针",
                        @"9动态添加大头针到地图",
                        @"10导航",
                        @"11UIAlertController",
                        @"12CollectionView设置frame时受导航栏影响的问题",
                        //@"13CALayer的介绍",
                        @"14使用FBRetainCycleDetector测试"
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
        [self.navigationController pushViewController:[cls new] animated:YES];
    }
}



















@end
