//
//  SHBaseTableViewController.h
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/17.
//  Copyright © 2020 远平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGHCellModel.h"

typedef NS_ENUM(NSUInteger, SHBaseTableType) {
    SHBaseTableTypeMethod,
    SHBaseTableTypeNewVC,
};

NS_ASSUME_NONNULL_BEGIN

@interface SHBaseTableViewController : UIViewController

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *sectionTitle;

@property(nonatomic,strong)NSArray *inStoryboardVCArray;

@property(nonatomic,assign) SHBaseTableType type;

- (void)remakeTableViewConstraintsWith:(UIView *)view;

- (void)addSectionDataWithClassNameArray:(NSArray *)classNameArray titleArray:(NSArray *)titleArray title:(NSString *)title;

- (void)pushToNewVCWith:(NSString *)className title:(NSString *)title inBookmarkStoryboard:(BOOL)inBookmarkStoryboard selText:(NSString *)selText;

@end

NS_ASSUME_NONNULL_END
