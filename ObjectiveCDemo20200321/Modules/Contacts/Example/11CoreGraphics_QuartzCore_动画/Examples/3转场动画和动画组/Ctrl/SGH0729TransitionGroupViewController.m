//
//  SGH0729TransitionGroupViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/7/29.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0729TransitionGroupViewController.h"
//第二个控制器
#import "SGH0729TransitionGroupSecondViewController.h"

#define isAnimationGroup 1

@interface SGH0729TransitionGroupViewController ()

@property(nonatomic, strong)CALayer *layer;

- (IBAction)exchangeView;
- (IBAction)pushAction;
@property (weak, nonatomic) IBOutlet UIView *animationView;

@end

@implementation SGH0729TransitionGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
#if isAnimationGroup
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(100, 100);
    layer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
#endif
    
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

//交换视图
- (IBAction)exchangeView {
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //接下来就是交换视图所特有的属性type，type就是进行转场动画实现的类型，合法的动画类型有`fade', `moveIn', `push' and `reveal'. 默认是`fade'
    //@"pageCurl"是私有API，当使用私有API时要慎重，有一些是苹果官方所承认的API，比如这里用到的‘pageCurl’，对于这些所有的当然是可以用的。但是有一些苹果官方并不承认的API在iOS上使用的时候就要慎重，
    /**
     *	@"pageCurl"   翻页效果
     fade       渐进消失
     */
    transition.type = @"fade";
    
    //subtype 子类型，这个属性所定义的是转换的方向，合法的值有`fromLeft', `fromRight', `fromTop' and `fromBottom'
    transition.subtype = kCATransitionFromRight;
    //可以 这样写：kCATransitionFromRight 也可以这样写： @"formRight"
    //设置具体的动画
    //在视图中，有一个方法 -exchangeSubviewAtIndex:withSubviewAtIndex:，用来调换其子视图的位置
    [_animationView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    /**
     *	key  用来指定唯一的动画
     */
    [_animationView.layer addAnimation:transition forKey:@"myAnimation"];
    
    /*
     备注：这个 _animationView父视图要和 交换的2个子视图 frame一样，不然交换会比较奇怪
     */
}
//页面跳转
- (IBAction)pushAction {
    //首先这些属性的设置都是一样的，
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //所不一样的是它转场动画的类型，
    /**
     *	cube   私有API,立体动画效果
     */
    transition.type = @"cube";
    
    //添加动画时，并不是添加到视图的图层上，而是添加到导航控制器的图层上
    /**
     *	key     用来标示唯一的动画，一定要与之前所有的动画的标示不一样
     */
    [self.navigationController.view.layer addAnimation:transition forKey:@"navAnimation"];
    
    //初始化视图控制器
    SGH0729TransitionGroupSecondViewController *detailVC = [[SGH0729TransitionGroupSecondViewController alloc] init];
    [self.navigationController showViewController:detailVC sender:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self animationScale];
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
    //设置动画所持续的时间
    anim.duration = 2;
    //动画执行完毕后是否删除动画
    anim.removedOnCompletion = NO;
    //动画的状态 字符串类型
    anim.fillMode = @"forwards";
    
    anim.keyPath = @"transform";
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4, 1, 1, 0)];
    
#if isAnimationGroup
    //==================  =================  =================
    //最后一种类型为组动画
    /*
     在基础动画中可以创建一个组动画。初始化方法只有一种[CAAnimationGroup animation]，而所拥有的属性也只有一个:
     @property(nullable, copy) NSArray<CAAnimation *> *animations;
     
    */
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    //将所执行的动画放到数组中，那么就会依次执行每一个具体的动画，然后再将组动画添加到图层上
    animGroup.animations = @[anim];
    [self.layer addAnimation:animGroup forKey:nil];
#else
    
    //3.添加动画
    /**
     *	@author hsj, 16-07-29 13:07:48
     *
     *	第一个参数：所执行的动画
     第二个参数：标志这个动画
     */
    [self.layer addAnimation:anim forKey:nil];
    
#endif
    
    
    
}











@end
