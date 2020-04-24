//
//  SGH0729WheelViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/7/29.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0729WheelViewController.h"
#import "SGHWheelView.h"

@interface SGH0729WheelViewController ()

@property(nonatomic, strong)SGHWheelView *wheelView;

@end

@implementation SGH0729WheelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SGHWheelView *wheelView = [SGHWheelView wheelView];
    //    wheelView.center = self.view.center;
    wheelView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    [wheelView startAnimation];
    //    [wheelView stopAnimation];
    [self.view addSubview:wheelView];
    self.wheelView = wheelView;
    
}

- (IBAction)stopAction:(id)sender {
    [self.wheelView stopAnimation];
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