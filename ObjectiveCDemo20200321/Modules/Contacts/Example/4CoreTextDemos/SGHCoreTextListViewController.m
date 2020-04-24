//
//  SGHCoreTextListViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/3/22.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 * 来自： 唐巧的文章：
 [](https://github.com/zhongwencheng/tangqiao-coretext)
 */
#import "SGHCoreTextListViewController.h"

@interface SGHCoreTextListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *controllersArray;
@property(nonatomic,strong)NSMutableArray *titlesArray;

@end

@implementation SGHCoreTextListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        @"SGHCoreText1ViewController",
        @"SGHCoreText2ViewController",
        @"SGHCoreText3ViewController",
    ] mutableCopy];
    
    self.titlesArray=[@[
        @"1、不带图片的排版引擎",
        @"2、定制排版文件格式",
        @"3、支持图文混排的排版引擎",
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
    if ([vcString isEqualToString:@"SGHCoreText1ViewController"] ||
        [vcString isEqualToString:@"SGHCoreText2ViewController"] ||
        [vcString isEqualToString:@"SGHCoreText3ViewController"]) {
        
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"CoreText" bundle:nil] instantiateViewControllerWithIdentifier:vcString];
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
