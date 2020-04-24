//
//  SGHGesturerViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/30.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHGesturerViewController.h"

@interface SGHGesturerViewController ()

@end

@implementation SGHGesturerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]init];
    [[tap rac_gestureSignal] subscribeNext:^(UITapGestureRecognizer *tap) {
        LxDBAnyVar(tap);
    }];
    [self.view addGestureRecognizer:tap];
    
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
