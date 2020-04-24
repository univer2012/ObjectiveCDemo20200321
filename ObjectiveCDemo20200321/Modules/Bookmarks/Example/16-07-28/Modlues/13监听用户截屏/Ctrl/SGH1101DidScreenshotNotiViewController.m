//
//  SGH1101DidScreenshotNotiViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/11/1.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH1101DidScreenshotNotiViewController.h"

@interface SGH1101DidScreenshotNotiViewController ()

@end

@implementation SGH1101DidScreenshotNotiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //这个写法是针对于当前控制器
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationUserDidTakeScreenshotNotification                                                       object:nil queue:mainQueue usingBlock:^(NSNotification *note){
        [self p_showAlertScreenshot];
    }];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //离开当前控制器的时候  最好移除通知
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(p_showAlertScreenshot) object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}

-(void)p_showAlertScreenshot {
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"[安全提醒]内含付款码，只适合当面使用。不要截图或分享给他人以保障资金安全。"delegate:self cancelButtonTitle:@"绝不给别人"otherButtonTitles:@"仅我自己用",nil];
    alertView.tag=105;
    [alertView show];
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
