//
//  SGHPopoverPresentationController.m
//  ObjectiveCDemo
//
//  Created by huangaengoln on 16/3/12.
//  Copyright © 2016年 huangaengoln. All rights reserved.

#import "SGHPopoverPresentationController.h"
#import "SGHPopContentViewController.h"

@interface SGHPopoverPresentationController ()<UIPopoverPresentationControllerDelegate>

@end

@implementation SGHPopoverPresentationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"popover";
    self.view.backgroundColor=[UIColor blueColor];//whiteColor];
    
    //设置NavigationBar背景颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    //设置 self.title 文字的 颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"泡泡效果" style:UIBarButtonItemStylePlain target:self action:@selector(clickPopoverButton:)];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickPopoverButton:)];
    barButtonItem.tintColor=[UIColor whiteColor];   //改变UIBarButtonSystemItem的显示颜色
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}

-(void)clickPopoverButton:(UIBarButtonItem *) barButtonItem {
    
#if 1
    SGHPopContentViewController *contentController = [[SGHPopContentViewController alloc]init];
    CGFloat heightForRow = 40;  //tableView 的高度
    __block NSArray *dataArray =@[@{@"image":@"qrcode_screen",@"title":@"扫一扫"},
                          @{@"image":@"system_setting",@"title":@"股票查询"},
                          @{@"image":@"stock_search",@"title":@"系统设置"}];
    contentController.paramDictionary=@{@"dataArray":dataArray,@"heightForRow":@(heightForRow)};
    contentController.preferredContentSize=CGSizeMake(150, dataArray.count * heightForRow);
    contentController.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popPresentationController = contentController.popoverPresentationController;
    popPresentationController.barButtonItem=barButtonItem;
    popPresentationController.delegate=self;
    
    popPresentationController.permittedArrowDirections=UIPopoverArrowDirectionAny;
    [self presentViewController:contentController animated:YES completion:^{ }];
    contentController.selectedBlock = ^(NSInteger index) {
        switch (index) {
            case 0:{
                NSLog(@"%@",dataArray[index]);
            }
                break;
            case 1:{
                NSLog(@"%@",dataArray[index]);
            }
                break;
            case 2:{
                NSLog(@"%@",dataArray[index]);
            }
                break;
        }
        [self dismissViewControllerAnimated:YES completion:^{ }];
    };
    
#elif 0
    UIViewController *tempViewController = [[UIViewController alloc]init];
    tempViewController.preferredContentSize=CGSizeMake(200, 350);
    tempViewController.modalPresentationStyle = UIModalPresentationPopover;
    //    tempViewController.popoverPresentationController.sourceView=
    //    tempViewController.popoverPresentationController.sourceRect=
    
    
    UIPopoverPresentationController *popViewController = tempViewController.popoverPresentationController;
    popViewController.delegate=self;
    
    popViewController.barButtonItem = barButtonItem;
    [self presentViewController:tempViewController animated:YES completion:^{ }];
#endif
    
}
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    /*
     UIModalPresentationFullScreen = 0,
     UIModalPresentationPageSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
     UIModalPresentationFormSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
     UIModalPresentationCurrentContext NS_ENUM_AVAILABLE_IOS(3_2),
     UIModalPresentationCustom NS_ENUM_AVAILABLE_IOS(7_0),
     UIModalPresentationOverFullScreen NS_ENUM_AVAILABLE_IOS(8_0),
     UIModalPresentationOverCurrentContext NS_ENUM_AVAILABLE_IOS(8_0),
     UIModalPresentationPopover NS_ENUM_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED,
     UIModalPresentationNone NS_ENUM_AVAILABLE_IOS(7_0) = -1,
     */
    return UIModalPresentationNone;
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
