//
//  SGH0824PresentAndPushTwoViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/8/24.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0824PresentAndPushTwoViewController.h"
#import "SGH0824PresentAndPushThreeViewController.h"

@interface SGH0824PresentAndPushTwoViewController ()

@end

@implementation SGH0824PresentAndPushTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"第2页";
    UIViewController *presentOneController = self.presentingViewController;
    NSLog(@"presentOneController : %@", presentOneController);
    
    UIViewController *presentThreeController = self.presentingViewController.presentingViewController.presentingViewController;
    NSLog(@"presentThreeController : %@", presentThreeController);
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)p_presentToNext:(id)sender {
    SGH0824PresentAndPushThreeViewController * threeViewController = [SGH0824PresentAndPushThreeViewController new];
    [self presentViewController:threeViewController animated:YES completion:^{
        
    }];
}

- (IBAction)p_pushToNext:(id)sender {
    SGH0824PresentAndPushThreeViewController * threeViewController = [SGH0824PresentAndPushThreeViewController new];
    [self.navigationController pushViewController:threeViewController animated:YES];
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
