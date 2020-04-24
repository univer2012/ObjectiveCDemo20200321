//
//  SGHBlockLeakViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/24.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHBlockLeakViewController.h"

#import "ArrayDataSource.h"

static NSString *const kNameCellIdentifier = @"NameCell";

@interface SGHBlockLeakViewController ()

#pragma mark - Model
@property (strong, nonatomic) NSArray *nameList;

#pragma mark - Data source
@property (strong, nonatomic) ArrayDataSource *dataSource;

@property (strong, nonatomic) void (^block)();

@property (strong, nonatomic) NSString *aCat;

@end

@implementation SGHBlockLeakViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.dataSource = self.dataSource;
    
    //[self testSelfInCocoaBlocks];
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
        _dataSource = [[ArrayDataSource alloc] initWithItems:self.nameList cellIdentifier:kNameCellIdentifier tableViewStyle:UITableViewCellStyleDefault configureCellBlock:^(UITableViewCell *cell, NSString *item, NSIndexPath *indexPath) {
            cell.textLabel.text = item;
            [self configureCell];
            
        }];
    }
    return _dataSource;
}

- (void)configureCell
{
    NSLog(@"Just for test");
}

- (void)dealloc
{
    NSLog(@"release BlockLeakViewController");
}

//MARK: 示例1
- (void)testSelfInCocoaBlocks {
    NSArray *cats = @[@"Smily", @"Garfild", @"Other cat"];
    [cats enumerateObjectsUsingBlock:^(NSString * _Nonnull cat, NSUInteger idx, BOOL * _Nonnull stop) {
        [self doSomethingWithCat:cat];
    }];
}
- (void)doSomethingWithCat:(NSString *)cat {}

//MARK: 示例2
- (void)testSelfInBlock {
    self.block = ^{
        [self doSomethingWithCat:@"Fat Cat"];
    };
}

//MARK: 示例3
- (void)testHiddenSelfInCocoaBlocks {
    NSArray *cats = @[@"Smily", @"Garfild", @"Other cat"];
    [cats enumerateObjectsUsingBlock:^(NSString * _Nonnull cat, NSUInteger idx, BOOL * _Nonnull stop) {
        _aCat = cat;
        *stop = YES;
    }];
}

//MARK: 示例4
- (void)demo4 {
    [[NSNotificationCenter defaultCenter] addObserverForName:@"not" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self doSomethingWithCat:@"Noty cat"];
    }];

}


@end
