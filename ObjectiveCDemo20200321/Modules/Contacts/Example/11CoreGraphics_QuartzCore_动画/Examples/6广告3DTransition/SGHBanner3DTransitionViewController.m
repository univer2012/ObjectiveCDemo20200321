//
//  SGHBanner3DTransitionViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/24.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 * 来自：
 [转场动画 CATransition ，效果惊人](https://www.cnblogs.com/qiugaoying/p/4904853.html)
 */
#import "SGHBanner3DTransitionViewController.h"
#import "SGHBanner3DTransitionView.h"

@interface SGHBanner3DTransitionViewController ()<SGHBanner3DTransitionViewImageDelegate>
{
    UIImageView *_imageView;
    int _currentIndex;
}

@end

@implementation SGHBanner3DTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SGHBanner3DTransitionView *banner3DTransitionView = [[SGHBanner3DTransitionView alloc]initWithFrame: CGRectZero];//CGRectMake(0, 0, self.view.frame.size.width, 180)
    banner3DTransitionView.imageArr = @[
        @"banner_3d_tran_0.jpg",
        @"banner_3d_tran_1.jpg",
        @"banner_3d_tran_2.jpg",
        @"banner_3d_tran_3.jpg",
        @"banner_3d_tran_4.jpg",
        @"banner_3d_tran_5.jpg",
    ];
    banner3DTransitionView.delegate = self;
    [banner3DTransitionView show3DBannerView];
    [self.view addSubview:banner3DTransitionView];
    [banner3DTransitionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(88);
        make.height.mas_equalTo(180);
    }];
}

//点击了第几张图片
-(void)ClickImage:(int)index {
     NSLog(@"点击了第%d张",index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
