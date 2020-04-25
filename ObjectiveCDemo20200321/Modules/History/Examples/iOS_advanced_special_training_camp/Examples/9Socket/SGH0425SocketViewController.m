//
//  SGH0425SocketViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/25.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGH0425SocketViewController.h"

unsigned int VA_IMAGE_TYPE = 4;

@interface SGH0425SocketViewController ()

@end

@implementation SGH0425SocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)sendImage {
    //数据流 --- 是什么格式？  二进制
    UIImage *image = [UIImage imageNamed:@"WZLBadgeLogo"];
    NSData *imageData = UIImagePNGRepresentation(image);
    
    //1、定义数据格式
    NSMutableData *totalData = [NSMutableData data];
    
    //2、拼接总长度
    unsigned int totalSize = 4 + 4 +(int)imageData.length;
    NSData *totalSizeData = [NSData dataWithBytes:&totalSize length:4];
    [totalData appendData:totalSizeData];
    
    //3、拼接指令长度
    unsigned int commandID = VA_IMAGE_TYPE;
    NSData *commandIDData = [NSData dataWithBytes:&commandID length:4];
    [totalData appendData:commandIDData];
    
    //4、拼接图片
    [totalData appendData:imageData];
    
}

@end
