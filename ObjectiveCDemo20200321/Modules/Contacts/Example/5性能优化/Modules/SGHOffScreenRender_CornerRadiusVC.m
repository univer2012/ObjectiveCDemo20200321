//
//  SGHOffScreenRender_CornerRadiusVC.m
//  ObjectiveCDemo20200321
//
//  Created by blue on 2020/7/8.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHOffScreenRender_CornerRadiusVC.h"

@interface SGHOffScreenRender_CornerRadiusVC ()

@end

@implementation SGHOffScreenRender_CornerRadiusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)demo7 {
    // 创建一个button视图
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200.0, 200.0)];
    //设置图片
    [button setImage:[self image] forState:UIControlStateNormal];
    // 设置圆角
    button.imageView.layer.cornerRadius = 100.0;
    // 设置裁剪
    button.imageView.clipsToBounds = YES;
    button.center = self.view.center;
    [self.view addSubview:button];
}

- (void)demo6 {
    // 创建一个button视图
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200.0, 200.0)];
    //设置图片
    [button setImage:[self image] forState:UIControlStateNormal];
    // 设置圆角
    button.layer.cornerRadius = 100.0;
    // 设置裁剪
    button.clipsToBounds = YES;
    button.center = self.view.center;
    [self.view addSubview:button];
}

- (void)demo5 {
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200.0, 200.0)];
    //设置图片
    view1.layer.contents = (__bridge id)[self image].CGImage;
    // 设置圆角
    view1.layer.cornerRadius = 100.0;
    // 设置裁剪
    view1.clipsToBounds = YES;
    
    view1.center = self.view.center;
    [self.view addSubview:view1];
    
}

- (void)demo4 {
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200.0, 200.0)];
    // 设置背景色
    view1.backgroundColor = UIColor.redColor;
    // 设置边框宽度和颜色
    view1.layer.borderWidth = 2.0;
    view1.layer.borderColor = UIColor.blackColor.CGColor;
    // 设置圆角
    view1.layer.cornerRadius = 100.0;
    // 设置裁剪
    view1.clipsToBounds = YES;
    
    // 子视图
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100.0, 100.0)];
    // 下面3个任何一个属性
    // 设置背景色
    view2.backgroundColor = UIColor.blueColor;
    // 设置内容
    view2.layer.contents = (__bridge id)([self image].CGImage);
    // 设置边框
    view2.layer.borderWidth = 2.0;
    view2.layer.borderColor = UIColor.blackColor.CGColor;
    [view1 addSubview:view2];
    
    view1.center = self.view.center;
    [self.view addSubview:view1];
}

- (void)demo3 {
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200.0, 200.0)];
    // 设置背景色
    view1.backgroundColor = UIColor.redColor;
    // 设置边框宽度和颜色
    view1.layer.borderWidth = 2.0;
    view1.layer.borderColor = UIColor.blackColor.CGColor;
    
    //设置图片
    view1.layer.contents = (__bridge id)[self image].CGImage;

    
    
    // 设置圆角
    view1.layer.cornerRadius = 100.0;
    // 设置裁剪
    view1.clipsToBounds = YES;
    view1.center = self.view.center;
    [self.view addSubview:view1];
}

- (UIImage *)image {
    NSString *path1 = [[NSBundle mainBundle]pathForResource:@"pkq" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path1];
    return image;
}

- (void)demo2 {
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200.0, 200.0)];
      // 设置背景色
      view1.backgroundColor = UIColor.redColor;
      // 设置边框宽度和颜色
      view1.layer.borderWidth = 2.0;
      view1.layer.borderColor = UIColor.blackColor.CGColor;
      // 设置圆角
      view1.layer.cornerRadius = 100.0;
    
      // 设置裁剪
      view1.clipsToBounds = YES;
      
      view1.center = self.view.center;
      [self.view addSubview:view1];
}

- (void)demo1 {
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200.0, 200.0)];
    // 设置背景色
    view1.backgroundColor = UIColor.redColor;
    // 设置边框宽度和颜色
    view1.layer.borderWidth = 2.0;
    view1.layer.borderColor = UIColor.blackColor.CGColor;
    // 设置圆角
    view1.layer.cornerRadius = 100.0;
    
    view1.center = self.view.center;
    [self.view addSubview:view1];
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
