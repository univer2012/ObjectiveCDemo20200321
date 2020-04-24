//
//  SGH0824PresentAndPushThreeViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/8/24.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0824PresentAndPushThreeViewController.h"
#import "SGH0824PresentAndPushOneViewController.h"

#import "SGH0824PresentAndPushFourViewController.h"

@interface SGH0824PresentAndPushThreeViewController ()

@end

@implementation SGH0824PresentAndPushThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"第3页";
    
    UIViewController *presentOneController = self.presentingViewController;
    NSLog(@"presentOneController : %@", presentOneController);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)p_dismissToRoot:(id)sender {
    
#if 0
    //从第3页dismiss到第1页
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
    }];
#else
    SGH0824PresentAndPushFourViewController *fourViewController = [SGH0824PresentAndPushFourViewController new];
    [self presentViewController:fourViewController animated:YES completion:^{
        
    }];
    
#endif
    
}
- (IBAction)p_pushToNext:(id)sender {
    SGH0824PresentAndPushFourViewController *fourViewController = [SGH0824PresentAndPushFourViewController new];
    [self.navigationController pushViewController:fourViewController animated:YES];
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
