//
//  SGH170208ViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/2/8.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH170208ViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

#import "SHSortManager.h"

#import "SGH0208UncaughtExceptionViewController.h"
#import "SGHReusableHeaderFooterTableViewController.h"
#import "SGH0424DreamLBSViewController.h"
#import "SGH0429CryptographyViewController.h"
#import "SGH0515AttibuteStringInitViewController.h"
#import "SGH170518ResuableCellViewController.h"
#import "SGHXMPPFrameworkViewController.h"
#import "SGH0522CrashAnalisisViewController.h"
#import "SGH0524PresentAViewController.h"
#import "SGH0601SystemVersionViewController.h"
#import "SGH0607FetchStringExpressionViewController.h"
#import "SGH170815IdentCodeViewController.h"
#import "SGH_TTAttriLabelViewController.h"
#import "SHImageText0214ViewController.h"
#import "SHKVOExploreViewController.h"
#import "SHMemManageViewController.h"
#import "SHSandboxReadWriteVC.h"
#import "SHQRCodeViewController.h"
#import "SHFetchFutureDateViewController.h"
#import "SHCommonToolVC.h"
#import "SHUpdateJumpAppStoreVC.h"
#import "SHDispatchMethodsViewController.h"
#import "SHUnfixedHeightTableViewController.h"
#import "SHCoreDataDemoVC.h"
#import "SGHVariableParamsViewController.h"

@interface SGH170208ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *controllersArray;
@property(nonatomic,strong)NSMutableArray *titlesArray;

@end

@implementation SGH170208ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SHSortManager *manager = [SHSortManager new];
    NSMutableArray *oriArray = @[@(12),@(15),@(9),@(20),@(6),@(31),@(24)].mutableCopy;
#if 0
    NSLog(@"直接插入排序-排序前：");
    for (NSNumber *temp in oriArray) {
        NSLog(@"%@  ",temp);
    }
    [manager insertSort:oriArray];
    NSLog(@"直接插入排序-排序后：");
    for (NSNumber *temp in oriArray) {
        NSLog(@"%@  ",temp);
    }
#endif
    NSLog(@"起泡排序-排序前：");
    for (NSNumber *temp in oriArray) {
        NSLog(@"%@  ",temp);
    }
    [manager bubbleSort:oriArray];
    NSLog(@"起泡排序-排序后：");
    for (NSNumber *temp in oriArray) {
        NSLog(@"%@  ",temp);
    }
    
    
    self.tableView=({
        UITableView *tableView=[UITableView new];
        [self.view addSubview:tableView];
        tableView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView;
    });
    _controllersArray= [@[[SGH0208UncaughtExceptionViewController new],
                          [SGHReusableHeaderFooterTableViewController new],
                          [SGH0424DreamLBSViewController new],
                          [SGH0429CryptographyViewController new],
                          [SGH0515AttibuteStringInitViewController new],
                          [SGH170518ResuableCellViewController new],
                          [SGHXMPPFrameworkViewController new],
                          [SGH0522CrashAnalisisViewController new],
                          [SGH0524PresentAViewController new],
                          [SGH0601SystemVersionViewController new],
                          [SGH0607FetchStringExpressionViewController new],
                          [SGH170815IdentCodeViewController new],
                          [SGH_TTAttriLabelViewController new],
                          [SHImageText0214ViewController new],
                          [SHKVOExploreViewController new],
                          [SHMemManageViewController new],
                          [SHSandboxReadWriteVC new],
                          [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:SHQRCodeViewController.class]] instantiateViewControllerWithIdentifier:@"SHQRCodeViewController"],
                          [SHFetchFutureDateViewController new],
                          [SHCommonToolVC new],
                          [SHUpdateJumpAppStoreVC new],
                          [SHDispatchMethodsViewController new],
                          SHUnfixedHeightTableViewController.new,
                          SHCoreDataDemoVC.new,
                          SGHVariableParamsViewController.new,
                          ] mutableCopy];
    
    self.titlesArray=[@[@"1、iOS自动捕获程序崩溃日志再发送邮件提示开发者",
                        @"2、dequeueReusableHeaderFooterViewWithIdentifier",
                        @"3、架构师之面向协议编程(OC语言)介绍",
                        @"5、浅谈密码学",
                        @"13、NSAttributedString initWithData 阻塞App问题",
                        @"15、iOS亲测UITableView重用机制，用事实说话",
                        @"16、iOS 的 XMPPFramework 简介",
                        @"17、奔溃统计和分析",
                        @"18、弹出的控制器，半透明显示上一个控制器的页面",
                        @"19、系统判断方法列举",
                        @"20、通过正则表达式获取2个特定字符串中间的字符串",
                        @"21、生成动态验证码及验证",
                        @"22、TTAttributedLabel 的使用",
                        @"23、文字图片上下左右",
                        @"24、KVO原理探究",
                        @"25、内存管理",
                        @"26、沙盒存取",
                        @"27、QRCode扫描读取生成",
                        @"28、获取未来时间点、比较时间前后",
                        @"29、常用工具_打电话_发短信_发邮件",
                        @"30、弹出更新app跳到AppStore界面",
                        @"31、系统提供的dispatch方法",
                        @"32、cell高度不固定的UITableView",
                        @"33、CoreData实例",
                        @"34、定义形参个数可变的方法",
                        ] mutableCopy];
    
    /*用组件隐藏navigationBar，并可以滑动返回
     返回后的控制器的viewWillAppear:方法中，不用设置
     [self.navigationController setNavigationBarHidden:NO animated:YES];
     */
    self.fd_prefersNavigationBarHidden = YES;
    
    
    
    
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

    [self.navigationController pushViewController:_controllersArray[indexPath.row] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
