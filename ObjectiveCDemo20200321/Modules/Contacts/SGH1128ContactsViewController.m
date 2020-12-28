//
//  SGH1128ContactsViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2016/11/28.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH1128ContactsViewController.h"

@interface SGH1128ContactsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *controllersArray;
@property(nonatomic,strong)NSMutableArray *titlesArray;

@end

@implementation SGH1128ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.



#if 1
    //8、自定义后退按钮的文字和颜色(这代码写在push前的控制器里才有效)
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    //9、改变 “返回”图标和文字 的颜色(只有执行了 “返回”图标和文字才会变色，所以是放在执行push前)
    //所有 UIBarButtonSystemItem 的都会变设置的颜色
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];//[UIColor whiteColor];
#endif
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor redColor],
       NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];
    self.title = [NSString stringWithFormat:@"第%lu页",(unsigned long)self.navigationController.viewControllers.count];
#if 0
    //自定义返回按钮
    UIImage *backButtonImage =[[UIImage imageNamed:@"system_setting"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    /*
     UIBarMetricsDefault,
     UIBarMetricsCompact,
     UIBarMetricsDefaultPrompt = 101, // Applicable only in bars with the prompt property, such as UINavigationBar and UISearchBar
     UIBarMetricsCompactPrompt,
     */
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //10、将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
#endif
    
    //    self.title=@"ObjectiveC-Demo";
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
        @"SGH160507ViewController",
        @"SGH160519ViewController",
        @"SGHCoreTextListViewController",
        @"SGHPerformanceAnalysisAndOptimizationVC",
        @"SGHRunloopExperimentViewController",
        @"SGHRuntimeExperimentViewController",
        @"SGHAboutKVOAndKVCViewController",
        @"SGHPrincipleOfInquiryViewController",
        @"SGHTechnologyExplorationViewController",
        @"SGH_CGAndQuartzCoreAnimationViewController",
        @"SGHNaviteJSInteractionViewController",
    ] mutableCopy];
    
    self.titlesArray=[@[
        @"16-05-07替代UDID/PageVC/webView/断点续传后台下载",
        @"2CoreLocation、MKMapView",
        @"4CoreText Demos",
        @"5性能优化",
        @"6runloop",
        @"7runtime",
        @"8KVO KVC",
        @"9原理探究",
        @"10技术探究与应用",
        @"11CoreGraphics_QuartzCore_动画",
        @"12原生与H5的交互WKScriptMessageHandler",
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
