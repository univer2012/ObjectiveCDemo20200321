//
//  SHQRCodeViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/15.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHQRCodeViewController.h"
#import "Example1Controller.h"
#import "Example2Controller.h"
#import "Example3Controller.h"

@interface SHQRCodeViewController ()

@end

@implementation SHQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)scanClick:(id)sender {
    Example1Controller *vc = [Example1Controller new];
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:true];
}
- (IBAction)readClick:(id)sender {
    Example2Controller *vc = [Example2Controller new];
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:true];
}
- (IBAction)generateClick:(id)sender {
    Example3Controller *vc = [Example3Controller new];
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:true];
}


@end
