//
//  SGH0728CALayerViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/7/28.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#import "SGH0728CALayerViewController.h"

#import "SGH0729Layer.h"

@interface SGH0728CALayerViewController ()



@end

@implementation SGH0728CALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    /*自定义图层的方法，集成子类CALayer。
     在自定义的实现文件中，实现 drawInContext: 方法
     */
    
//    [self initImageView];
//    [self setupCALayer];
    
    [self setupCustomLayer];
    
    //第二种自定义图层的方法，是在控制器中设置代理，实现代理方法来画图层，
    
}

#pragma mark - CALayer的代理方法
//在这个代理方法中来绘制图层
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    //设置颜色
    CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
    //在视图上画一个圆形（通过画椭圆，将宽高设置成一样的）
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, 100, 100));
    //将圆形画到视图上
    CGContextFillPath(ctx);
}



#pragma mark - 创建方法


-(void)setupCustomLayer {
    /**
     *	@author hsj, 16-07-29 10:07:32
     *
     *	 自定义图层的方法
     1.建子类继承于CALayer，实现 drawInContext: 方法
     2.在控制器中设置代理，实现代理方法来画图层
     */
    
    
    SGH0729Layer *layer = [SGH0729Layer layer];
    //设置图层的大小
    layer.bounds = CGRectMake(0, 0, 300, 300);
    //图层的锚点(定位点)
    layer.anchorPoint = CGPointMake(0, 0);
    //这个代理比较特殊的是，不用写代理协议，任何对象都可以作为代理
    layer.delegate = self;
    [self.view.layer addSublayer:layer];
    //到这里为止，运行，圆形并没有显示出来，原因是因为，在绘画实例中讲过，对于drawInContext: 方法，当绘画内容发生改变的时候，一定要调用 -setNeedsDisplay 这个方法，
    //必须调用这个方法，layer才会显示
    [layer setNeedsDisplay];
    
}

//创建图层
-(void) setupCALayer {
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    
    
    CALayer *layer = [CALayer layer];
    //背景颜色
    layer.backgroundColor = [UIColor grayColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    //在这里着重讲一下position和 anchorPoint的区别，
    /*
     position 设置CALayer在父图层中的位置，以父层的左上角为原点(0, 0)
     anchorPoint 锚点(定位点)  决定CALayer的哪个点在position属性所指的位置，以自己的左上角为原点(0, 0) ，默认值(0.5, 0.5),x~y取值是0~1，右下角(1, 1)
     anchorPoint的作用，主要是用来定位
     */
    layer.position = CGPointMake(200, 200);
    layer.anchorPoint = CGPointMake(0, 1);
    
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"ic_0728_calayer1"].CGImage);
    [self.view.layer addSublayer:layer];
    
}


-(void)initImageView {
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_0728_calayer1"]];
    imageView.frame = CGRectMake((kScreenWidth - 200) / 2, (kScreenHeight - 200) / 2, 200, 200);
    [self.view addSubview:imageView];
    //1.设置阴影
    imageView.layer.shadowColor = [UIColor yellowColor].CGColor;
    //2.阴影的偏移大小
    imageView.layer.shadowOffset = CGSizeMake(10, 10);
    //3.不透明度
    imageView.layer.shadowOpacity = 0.5;
    
    //4.设置圆角的大小
    imageView.layer.cornerRadius = 10;  //设置圆角的半径为10
    imageView.layer.masksToBounds = YES;    //强制内部的所有子层，支持圆角效果，少了这个设置，UIImageView是不会有圆角效果的，设置之后，没有阴影效果
    
    //5.设置边框
    imageView.layer.borderWidth = 5;
    imageView.layer.borderColor = [UIColor redColor].CGColor;
    
    //6.设置旋转、缩放
    /*
     //旋转
     CATransform3D CATransform3DMakeRotation (CGFloat angle, CGFloat x,
     CGFloat y, CGFloat z)
     //缩放
     CATransform3D CATransform3DMakeScale (CGFloat sx, CGFloat sy,
     CGFloat sz)
     //平移
     CATransform3D CATransform3DMakeTranslation (CGFloat tx,
     CGFloat ty, CGFloat tz)
     //转换
     CATransform3D CATransform3DMakeAffineTransform (CGAffineTransform m)
     */
    
    //imageView.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    //CATransform3DMakeRotation(M_PI_4, 1, 1, 0) 就是沿着x轴和y轴进行旋转
    //CATransform3DMakeRotation(M_PI_4, 0, 0, 1) 沿着z轴旋转
    
    //imageView.layer.transform = CATransform3DMakeScale(0, 1, 0);
    //x轴变为0.5倍，y轴变为1倍，z轴变为0倍
    
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
