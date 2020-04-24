//
//  SGH0524PresentAViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/24.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0524PresentAViewController.h"

#import <Masonry.h>

#import "SGH0524PresentBViewController.h"

@interface SGH0524PresentAViewController ()

@end

@implementation SGH0524PresentAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.layer.cornerRadius = 3;
        button.clipsToBounds = YES;
        button.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        button.tag = 104;
        [button setTitle:@"A Controller Button" forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addTarget:self action:@selector(p_presentClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset( 100 );
    }];
    
    
    //MARK: 测试
    //中签弹框
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//    userInfo[@"stateActionExt"] = @{@"isPopUp": @"1"};
    userInfo[@"msgId"] = @"4994";
    
    NSDictionary *stateActionExtDict = userInfo[@"stateActionExt"];
    if (stateActionExtDict.count > 0) {
        NSString *isPopUp = stateActionExtDict[@"isPopUp"];
        //要弹框
        if (isPopUp.length > 0 && [isPopUp integerValue] == 1) {
            
            NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
            //paramsDict[@"requestServerUrl"] = [TKIMSDKConfig shareInstance].httpPushUrl;
            paramsDict[@"funcNo"] = @"1003637";
            paramsDict[@"msg_id"] = userInfo[@"msgId"];
            
            //http://114.251.97.186:9610/servlet/json?funcNo=1003637&msg_id=4994
            
        }
    }
    
}

-(void)p_presentClick {
    SGH0524PresentBViewController *vc = [[SGH0524PresentBViewController alloc]init];
    
    //self.definesPresentationContext = YES;
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
