//
//  SGH0413URLCacheViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/13.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGH0413URLCacheViewController.h"
#import "SGHCellModel.h"

@interface SGH0413URLCacheViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *sectionTitle;

@end

@implementation SGH0413URLCacheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray=@[].mutableCopy;
    self.sectionTitle=@[].mutableCopy;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.tableView=({
        UITableView *tableView=[UITableView new];
        [self.view addSubview:tableView];
        tableView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView;
    });
    
    
    //section 1
    
    NSArray *tempTitleArray=@[
        @"1.默认的diskCapacity 和 memoryCapacity",
    ];
    NSArray *tempSelectorArray=@[
        @"defaultSet",
    ];
    [self p_addSectionDataWithClassNameArray:tempSelectorArray titleArray:tempTitleArray title:@"基础"];
    [self.tableView reloadData];
}
- (void)defaultSet {
    NSLog(@"default_diskCapacity:%lu", (unsigned long)[NSURLCache sharedURLCache].diskCapacity);
    NSLog(@"default_memoryCapacity:%lu", (unsigned long)[NSURLCache sharedURLCache].memoryCapacity);
}

-(void)p_addSectionDataWithClassNameArray:(NSArray *)classNameArray titleArray:(NSArray *)titleArray title:(NSString *)title {
    
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SGHCellModel *cellMoel= self.dataArray[indexPath.section][indexPath.row];
    NSString *selectorStr = cellMoel.className;
    
    SEL sel = NSSelectorFromString(selectorStr);
    if (sel) {
        [self performSelector:sel];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
