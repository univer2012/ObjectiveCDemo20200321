//
//  SGH0413URLCacheViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/13.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGH0413URLCacheViewController.h"

@interface SGH0413URLCacheViewController ()

@end

@implementation SGH0413URLCacheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeMethod;
    //section 1
    NSArray *tempTitleArray=@[
        @"1.默认的diskCapacity 和 memoryCapacity",
    ];
    NSArray *tempSelectorArray=@[
        @"defaultSet",
    ];
    [self addSectionDataWithClassNameArray:tempSelectorArray titleArray:tempTitleArray title:@"基础"];
    
    [self.tableView reloadData];
}

//MARK: 1.默认的diskCapacity 和 memoryCapacity
- (void)defaultSet {
    NSLog(@"default_diskCapacity:%lu", (unsigned long)[NSURLCache sharedURLCache].diskCapacity);
    NSLog(@"default_memoryCapacity:%lu", (unsigned long)[NSURLCache sharedURLCache].memoryCapacity);
}


@end
