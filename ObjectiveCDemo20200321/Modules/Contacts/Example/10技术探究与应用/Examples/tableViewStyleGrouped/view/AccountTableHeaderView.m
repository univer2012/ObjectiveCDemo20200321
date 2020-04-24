//
//  AccountTableHeaderView.m
//  tableViewStyleGroupedDemo
//
//  Created by huangaengoln on 16/3/17.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "AccountTableHeaderView.h"
#import "Masonry.h"

@implementation AccountTableHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_buildUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_buildUI];
    }
    return self;
}
-(void)p_buildUI {
    self.backgroundColor=[UIColor whiteColor];
    //头像
    UIImageView *headImageView = ({
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"account_gived_head"]];
        [self addSubview:imageView];
        imageView;
    });
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    //右边的 view
    UIView *rightView = ({
        UIView *view =[UIView new];
        [self addSubview:view];
        view;
    });
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImageView.mas_right).offset(10);
        make.top.equalTo(headImageView.mas_top);
//        make.bottom.equalTo(self.mas_bottom);
    }];
    //名字
    UILabel *nameLabel = ({
        UILabel *label = [UILabel new];
        label.text = @"唐阿黑";
        label.font =[UIFont systemFontOfSize:18];
        label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        [rightView addSubview:label];
        label;
    });
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightView.mas_left);
        make.top.equalTo(rightView.mas_top).offset(10);
    }];
    
    //账号
    UILabel *accountLabel = ({
        UILabel *label = [UILabel new];
        label.text = @"资金账号：099394959";
        label.font =[UIFont systemFontOfSize:15];
        label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        [rightView addSubview:label];
        label;
    });
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightView.mas_left);
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
    }];
    
}


@end
