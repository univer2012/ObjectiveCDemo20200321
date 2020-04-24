//
//  SGHBanner3DTransitionView.m
//  BannerTransitionType
//
//  Created by huangaengoln on 16/1/27.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHBanner3DTransitionView.h"

/// 获取文件目录中的图片的C语言方法
UIImage *imageInContentsOfFileWith(NSString *imgName) {
    return [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:imgName]];
}

@implementation SGHBanner3DTransitionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)show3DBannerView {
    
    //定义图片控件
    _imageView = [[UIImageView alloc]init];
    _imageView.frame= CGRectMake(0, 0, MainScreenW, 180);
    _imageView.contentMode=UIViewContentModeScaleAspectFit;
    
    _imageView.image = imageInContentsOfFileWith(_imageArr[0]);//默认图片
    //[UIImage imageNamed:_imageArr[0]];
    _imageView.userInteractionEnabled = YES;
    self.userInteractionEnabled = YES;
    [self addSubview:_imageView];
    _imageView.tag = 10;
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doDoubleTap:)];//默认点击第一张
    [_imageView addGestureRecognizer:doubleTap];
    
    //添加手势
    UISwipeGestureRecognizer *leftSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction=UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:rightSwipeGesture];
}

#pragma mark 向左滑动浏览下一张图片
-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:YES];
}

#pragma mark 向右滑动浏览上一张图片
-(void)rightSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:NO];
}

#pragma mark 转场动画
-(void)transitionAnimation:(BOOL)isNext{
    //1.创建转场动画对象
    CATransition *transition=[[CATransition alloc]init];
    /* The name of the transition. Current legal transition types include
     * `fade', `moveIn', `push' and `reveal'. Defaults to `fade'. */
    /*
     fade       逐渐显现
     moveIn     渐进隐藏左移/右移 出现
     push       左推/右推 出现
     reveal     发卡牌式的 推出，被推出的渐进 消失
     cube       立体 翻转 效果 ---->   私有API
     */
    //2.设置动画类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
    transition.type=@"cube";//@"cube";
    /* An optional subtype for the transition. E.g. used to specify the
     * transition direction for motion-based transitions, in which case
     * the legal values are `fromLeft', `fromRight', `fromTop' and
     * `fromBottom'. */
    //@property(nullable, copy) NSString *subtype;
    //    transition.subtype=@"fromTop";
    
    //设置子类型
    if (isNext) {
        transition.subtype=kCATransitionFromRight;
    }else{
        transition.subtype=kCATransitionFromLeft;
    }
    //设置动画时常
    transition.duration=0.5f;
    
    //3.设置转场后的新视图添加转场动画
    _imageView.image=[self getImage:isNext];
    [_imageView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
}

#pragma mark 取得当前图片
-(UIImage *)getImage:(BOOL)isNext{
    if (isNext) {
        _currentIndex=(_currentIndex+1)%_imageArr.count;
    }else{
        _currentIndex=(_currentIndex-1+_imageArr.count)%(int)_imageArr.count;
    }
    NSString *imageName = _imageArr[_currentIndex];
    
    
    _imageView.tag = _currentIndex+10;
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doDoubleTap:)];
    
    [_imageView addGestureRecognizer:doubleTap];
    
    
    return imageInContentsOfFileWith(imageName); //[UIImage imageNamed:imageName];
}

- (void)doDoubleTap:(UITapGestureRecognizer*)gesture
{
    
    [_delegate ClickImage:(int)(gesture.view.tag-10)];
}

@end
