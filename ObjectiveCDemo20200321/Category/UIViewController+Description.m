//
//  UIViewController+Description.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/24.
//  Copyright © 2020 远平. All rights reserved.
//

#import "UIViewController+Description.h"


@implementation UIViewController (Description)

- (UILabel *)showDescWith:(NSString *)text {
    ///文字说明
    UILabel *tipLab = [UILabel new];
    tipLab.backgroundColor = UIColor.systemBlueColor;
    tipLab.textColor = UIColor.whiteColor;
    tipLab.numberOfLines = 0;
    tipLab.text = text;
    [self.view addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(88);
    }];
    return tipLab;
}

- (UIButton *)buildBtnWith:(NSString *)text {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.numberOfLines = 0;
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 6;
    btn.layer.borderWidth =  1;
    btn.layer.borderColor = [UIColor blueColor].CGColor;
    btn.layer.masksToBounds = YES;
    [self.view addSubview:btn];
    return btn;
}

@end
