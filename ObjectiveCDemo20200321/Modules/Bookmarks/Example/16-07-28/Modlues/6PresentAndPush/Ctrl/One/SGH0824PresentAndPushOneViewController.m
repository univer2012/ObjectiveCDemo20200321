//
//  SGH0824PresentAndPushOneViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/8/24.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0824PresentAndPushOneViewController.h"

#import "SGH0824PresentAndPushTwoViewController.h"

@interface SGH0824PresentAndPushOneViewController ()

@end

@implementation SGH0824PresentAndPushOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"第1页";
    UIViewController *presentOneController = self.presentingViewController;
    NSLog(@"presentOneController : %@", presentOneController);
    
    UIViewController *presentTwoController = self.presentingViewController.presentingViewController;
    NSLog(@"presentTwoController : %@", presentTwoController);
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)p_presentToNext:(id)sender {
    SGH0824PresentAndPushTwoViewController * twoViewController = [SGH0824PresentAndPushTwoViewController new];
    [self presentViewController:twoViewController animated:YES completion:^{
        
    }];
    
}

- (IBAction)p_pushToNext:(id)sender {
    SGH0824PresentAndPushTwoViewController * twoViewController = [SGH0824PresentAndPushTwoViewController new];
    [self.navigationController pushViewController:twoViewController animated:YES];
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
