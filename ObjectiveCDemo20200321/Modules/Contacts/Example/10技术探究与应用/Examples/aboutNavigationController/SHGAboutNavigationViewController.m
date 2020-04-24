//
//  SHGAboutNavigationViewController.m
//  ObjectiveCDemo
//
//  Created by huangaengoln on 16/3/12.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SHGAboutNavigationViewController.h"

@interface SHGAboutNavigationViewController ()

@end

@implementation SHGAboutNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
self.title = [NSString stringWithFormat:@"第%lu页",(unsigned long)self.navigationController.viewControllers.count];
    self.title=@"标题";
    //2、设置导航栏的 标题 文字颜色：
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //3、设置NavigationBar背景颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
#if 0
    //4、设置UIBarButtonSystemItem 的图标 的颜色：
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickPopoverButton:)];
    barButtonItem.tintColor=[UIColor whiteColor];   //改变UIBarButtonSystemItem的显示颜色
    self.navigationItem.rightBarButtonItem = barButtonItem;
    

    //5、设置导航栏标题的 字体颜色、文字阴影、文字大小
    NSShadow *navTitleShadow = [[NSShadow alloc]init];
    navTitleShadow.shadowColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    navTitleShadow.shadowOffset = CGSizeMake(0, 5);
    
    [self.navigationController.navigationBar setTitleTextAttributes:
  @{NSForegroundColorAttributeName:[UIColor greenColor],/*[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]*/
    NSShadowAttributeName:navTitleShadow,
    NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0]
    }];
#endif
    
    //6、使用图片作为导航栏标题。设置了 titleView 后，标题自动隐藏
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qrcode_screen"]];
    //13、设置 titleView 的背景颜色
    self.navigationItem.titleView.backgroundColor=[UIColor redColor];
    
    //7、添加多个栏按钮项目
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(clickPopoverButton:)];
    UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(clickPopoverButton:)];
    self.navigationItem.leftBarButtonItems = @[shareItem,cameraItem];  //从右往左
//    self.navigationItem.leftBarButtonItem = shareItem;
    //12、设置 左边按钮和back按钮同时存在
    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    
    
}
-(void)clickPopoverButton:(UIBarButtonItem *)barButtonItem {
    NSLog(@"%s",__func__);
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
