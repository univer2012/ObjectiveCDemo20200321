//
//  FKGeometryView.m
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/11/27.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "FKGeometryView.h"

@implementation FKGeometryView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//重写该方法进行绘图
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取绘图上下文
    CGContextSetLineWidth(ctx, 16); //设置线宽
    CGContextSetRGBStrokeColor(ctx, 0, 1, 0, 1);

    //------下面绘制3个线段测试端点形状-----
    //定义4个点，绘制线段
    const CGPoint points1[] = {CGPointMake(10, 40), CGPointMake(100, 40), CGPointMake(100, 40), CGPointMake(20, 70)}; //定义4个点，绘制线段
    CGContextStrokeLineSegments(ctx, points1, 4);//绘制线段（默认不绘制断点）
    CGContextSetLineCap(ctx, kCGLineCapSquare);//设置线段的断点形状：方形端点

    const CGPoint points2[] = {CGPointMake(120, 88), CGPointMake(200, 88), CGPointMake(200, 88), CGPointMake(130, 118)};     //定义4个点，绘制线段
    CGContextStrokeLineSegments(ctx, points2, 4);
    CGContextSetLineCap(ctx, kCGLineCapRound);

    const CGPoint points3[] = {CGPointMake(230, 20), CGPointMake(300, 20), CGPointMake(300, 20), CGPointMake(240, 50)};
    CGContextStrokeLineSegments(ctx, points3, 4);
    CGContextSetLineCap(ctx, kCGLineCapButt);

    //------下面绘制3个线段测试点线模式-----
    CGContextSetLineWidth(ctx, 10);
    
    //设置点线模式：实现宽6，间距宽10
    CGFloat patterns1[] = {6, 10};
    CGContextSetLineDash(ctx, 0, patterns1, 1);
    const CGPoint points4[] = {CGPointMake(40, 65), CGPointMake(280, 65)};
    CGContextStrokeLineSegments(ctx, points4, 2);

    //设置点线模式：实线宽6，间距宽10，但第1个实线宽为3
    CGContextSetLineDash(ctx, 3, patterns1, 1);
    const CGPoint points5[] = {CGPointMake(40, 85), CGPointMake(280, 85)};
    CGContextStrokeLineSegments(ctx, points5, 2);//绘制线段


    CGFloat patterns2[] = {5, 1, 4, 1, 3, 1, 2, 1, 1, 1, 1, 2, 1, 3, 1, 4, 1, 5};
    CGContextSetLineDash(ctx, 0, patterns2, 18);
    const CGPoint points6[] = {CGPointMake(40, 105), CGPointMake(280, 105)};
    CGContextStrokeLineSegments(ctx, points6, 2);

    //-----下面填充矩形-----
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);    //设置填充颜色
    CGContextFillRect(ctx, CGRectMake(30, 120, 120, 60));//填充一个矩形

    CGContextSetFillColorWithColor(ctx, [UIColor yellowColor].CGColor); //设置填充颜色
    CGContextFillRect(ctx, CGRectMake(80, 160, 120, 60));//填充一个矩形

    //-----下面绘制矩形边框-----

    CGContextSetLineDash(ctx, 0, 0, 0);//取消设置点线模式
    CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);  //设置线条颜色
    CGContextSetLineWidth(ctx, 14);     //设置线条宽度
    CGContextStrokeRect(ctx, CGRectMake(30, 230, 120, 60));//绘制一个矩形边框


    //-----下面绘制 和 填充一个椭圆 -----

    CGContextSetRGBStrokeColor(ctx, 0, 1, 1, 1);//设置线条颜色
    CGContextStrokeEllipseInRect(ctx, CGRectMake(30, 380, 120, 60)); //绘制一个椭圆

    CGContextSetRGBFillColor(ctx, 1, 0, 1, 1);//设置填充颜色
    CGContextFillEllipseInRect(ctx, CGRectMake(180, 380, 120, 60));  //填充一个椭圆

}


@end
