//
//  SGHVariableParamsViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/22.
//  Copyright © 2020 远平. All rights reserved.
//
/**
    * demo来自程序员群
 */
#import "SGHVariableParamsViewController.h"
#import "VarArgs.h"

@interface SGHVariableParamsViewController ()

@end

@implementation SGHVariableParamsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    VarArgs *var = [[VarArgs alloc] init];
    [var test:@"疯狂iOS讲义", @"疯狂Android讲义", @"疯狂Ajax讲义", nil];
    
    
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
