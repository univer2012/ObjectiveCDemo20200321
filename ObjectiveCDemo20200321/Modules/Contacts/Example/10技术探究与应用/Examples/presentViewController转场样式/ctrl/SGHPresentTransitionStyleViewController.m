//
//  SGHPresentTransitionStyleViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/4/7.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHPresentTransitionStyleViewController.h"
#import "SGHPresentTransitionSecondViewController.h"

@interface SGHPresentTransitionStyleViewController ()

@end

@implementation SGHPresentTransitionStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(10, 70, CGRectGetWidth(self.view.frame)-10*2, 40);
    [button setTitle:@"presentViewController" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(presentViewControllerClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void) presentViewControllerClicked: (UIButton *)button {
    SGHPresentTransitionSecondViewController *secondViewController=[SGHPresentTransitionSecondViewController new];
    /*
     UIModalTransitionStyleCoverVertical = 0,   从下往上推
     UIModalTransitionStyleFlipHorizontal __TVOS_PROHIBITED,    从右往左翻(块状翻转)
     UIModalTransitionStyleCrossDissolve,       渐变
     UIModalTransitionStylePartialCurl NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,  从下往上掀(掀纸张那样)
     */
    
    secondViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:secondViewController animated:YES completion:^{ }];
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
