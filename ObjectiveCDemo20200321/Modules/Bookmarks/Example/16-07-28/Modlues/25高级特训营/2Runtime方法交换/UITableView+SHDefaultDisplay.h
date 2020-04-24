//
//  UITableView+SHDefaultDisplay.h
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/2/27.
//  Copyright © 2019 huangaengoln. All rights reserved.
//
/** tableView数据为空时的显示  */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (SHDefaultDisplay)

/** view  */
@property (nonatomic, strong)UIView *lgDefaultView;

- (void)lg_reloadData;

@end

NS_ASSUME_NONNULL_END
