//
//  SGH_CGAndQuartzCoreAnimationViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/3/24.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGH_CGAndQuartzCoreAnimationViewController.h"



@interface SGH_CGAndQuartzCoreAnimationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *controllersArray;
@property(nonatomic,strong)NSMutableArray *titlesArray;

@end

@implementation SGH_CGAndQuartzCoreAnimationViewController

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
        @"SGH0728CALayerViewController",
        @"SGH0729CAAnimationViewController",
        @"SGH0729TransitionGroupViewController",
        @"SGH0729WheelViewController",
        @"SGH0324CATransitionViewController",
        @"SGHBanner3DTransitionViewController",
        @"SHAnimationMasonryLoginVC",
    ] mutableCopy];
    
    self.titlesArray=[@[
        @"1、CALayer的介绍",
        @"2、CAAnimation动画",
        @"3、转场动画和动画组",
        @"4、实例动画按钮布局",
        @"5、CATransition转场效果",
        @"6、广告3DTransition",
        @"7、Autolayout_masonry登录动画",
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
    NSString *vcString = _controllersArray[indexPath.row];
    if ([vcString  isEqualToString: @"SGH0324CATransitionViewController"]) {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:vcString];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        Class cls=NSClassFromString(vcString);
        if (cls) {
            UIViewController *vc = [cls new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

@end
