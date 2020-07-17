//
//  SGH161128TabBarViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2016/11/28.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH161128TabBarViewController.h"

#import "SGH1128BookmarksViewController.h"
#import "SGH1128ContactsViewController.h"
#import "SGH0424HistoryViewController.h"

@interface SGH161128TabBarViewController ()

@end

@implementation SGH161128TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //系统的返回手势
//    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    // Do any additional setup after loading the view.
    UINavigationController *bookmarksNavController = ({
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:[SGH1128BookmarksViewController new]];
        navigationController.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:0];
        navigationController;
    });
    
    UINavigationController *contactsNavController = ({
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:[SGH1128ContactsViewController new]];
        navigationController.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemContacts tag:1];
        navigationController;
    });
    
    UINavigationController *historyNavController = ({
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:[SGH0424HistoryViewController new]];
        navigationController.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemHistory tag:2];
        navigationController;
    });
    
    self.viewControllers = @[bookmarksNavController, contactsNavController,historyNavController];
    
    //设置选中的tabBarItem颜色
    //if (@available(iOS 8.0, *)) {}
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [self.tabBar setSelectedImageTintColor:[UIColor redColor]];
    }
    else {
        self.tabBar.tintColor = [UIColor redColor];//iOS5.0
    }
    
    
    
    
    
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
