//
//  SGH1013ImageSaveAlbumViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/10/13.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH1013ImageSaveAlbumViewController.h"

@interface SGH1013ImageSaveAlbumViewController ()

@property(nonatomic, strong)UIImage *currentControllerImage;

@end

@implementation SGH1013ImageSaveAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //_currentControllerImage = [self p_getImageFromCurrentImageContext];
    
    
    [self p_setupButtonWithRect:CGRectMake(0, 80, 100, 40) title:@"截取图片" action:@selector(p_getImageFromCurrentImageContext)];
    [self p_setupButtonWithRect:CGRectMake(0, 130, 100, 40) title:@"保存图片" action:@selector(p_saveImageClicked:)];
    
    
}

-(void)p_setupButtonWithRect:(CGRect)rect title:(NSString *)title action:(SEL)action {
    UIButton *button = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = rect;
        button.center = CGPointMake(self.view.center.x, button.center.y);
        button.backgroundColor = [UIColor grayColor];
        button.layer.cornerRadius = 5;
        button.clipsToBounds = YES;
        [button setTitle:title forState:UIControlStateNormal];
        [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:button];
}

//获取当前页面的截图
- (void)p_getImageFromCurrentImageContext {
    UIGraphicsBeginImageContextWithOptions([[UIScreen mainScreen]bounds].size, NO, 1.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _currentControllerImage = image;
    [self p_showAlertViewWithMessage:@"截图成功"];
    //return image;
}


-(void)p_saveImageClicked:(UIButton *)button {
    UIImageWriteToSavedPhotosAlbum(_currentControllerImage, nil, nil, nil);
    [self p_showAlertViewWithMessage:@"已保存到相册"];
    //UIImageWriteToSavedPhotosAlbum(_currentControllerImage, self, @selector(p_comeBack), nil);
}


-(void)p_showAlertViewWithMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}
-(void)p_comeBack {
    NSLog(@"保存完成");
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
