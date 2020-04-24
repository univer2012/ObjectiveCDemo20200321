//
//  SGHMethodSwizzlingViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/5/3.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHMethodSwizzlingViewController.h"

#import "Masonry.h"

#import "NSString+Chinese.h"

#import "NSString+MD5.h"

@implementation SGHMethodSwizzlingViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"home_icon"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.center.equalTo(self.view);
    }];
 
    
    UIButton *button = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor blueColor];
        [button setTitle:@"点我" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickMe:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    
    
    if (![@"你好123" isChinese]) {
        NSLog(@"不是纯汉字");
    }
    if ([@"你好123" includeChinese]) {
        NSLog(@"包含汉字");
    }
    
    
    NSString *md5bitStirng = [@"你好" md5_32bit];
    NSLog(@"%@",md5bitStirng);
    
//   NSString *MDBITString = [md5bitStirng MD5_32BIT];
    NSString *MDBITString = [@"你好" MD5_32BIT];
    NSLog(@"%@", MDBITString);
    
    
}
-(void)clickMe:(UIButton *)button {
    NSLog(@"点我");
}

@end
