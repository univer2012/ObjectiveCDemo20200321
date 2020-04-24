//
//  SGHWheelView.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/7/29.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHWheelView.h"

#import "SGH0729Button.h"

@interface SGHWheelView ()

@property (weak, nonatomic) IBOutlet UIImageView *centerView;

@property(nonatomic, strong)UIButton *selectedButton;

@property(nonatomic, strong)CADisplayLink *link;

@end

@implementation SGHWheelView

+(instancetype)wheelView {
    return [[[NSBundle mainBundle] loadNibNamed:@"SGHWheelView" owner:nil options:nil] lastObject];
}
//需要在转盘上添加按钮.加载数据需要调用的方法就是 -awakeFromNib ,只要是通过xib文件创建，那么久一定会调用这个方法
-(void)awakeFromNib {
    CGFloat wheelPictureNumber = 12.0;
    
    self.centerView.userInteractionEnabled = YES;
    
    //加载图片
    UIImage *image = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *imageSelected = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    //从大图片中裁剪对应星座的图片
    CGFloat smallWidth = image.size.width / wheelPictureNumber * [UIScreen mainScreen].scale;
    CGFloat smallHeight = image.size.height * [UIScreen mainScreen].scale;
    //添加按钮
    for (int i = 0; i < 12; i++) {
        SGH0729Button *button = [SGH0729Button buttonWithType:UIButtonTypeCustom];
        CGRect smallRect = CGRectMake(i * smallWidth, 0, smallWidth, smallHeight);
        //裁剪图片
        /**
         *	根据rect的大小来生成图片
         *	@param image      CGImageRef
         *	@param rect       要裁剪的图片的区域
         *	@return
         CGImageCreateWithImageInRect 只认像素 也就是说，在这里，对应的rect也要进行转换,在定义每张小图片时，将尺寸转换成以像素来计算，转换方式就是乘以分辨率，而屏幕的分辨率的方法是 [UIScreen mainScreen].scale。将高度也要转换
         
         [UIScreen mainScreen].scale 为1 时，就是iPhone 4之前的屏幕
         [UIScreen mainScreen].scale 为2时，就是Retina屏幕，
         */
        //normal
        CGImageRef smallImage = CGImageCreateWithImageInRect(image.CGImage, smallRect);
        [button setImage:[UIImage imageWithCGImage:smallImage] forState:UIControlStateNormal];
        //选中状态的图片
        CGImageRef smallSelected = CGImageCreateWithImageInRect(imageSelected.CGImage, smallRect);
        [button setImage:[UIImage imageWithCGImage:smallSelected] forState:UIControlStateSelected];
        //背景图片
        [button setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        button.bounds = CGRectMake(0, 0, 68, 143);
        //设置定位点(锚点) 和 位置
        button.layer.anchorPoint = CGPointMake(0.5, 1);
        button.layer.position = CGPointMake(self.centerView.frame.size.width * 0.5, self.centerView.frame.size.height * 0.5);
        //设置选中角度(绕着锚点进行旋转)
        double angle = (30.0 * i) / 180.0 * M_PI;
        button.transform = CGAffineTransformMakeRotation(angle);
        //添加点击事件
        [button addTarget:self action:@selector(p_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.centerView addSubview:button];
        
        button.tag = i;
        if (i == 0) {
            [self p_buttonClick:button];
        }
        
    }
}

#pragma mark - 按钮响应事件：修改按钮选中状态
-(void)p_buttonClick:(SGH0729Button *)button {
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

//核心动画不会改图层的属性
-(void)startAnimation {
    if (self.link) {
        return;
    }
    //1秒刷新60次
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(p_update)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
}

-(void)p_update {
    self.centerView.transform = CGAffineTransformRotate(self.centerView.transform, M_PI / 100);
    
}

-(void)stopAnimation {
    [self.link invalidate];
    self.link = nil;
}

- (IBAction)chooseNumber:(id)sender {
    [self stopAnimation];
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(2 * M_PI * 3);
    anim.duration = 2;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.delegate = self;
    [self.centerView.layer addAnimation:anim forKey:nil];
    
    self.userInteractionEnabled = NO;
    
}

#pragma  mark - Animation Delegate
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.userInteractionEnabled = YES;
    //选中的图片居中
    self.centerView.transform = CGAffineTransformMakeRotation(- (self.selectedButton.tag * M_PI / 6));
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startAnimation];
    });
}


@end
