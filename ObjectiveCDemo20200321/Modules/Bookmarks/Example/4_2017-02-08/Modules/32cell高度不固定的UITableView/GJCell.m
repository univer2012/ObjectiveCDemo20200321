//
//  GJCell.m
//  cell高度不固定的UITableView
//
//  Created by huangaengoln on 16/1/16.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "GJCell.h"
#import "Masonry.h"

@implementation GJCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
        [self setupConstraint];
    }
    return self;
}

- (void)setupView {
    UIImageView *customImageView = [[UIImageView alloc] init];
    customImageView.layer.cornerRadius = 15.0f;
    customImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:customImageView];
    _customImageView = customImageView;
    
    // ================ title
    // 重点1
    CGFloat preferredWidth = [UIScreen mainScreen].bounds.size.width - 75;
    UILabel *title = [[UILabel alloc] init];
    title.numberOfLines = 0;
    // 重点1
    title.preferredMaxLayoutWidth = preferredWidth;
    title.textColor = [UIColor grayColor];
    [self.contentView addSubview:title];
    _title = title;
    
    // ================= subtitle
    UILabel *subtitle = [[UILabel alloc] init];
    subtitle.numberOfLines = 3;
    // 重点1
    subtitle.preferredMaxLayoutWidth = preferredWidth;
    [self.contentView addSubview:subtitle];
    _subtitle = subtitle;
}

- (void)setupConstraint {
    // customImageView
    [self.customImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(15.0f);
        make.right.equalTo(self.title.mas_left).with.offset(-15.0f);
        make.left.equalTo(self.contentView).with.offset(15.0f);
        make.size.mas_equalTo(CGSizeMake(30.0f, 30.0f));
    }];
    
     // title
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        // 重点2
        make.top.equalTo(self.contentView).with.offset(20.0f).with.priority(751);
        make.right.equalTo(self.contentView).with.offset(-15.0f);
    }];
    
    // subtitle
    [self.subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).with.offset(15.0f);
        make.right.equalTo(self.title);
        make.bottom.equalTo(self.contentView).with.offset(-15.0f).with.priority(749);
        make.left.equalTo(self.title);
    }];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
