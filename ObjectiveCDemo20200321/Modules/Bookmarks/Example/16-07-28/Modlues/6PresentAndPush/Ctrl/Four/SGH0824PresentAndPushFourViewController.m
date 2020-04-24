//
//  SGH0824PresentAndPushFourViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/8/24.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0824PresentAndPushFourViewController.h"

@interface SGH0824PresentAndPushFourViewController ()

@end

@implementation SGH0824PresentAndPushFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"第4页";
    
    //获取push的堆栈中的所有控制器
    NSArray *viewControllers = self.navigationController.viewControllers;
    for (UIViewController *viewController in viewControllers) {
        NSLog(@"viewController : %@", viewController);
        /*
         2016-08-24 11:37:46.413 ObjectiveCDemo160728[16206:153310] viewController : <ViewController: 0x7faafa6199a0>
         2016-08-24 11:37:46.413 ObjectiveCDemo160728[16206:153310] viewController : <SGH160728ViewController: 0x7faafa55fec0>
         2016-08-24 11:37:46.414 ObjectiveCDemo160728[16206:153310] viewController : <SGH0824PresentAndPushOneViewController: 0x7faafa49b470>
         2016-08-24 11:37:46.414 ObjectiveCDemo160728[16206:153310] viewController : <SGH0824PresentAndPushTwoViewController: 0x7faafa49b780>
         2016-08-24 11:37:46.414 ObjectiveCDemo160728[16206:153310] viewController : <SGH0824PresentAndPushThreeViewController: 0x7faafa72b160>
         2016-08-24 11:37:46.414 ObjectiveCDemo160728[16206:153310] viewController : <SGH0824PresentAndPushFourViewController: 0x7faafa49d750>
         */
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)p_dismissToRootAndThree:(id)sender {
    //dismiss到第1页
    [self.presentingViewController.presentingViewController.presentingViewController dismissViewControllerAnimated:NO completion:^{
        
        [self.presentingViewController.presentingViewController.presentingViewController presentViewController:self.presentingViewController.presentingViewController animated:YES completion:^{
            
        }];
    }];
    
}
- (IBAction)p_popToRootAndToTwo:(id)sender {
    
    //pop到根目录
//    [self.navigationController popToRootViewControllerAnimated:YES];
    //pop到第2页控制器
//    NSArray *viewControllers = self.navigationController.viewControllers;
//    [self.navigationController popToViewController:viewControllers[viewControllers.count -3] animated:YES];
    //pop到上一个控制器
//    [self.navigationController popViewControllerAnimated:YES];
    
    //pop到第1页，然后再push到第2页
    NSArray *viewControllers = self.navigationController.viewControllers;
    NSLog(@"viewControllers : %@",viewControllers);
    self.navigationController.viewControllers = @[viewControllers[0], viewControllers[1], viewControllers[2]];
    
    NSArray *twoViewControllers = self.navigationController.viewControllers;
    NSLog(@"twoViewControllers : %@",twoViewControllers);
    
    UIViewController *oneViewController = viewControllers[viewControllers.count -4];
    UIViewController *twoViewController = viewControllers[viewControllers.count -3];
    
    [self.navigationController popToViewController:oneViewController animated:YES];
    [oneViewController.navigationController pushViewController:twoViewController animated:YES];
    
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
