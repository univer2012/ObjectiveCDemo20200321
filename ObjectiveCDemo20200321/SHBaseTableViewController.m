//
//  SHBaseTableViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/17.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SHBaseTableViewController.h"

@interface SHBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation SHBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[].mutableCopy;
    self.sectionTitle = @[].mutableCopy;
    
    self.type = SHBaseTableTypeNewVC;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.tableView=({
        UITableView *tableView=[UITableView new];
        [self.view addSubview:tableView];
        tableView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        tableView.delegate = self;
        tableView.dataSource=self;
        tableView;
    });
}

- (void)addSectionDataWithClassNameArray:(NSArray *)classNameArray titleArray:(NSArray *)titleArray title:(NSString *)title {
    @autoreleasepool {
        NSMutableArray *firstArray=@[].mutableCopy;
        
        [classNameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SGHCellModel *cellModel = [SGHCellModel new];
            cellModel.className=obj;
            cellModel.title=titleArray[idx];
            [firstArray addObject:cellModel];
        }];
        
        [self p_addSectionTitle:title dataArray:firstArray];
        
        
    }
}

-(void)p_addSectionTitle:(NSString *)sectionTitle dataArray:(NSMutableArray *)dataArray {
    [self.dataArray addObject:dataArray];
    [self.sectionTitle addObject:sectionTitle];
}


#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionTitle[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSMutableArray *)self.dataArray[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YY"];
    }
    SGHCellModel *cellMoel= self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.text = cellMoel.title;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SGHCellModel *cellMoel= self.dataArray[indexPath.section][indexPath.row];
    NSString *className = cellMoel.className;
    
    if (self.type == SHBaseTableTypeNewVC) {
        if ([self.inStoryboardVCArray containsObject:className]) {
            UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:className];
            vc.title = cellMoel.title;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            Class cls=NSClassFromString(className);
            if (cls) {
                UIViewController *vc = [cls new];
                vc.title = cellMoel.title;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    } else {
        
        SEL sel = NSSelectorFromString(className);
        [self performSelector:sel];
    }
    
    
    
}

@end
