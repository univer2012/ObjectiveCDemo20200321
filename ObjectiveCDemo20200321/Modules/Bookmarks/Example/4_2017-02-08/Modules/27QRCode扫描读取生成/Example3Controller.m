//
//  Example3Controller.m
//  QRCode二维码
//
//  Created by huangaengoln on 15/11/9.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "Example3Controller.h"

@interface Example3Controller ()
@property(nonatomic,strong)UITextField *tfCode;
@property(nonatomic,strong)UIButton *btnGenerate;
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation Example3Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGSize windowSize=[UIScreen mainScreen].bounds.size;
    CGFloat viewTop = 100;
    //输入框
    self.tfCode=[[UITextField alloc]initWithFrame:CGRectMake(10, viewTop, windowSize.width-100, 40)];
    [self.view addSubview:self.tfCode];
    self.tfCode.borderStyle=UITextBorderStyleRoundedRect;
    //“生成”按钮
    self.btnGenerate=[[UIButton alloc]initWithFrame:CGRectMake(windowSize.width-100, viewTop, 90, 40)];
    [self.view addSubview:self.btnGenerate];
    [self.btnGenerate addTarget:self action:@selector(actionGenerate) forControlEvents:UIControlEventTouchUpInside];
    self.btnGenerate.backgroundColor=[UIColor lightGrayColor];
    [self.btnGenerate setTitle:@"生成" forState:UIControlStateNormal];
    [self.btnGenerate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //二维码 图片
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, viewTop + 50, 300, 300)];
    [self.view addSubview:self.imageView];
    self.imageView.center=CGPointMake(windowSize.width/2, windowSize.height/2);
    self.tfCode.text=@"http://adad184.com";
    
}
-(void)actionGenerate {
    NSString *text=self.tfCode.text;
    NSData *stringData=[text dataUsingEncoding:NSUTF8StringEncoding];
    //生成
    CIFilter *qrFilter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    UIColor *onColor=[UIColor blackColor];//[UIColor redColor];
    UIColor *offColor=[UIColor whiteColor];//[UIColor blueColor];
    //上色
    CIFilter *colorFilter=[CIFilter filterWithName:@"CIFalseColor" keysAndValues:
                           @"inputImage",qrFilter.outputImage,
                           @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
                           @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor], nil];
    CIImage *qrImage=colorFilter.outputImage;
    //绘制
    CGSize size=CGSizeMake(300, 300);
    CGImageRef cgImage=[[CIContext contextWithOptions:nil]createCGImage:qrImage fromRect:qrImage.extent];
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    self.imageView.image=codeImage;
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
