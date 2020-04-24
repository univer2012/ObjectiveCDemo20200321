//
//  SHBaseTableViewController.h
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/17.
//  Copyright © 2020 远平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGHCellModel.h"

typedef enum : NSUInteger {
    SHBaseTableTypeMethod,
    SHBaseTableTypeNewVC,
} SHBaseTableType;

NS_ASSUME_NONNULL_BEGIN

@interface SHBaseTableViewController : UIViewController

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *sectionTitle;

@property(nonatomic,strong)NSMutableArray *inStoryboardVCArray;

@property(nonatomic,assign) SHBaseTableType type;

- (void)addSectionDataWithClassNameArray:(NSArray *)classNameArray titleArray:(NSArray *)titleArray title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
