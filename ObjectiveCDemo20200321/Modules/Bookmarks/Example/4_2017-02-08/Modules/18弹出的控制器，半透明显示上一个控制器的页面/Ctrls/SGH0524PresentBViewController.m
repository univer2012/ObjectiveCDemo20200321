//
//  SGH0524PresentBViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/24.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0524PresentBViewController.h"

#import <Masonry.h>

#import "SGH0524PresentCViewController.h"

@interface SGH0524PresentBViewController ()

@end

@implementation SGH0524PresentBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    UIButton *button = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.layer.cornerRadius = 3;
        button.clipsToBounds = YES;
        button.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        button.tag = 104;
        [button setTitle:@"B Controller Button" forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addTarget:self action:@selector(p_presentClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset( 150 );
    }];
}

-(void)p_presentClick {
    SGH0524PresentCViewController *vc = [[SGH0524PresentCViewController alloc]init];
    //大于等于 iOS8.0
    if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending) {
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    else {
        vc.modalPresentationStyle = UIModalPresentationCurrentContext;
        vc.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    }
    [self presentViewController:vc animated:YES completion:^{ }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
