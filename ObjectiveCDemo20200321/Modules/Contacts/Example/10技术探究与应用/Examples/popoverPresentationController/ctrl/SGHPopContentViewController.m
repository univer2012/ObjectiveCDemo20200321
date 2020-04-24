//
//  SGHPopContentViewController.m
//  ObjectiveCDemo
//
//  Created by huangaengoln on 16/3/12.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHPopContentViewController.h"

@interface SGHPopContentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
//@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation SGHPopContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor=[UIColor blueColor];
    self.tableView=({
        UITableView *tableView = [UITableView new];
        tableView.frame=self.view.frame;
//        tableView.frame=CGRectMake(10, 0, CGRectGetWidth(self.view.frame)-10, CGRectGetHeight(self.view.frame));
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView.scrollEnabled = NO;
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [self.view addSubview:tableView];
        tableView;
    });
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *modelArray = self.paramDictionary[@"dataArray"];
    return modelArray ? modelArray.count : 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.paramDictionary[@"heightForRow"] floatValue];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier=@"CellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    NSArray *modelArray = self.paramDictionary[@"dataArray"];
    if (modelArray) {
        NSDictionary *modelDict =modelArray[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:modelDict[@"image"]];
        cell.textLabel.text = modelDict[@"title"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedBlock(indexPath.row);
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
