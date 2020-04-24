//
//  SGHTableViewStyleGroupedViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/4/7.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHTableViewStyleGroupedViewController.h"
#import "Masonry.h"

#import "TKAccountModel.h"
#import "AccountTableHeaderView.h"

@interface SGHTableViewStyleGroupedViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation SGHTableViewStyleGroupedViewController {
    CGFloat _sectionFooterHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [[NSMutableArray alloc] init];
    _sectionFooterHeight = 80.0;
    
    NSMutableArray *sectionOneArray = ({
        NSMutableArray *array = [NSMutableArray array];
        NSArray *imageArray =@[@"account_my_stock",@"account_busniess",@"account_my_collection",@"account_share_recommend",@"account_about_collent"];
        NSArray *titleArray = @[@"我的股票",@"业务办理",@"我的收藏",@"分享推荐",@"关于聚金"];
        for (NSInteger i = 0; i<titleArray.count; i++) {
            TKAccountModel *model = [TKAccountModel new];
            model.title =titleArray[i];
            model.imageName = imageArray[i];
            [array addObject:model];
        }
        array;
    });
    NSMutableArray *sectionTwoArray = ({
        NSMutableArray *array = [NSMutableArray array];
        NSArray *imageArray =@[@"account_setting"];
        NSArray *titleArray = @[@"设置"];
        for (NSInteger i = 0; i<titleArray.count; i++) {
            TKAccountModel *model = [TKAccountModel new];
            model.title =titleArray[i];
            model.imageName = imageArray[i];
            [array addObject:model];
        }
        array;
    });
    
    [self.dataArray addObject:sectionOneArray];
    [self.dataArray addObject:sectionTwoArray];
    
    self.tableView =({
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 50;
        [self.view addSubview:tableView];
        tableView;
    });
    //section 之间的默认上下间隔 是 35,设置heightForFooterInSection之后，就是17.5
    // row 默认高度 是 44
    
    self.tableView.tableHeaderView = ({
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 120)];
        headerView.backgroundColor=[UIColor clearColor];
        
        [headerView addSubview:[[AccountTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), headerView.frame.size.height - 17.5)]];
        
        headerView;
    });
    
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;//YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row % 3 == 1) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleInsert;
}

//对编辑样式 的 响应处理
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete: {
            //indexPath
            //操作UI  数据源  也要做相应操作
            NSMutableArray *arr = self.dataArray[indexPath.section];
            if(arr.count != 1) {//一行一行删除
                [arr removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
            } else {
                //如果section中的元素只有一个 此时把整个section删除
                [self.dataArray removeObject:arr];
                NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
                [indexSet addIndex:indexPath.section];
                [tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationRight];
            }
            
        }
            break;
        case UITableViewCellEditingStyleInsert:{
            if(indexPath.section != 1){
                NSMutableArray *arr = self.dataArray[indexPath.section];
                [arr insertObject:@"zhangsanfeng" atIndex:indexPath.row];
                [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
            }
        }
            break;
        case UITableViewCellEditingStyleNone:
            
            break;
            
        default:
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    TKAccountModel *model = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.text =model.title;
    UIImage *image = [UIImage imageNamed:model.imageName];
    cell.imageView.image = image;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;   //箭头样式
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == self.dataArray.count - 1) {
        return [self buildViewForFooterInSection];
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.dataArray.count - 1) {
        return _sectionFooterHeight;
    }
    return 0.01f;
}

//创建登录按钮的 view
-(UIView *)buildViewForFooterInSection {
    UIView *view = [UIView new];
    view.backgroundColor=[UIColor clearColor];
    UIButton *button = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame)-80, 45);
        button.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, _sectionFooterHeight/2);
        button.layer.cornerRadius = 4.0f;
        button.clipsToBounds = YES;
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"安全退出" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        button;
    });
    return view;
}

-(void)clickLoginButton:(UIButton *)button {
    NSLog(@"%s",__func__);
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
