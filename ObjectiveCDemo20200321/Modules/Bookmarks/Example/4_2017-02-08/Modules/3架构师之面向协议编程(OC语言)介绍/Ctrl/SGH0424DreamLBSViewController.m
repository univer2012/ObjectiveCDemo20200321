//
//  SGH0424DreamLBSViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/4/24.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0424DreamLBSViewController.h"

//#import "SGH0424BaiduFactory.h"
//#import "SGH0424GaodeFactory.h"
#import "SGH0424MapEngine.h"

@interface SGH0424DreamLBSViewController ()

@end

@implementation SGH0424DreamLBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
//    [self.view addSubview:mapView];
    //在外部使用的是中介(代理)，而不是具体的某个实现(地图)
    //获取工厂  SGH0424BaiduFactory、SGH0424GaodeFactory
    id<SGH0424MapFactory> mapFactory = [[[SGH0424MapEngine alloc]init] getMapFactory];
    //获取地图
    id<SGH0424MapView> mapView = [mapFactory getMapView:self.view.frame];
    //绑定视图
    [self.view addSubview:[mapView getView]];
    
    //高德地图实现？
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
