//
//  SHUnfixedHeightTableViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/15.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHUnfixedHeightTableViewController.h"
#import "GJCell.h"
#import "Masonry.h"

static NSString * const GJCellIndentifier = @"GJCell";

@interface SHUnfixedHeightTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *datas;       //数据
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation SHUnfixedHeightTableViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupView];
}
- (void)setupData {
    NSDictionary *data1 = @{@"icon": @"myIcon",
                            @"name": @"GJBlog",
                            @"content": @"今天天气真好啊"};
    NSDictionary *data2 = @{@"icon": @"myIcon",
                            @"name": @"GJBlogGJBlogGJBlog",
                            @"content": @"今天天气真好啊今天天气真好啊今天天气真好啊今天天气真好啊"};
    NSDictionary *data3 = @{@"icon": @"myIcon",
                            @"name": @"GJBlogGJBlogGJBlogGJBlogGJBlogGJBlogGJBlogGJBlogGJBlogGJBlog",
                            @"content": @"今天天气真好啊今天天气真好啊今天天气真好啊今天天气真好啊今天天气真好啊今天天气真好啊今天天气真好啊今天天气真好啊今天天气真好啊今天天气真好啊今天天气真好啊今天天气真好啊今天天气真好啊今天天气真好啊"};
    self.datas = @[data1, data2, data3];
}

- (void)setupView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [tableView registerClass:[GJCell class] forCellReuseIdentifier:GJCellIndentifier];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GJCell *cell = [tableView dequeueReusableCellWithIdentifier:GJCellIndentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
- (void)configureCell:(GJCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row % 3;
    NSDictionary *data = self.datas[row];
    UIImage *image = [UIImage imageNamed:data[@"icon"]];
    [cell.customImageView setImage:image];
    [cell.title setText:data[@"name"]];
    [cell.subtitle setText:data[@"content"]];
}
//============================================
#pragma mark - UITableViewDelegate
/**
 * - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 Description:
 Asks the delegate for the height to use for a row in a specified location.
 A nonnegative floating-point value that specifies the height (in points) that row should be.
 Declared in:       UITableView.h
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForCellAtIndexPath:indexPath];
}
- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath {
    static GJCell *cell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [self.tableView dequeueReusableCellWithIdentifier:GJCellIndentifier];
    });
    [self configureCell:cell atIndexPath:indexPath];
    return [self calculateHeightForCell:cell];
}
- (CGFloat)calculateHeightForCell:(GJCell *)cell {
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"size : %@",NSStringFromCGSize(size));
    return size.height + 1.0f;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112.0f;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
