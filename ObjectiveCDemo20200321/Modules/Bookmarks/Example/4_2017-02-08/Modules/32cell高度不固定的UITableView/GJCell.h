//
//  GJCell.h
//  cell高度不固定的UITableView
//
//  Created by huangaengoln on 16/1/16.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJCell : UITableViewCell

@property (nonatomic, weak) UIImageView *customImageView;   //头像
@property (nonatomic, weak) UILabel *title;     //昵称
@property (nonatomic, weak) UILabel *subtitle;  //内容

@end
