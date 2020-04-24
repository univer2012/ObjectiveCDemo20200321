//
//  SGHNameListViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/24.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHNameListViewController.h"
#import "ArrayDataSource.h"

static NSString *const kNameCellIdentifier = @"NameCell";

@interface SGHNameListViewController ()

#pragma mark - Model
@property (strong, nonatomic) NSArray *nameList;

#pragma mark - Data source
@property (assign, nonatomic) ArrayDataSource *dataSource;

@end

@implementation SGHNameListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.dataSource = self.dataSource;
}

#pragma mark - Lazy initialization
- (NSArray *)nameList
{
    if (!_nameList) {
        _nameList = @[@"Sam", @"Mike", @"John", @"Paul", @"Jason"];
    }
    return _nameList;
}

- (ArrayDataSource *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[ArrayDataSource alloc] initWithItems:self.nameList
                                              cellIdentifier:kNameCellIdentifier
                                              tableViewStyle:UITableViewCellStyleDefault
                                          configureCellBlock:^(UITableViewCell *cell, NSString *item, NSIndexPath *indexPath) {
            cell.textLabel.text = item;
        }];
    }
    return _dataSource;
}


@end
