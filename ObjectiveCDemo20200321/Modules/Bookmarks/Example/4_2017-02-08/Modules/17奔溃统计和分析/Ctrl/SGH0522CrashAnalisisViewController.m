//
//  SGH0522CrashAnalisisViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/22.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0522CrashAnalisisViewController.h"

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)//用来获取手机的系统，判断系统是多少


@interface SGH0522CrashAnalisisViewController ()

@end

@implementation SGH0522CrashAnalisisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self p_arrayOne];

}

-(void)p_arrayOne {
    NSMutableArray *testArray = [NSMutableArray array];
//    [testArray addObject:@"1"];
//    [testArray addObject:@"2"];
//    testArray = nil;
    NSArray *filterArr = @[@"3", @"4"];
    
    NSInteger index = [testArray indexOfObject:[filterArr firstObject]];
    NSLog(@"index: %ld",index);
    
    
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
