//
//  SHImageText0214ViewController.m
//  ObjectiveCDemo160728
//
//  Created by sengoln huang on 2019/2/14.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHImageText0214ViewController.h"

#import <Masonry/Masonry.h>

#import "XGImageTitleView.h"

#import "UIButton+SHDistribute.h"

#import "UIColor+Hex.h"

@interface SHImageText0214ViewController ()

@end

@implementation SHImageText0214ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    kWeakSelf
    XGImageTitleView *tempImgView = ({
        XGImageTitleView *view = [XGImageTitleView new];
        view.imageView.image = [UIImage imageNamed:@"weixin_012101"];
        view.titleLabel.text = @"A123456";
        view.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        view.titleLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [view xg_distributeViewsWithStyle:XGViewEdgeInsetsStyleImageTop fixedSpacing:15 leadSpacing:0 tailSpacing:0];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//        [view addGestureRecognizer:tap];
//        view.userInteractionEnabled = YES;
        
        view.layer.borderWidth = 1;
        view.layer.borderColor = [UIColor colorWithHexString:@"#FF0000"].CGColor;
        [weakSelf.view addSubview:view];
        view;
    });
    
    [tempImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(weakSelf.view).offset(100);//67 x 17
//        make.size.mas_equalTo( CGSizeMake(70, 20) );
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    UIButton *introCodeButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.contentMode = UIViewContentModeRight;
        [button setTitle:@"A123456" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        [button setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"weixin_012101"] forState:UIControlStateNormal];
        //[button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        button.frame = CGRectMake(100, 130, 70, 20);
        button.frame = CGRectMake(100, 200, 70, 70);
        
        [button distributeViewsWithStyle:SHViewEdgeInsetsStyleTop fixedSpacing:15 leadSpacing:0 tailSpacing:0];
        
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor colorWithHexString:@"#FF0000"].CGColor;
        [weakSelf.view addSubview:button];
        button;
    });
    
    
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
