//
//  SGH0713ScreenShotViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/7/13.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0713ScreenShotViewController.h"

@interface SGH0713ScreenShotViewController ()

@property(nonatomic,strong)NSObject *service;

@end

@implementation SGH0713ScreenShotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"截屏方案";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    

    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //    UIImage *screenShotImage = [self p_schemeOne];
    UIImage *screenShotImage2 = [self p_schemeTwo];
    
}

//-(UIImage *)p_schemeOne {
//    CGImageRef UIGetScreenImage();
//    CGImageRef img = UIGetScreenImage();
//    return [UIImage imageWithCGImage:img];
//    //UIImage *scImage = [UIImage imageWithCGImage:img];
//    //UIImageWriteToSavedPhotosAlbum(scImage, nil, nil, nil);
//}
-(UIImage *)p_schemeTwo {
    UIWindow*screenWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
-(void)dealloc {
    [self.service description];
}

-(NSObject *)service {
    if (_service == nil) {
        _service = [NSObject new];
    }
    return _service;
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
