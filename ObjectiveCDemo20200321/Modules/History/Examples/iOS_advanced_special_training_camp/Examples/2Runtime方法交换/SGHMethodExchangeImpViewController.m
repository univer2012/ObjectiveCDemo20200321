//
//  SGHMethodExchangeImpViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/13.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHMethodExchangeImpViewController.h"

@interface SGHMethodExchangeImpViewController ()<UITableViewDataSource,UITableViewDelegate>

/** tableView  */
@property (nonatomic, strong)UITableView *tableView;

/** Description  */
@property (nonatomic, strong)NSArray *tableViewDataArray;

@end

@implementation SGHMethodExchangeImpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableViewDataArray = @[
//        @"Hank",
//        @"Cooci",
//        @"Lina",
//        @"小雁子",
//        @"LGKODY"
//    ];
        
    self.tableViewDataArray = @[]; //打开这个，就会显示效果了
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cutsom"];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView reloadData];
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.rowHeight = UITableViewAutomaticDimension;
            tableView.estimatedRowHeight = 55;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            tableView.backgroundColor = UIColor.yellowColor;
            tableView;
        });
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableViewDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cutsom"];
    cell.textLabel.text = self.tableViewDataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
