//
//  SGHPresentTransitionSecondViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/4/7.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHPresentTransitionSecondViewController.h"

@interface SGHPresentTransitionSecondViewController ()

@end

@implementation SGHPresentTransitionSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor redColor];
    // Do any additional setup after loading the view.
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 70, CGRectGetWidth(self.view.frame)-10*2, 40);
    [button setTitle:@"dismissViewController" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(dismissViewControllerClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

-(void) dismissViewControllerClicked:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:^{ }];
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
