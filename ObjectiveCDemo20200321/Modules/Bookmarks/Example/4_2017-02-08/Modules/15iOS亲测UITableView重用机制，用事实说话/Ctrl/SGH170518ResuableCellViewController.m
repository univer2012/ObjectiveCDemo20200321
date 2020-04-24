//
//  SGH170518ResuableCellViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/18.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH170518ResuableCellViewController.h"

@interface SGH170518ResuableCellViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation SGH170518ResuableCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"在5s模拟器下运行";
    // Do any additional setup after loading the view.
    self.tableView=({
        UITableView *tableView=[UITableView new];
        [self.view addSubview:tableView];
        tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView;
    });
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static int count = 0;
    static NSString *cellIndentifier = @"Cell";
    if (indexPath.row > 10) {
        cellIndentifier = @"Cell2";
    }
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        count ++;
    }
    NSLog(@"init textLabel:%@",cell.textLabel.text);
    if (indexPath.row < 10) {
        cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    }
    else if (indexPath.row == 11) {
        cell.textLabel.text = @"this is 20";
    }
    NSLog(@"count:%d,textLabel:%@",count,cell.textLabel.text);
    
    return cell;
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
