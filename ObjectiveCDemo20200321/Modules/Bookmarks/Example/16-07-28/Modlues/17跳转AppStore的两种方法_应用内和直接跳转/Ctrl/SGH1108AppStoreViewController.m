//
//  SGH1108AppStoreViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2016/11/8.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH1108AppStoreViewController.h"
#import <StoreKit/StoreKit.h>

@interface SGH1108AppStoreViewController ()<SKStoreProductViewControllerDelegate>

@end

@implementation SGH1108AppStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_setupButton];
}


-(void)p_setupButton {
    //第一种方法  直接跳转
    UIButton *btn = ({
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"直接跳转" forState:UIControlStateNormal];
        button.tag = 1;
        [button addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:btn];
    
    //第二中方法  应用内跳转
    UIButton *btnT = ({
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 100, 50)];
        button.backgroundColor = [UIColor purpleColor];
        button.tag = 2;
        [button setTitle:@"应用内跳转" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:btnT];
    
    //跳转评论区
    UIButton *btn3 = ({
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 500, 100, 50)];
        button.backgroundColor = [UIColor purpleColor];
        button.tag = 3;
        [button setTitle:@"跳转评论区" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:btn3];
}


- (void)btn:(UIButton *)btn{
    //第一种方法  直接跳转
    if (btn.tag == 1) {
        //跳转到appstore中的app详情页面
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://itunes.apple.com/cn/app/id963463279?mt=8"]];
        //下一句有效
        //@"itms-apps://itunes.apple.com/app/id963463279"]];
    }
    //第二中方法  应用内跳转
    else if (btn.tag == 2) {
        
        //1:导入StoreKit.framework,控制器里面添加框架#import <StoreKit/StoreKit.h>
        //2:实现代理SKStoreProductViewControllerDelegate
        SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
        storeProductViewContorller.delegate = self;
        //加载一个新的视图展示
        [storeProductViewContorller loadProductWithParameters:
         //appId
         @{SKStoreProductParameterITunesItemIdentifier : @"963463279"} completionBlock:^(BOOL result, NSError *error) {
             //回调
             if(error){
                 NSLog(@"错误%@",error);
             }else{
                 //AS应用界面
                 [self presentViewController:storeProductViewContorller animated:YES completion:nil];
             }
         }];
    }
    //跳转评论区
    else if (btn.tag == 3) {
        NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=963463279&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    
}
#pragma mark - 评分取消按钮监听
//取消按钮监听
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
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
