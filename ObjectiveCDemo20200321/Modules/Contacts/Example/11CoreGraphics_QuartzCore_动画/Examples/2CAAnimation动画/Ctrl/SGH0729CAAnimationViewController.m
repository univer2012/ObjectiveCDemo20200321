//
//  SGH0729CAAnimationViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/7/29.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0729CAAnimationViewController.h"

@interface SGH0729CAAnimationViewController ()

@property(nonatomic, strong)CALayer *layer;

@end

@implementation SGH0729CAAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *	@author hsj, 16-07-29 12:07:46
     *
     *	CAAnimation:
     1.基础动画CABasicAnimation
     2.关键帧动画 CAKeyframeAnimation
     3.转场动画 CATransition
     4.动画组 CAAnimationGroup
     *	
     CABasicAnimation 和 CAKeyframeAnimation 基础属性动画，即隐性动画，
    凡是有Animatable词修饰的就是隐性动画
     转场动画可以用于不同图片之间的切换，
     */
    
    
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(100, 100);
    layer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //[self animationScale];
    [self keyAnimation];
}

//基础动画
-(void)animationScale {
    //1.创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    //2.设置动画：keyPath 决定了执行怎样的动画  keyPath类型是字符串类型
    /**
     *	bounds  缩放
     position 平移
     transform 旋转
     */
#if 0
    // 缩放
    //@"bounds"就是根据边界来进行缩放
    anim.keyPath = @"bounds";
    // toValue 是到达哪个点，byValue是增加多少值，fromValue从哪个点开始移动
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 50, 50)];
#elif 0
    //平移
    anim.keyPath = @"position";
    anim.byValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
#elif 1
    //旋转
    anim.keyPath = @"transform";
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4, 1, 1, 0)];
    //(M_PI_4, 1, 1, 0)   沿着x轴和 y轴旋转 45°
#endif
    //设置动画所持续的时间
    anim.duration = 2;
    //动画执行完毕后是否删除动画
    anim.removedOnCompletion = NO;
    //动画的状态 字符串类型
    anim.fillMode = @"forwards";
    
    //3.添加动画
    /**
     *	@author hsj, 16-07-29 13:07:48
     *
     *	第一个参数：所执行的动画
     第二个参数：标志这个动画
     */
    [self.layer addAnimation:anim forKey:nil];
    
    
    /**
     *	@author hsj, 16-07-29 13:07:24
     *
     *	首先是keyPath执行了怎样的动画，第二个是toValue这个属性。
     除了缩放，还有旋转和平移属性，只需要改变keyPath和toValue就可以了
     *	@return
     */
}



//关键帧动画
-(void)keyAnimation {
    
    /**
     *	position  平移
     */
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim.removedOnCompletion = NO;
    /**
     *	kCAFillModeForwards     保持最新的状态
     */
    anim.fillMode = kCAFillModeForwards;
    anim.duration = 2;
    
    //要让图形沿着圆形运动的话，要画圆形的路径
    //创建一个可变路径
    CGMutablePathRef path = CGPathCreateMutable();
    /**
     *	@param path			可变路径
     *	@param m   进行变换的变换矩阵
     *	@param rect  椭圆的矩形范围
     *	@return
     */
    CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 100, 200, 200));
    anim.path = path;
    CGPathRelease(path);
    //设置动画的执行节奏
    /**
     *	kCAMediaTimingFunctionEaseInEaseOut 刚开始比较慢，中间加速，结束时又会变慢
     kCAMediaTimingFunctionEaseIn 开始比较慢，然后比较快
     */
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //在关键帧动画中也可以谁知代理对象。设置代理对象后可以执行代理方法，通过代理方法来执行一些操作。
    anim.delegate = self;
    [self.layer addAnimation:anim forKey:nil];
    //在关键帧动画中，动画的持续时间，是否删除动画，以及填充模式，与基本动画是一样的，姿势在关键帧动画中，可以设置动画的执行节奏，而且也可以设置代理方法，
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
