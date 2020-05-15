//
//  ViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/7/28.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH1128BookmarksViewController.h"

#import "SGH160728ViewController.h"
#import "SGH161223ComponentsDemoViewController.h"
#import "SGH170208ViewController.h"
#import "SGH190129YYKitViewController.h"
#import "SHReactiveCocoaViewController.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"

#import "ObjectiveCDemo20200321-Swift.h"

@interface SGH1128BookmarksViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *controllersArray;
@property(nonatomic,strong)NSMutableArray *titlesArray;

@end

@implementation SGH1128BookmarksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        self.title=@"杂乱Demo";
//    self.fd_prefersNavigationBarHidden
    
    self.tableView=({
        UITableView *tableView=[UITableView new];
        [self.view addSubview:tableView];
        tableView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView;
    });
    _controllersArray = [@[
        @"SGH160728ViewController",
        @"SGH161223ComponentsDemoViewController",
        @"SGH170208ViewController",
        @"SGH190129YYKitViewController",
        @"SHReactiveCocoaViewController",
        @"SGHSocketListViewController",
        @"SGHMultithreadProgramViewController",
        @"SGH0427AMPViewController",
        @"SGH0428BlockViewController",
        @"SGHDataStructAlgorithmsViewController",
        @"SGHInverviewQuestionsViewController",
        @"SGHCProgramLanguageViewController",
        NSStringFromClass([SGHSwiftProgramLanguageViewController class]),
        @"SGHRealizePrincipleAndAnalysisVC",
    ] mutableCopy];
    
    
    self.titlesArray=[@[
        @"16-07-28",
        @"3、第三方组件",
        @"4、2017-02-08",
        @"5、YYKit",
        @"6、ReactiveCocoa",
        @"7、Socket",
        @"8、多线程编程",
        @"9、性能、内存优化",
        @"10、Block",
        @"11、数据结构与算法",
        @"12、面试题",
        @"13、C语言",
        @"14、Swift语言",
        @"15、底层原理探索和分析",
    ] mutableCopy];
    
    
    
}
- (void)threadRun {
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //显示bar
    //[self.navigationController setNavigationBarHidden:NO animated:animated];
    
    //UINavigationBarDelegate
    //self.navigationController.navigationBar.delegate
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
#if 0
    UIViewController *viewController = _controllersArray[indexPath.row];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
#elif 1
    Class cls = NSClassFromString(_controllersArray[indexPath.row]);
    if (cls) {
        UIViewController *vc = [cls new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
#endif
}

#pragma mark - 重写系统方法设置该控制器的 statusBar
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden {
    return YES;
}
-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
