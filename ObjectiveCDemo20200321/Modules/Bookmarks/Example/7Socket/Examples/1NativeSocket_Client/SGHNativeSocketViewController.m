//
//  SGHNativeSocketViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/25.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 来自：[iOS 用原生代码写一个简单的socket连接](https://www.jianshu.com/p/a019b582204a)
 */
#import "SGHNativeSocketViewController.h"

#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

//htons : 将一个无符号短整型的主机数值转换为网络字节顺序，不同cpu 是不同的顺序 (big-endian大尾顺序 , little-endian小尾顺序)
#define SocketPort htons(8040) //端口
//inet_addr是一个计算机函数，功能是将一个点分十进制的IP转换成一个长整数型数
#define SocketIP   inet_addr("127.0.0.1") // ip

@interface SGHNativeSocketViewController ()

//属性，用于接收socket创建成功后的返回值
@property (nonatomic, assign) int clinenId;
@property (weak, nonatomic) IBOutlet UITextField *sendMsgContent_tf;

@end

@implementation SGHNativeSocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 创建socket建立连接
- (IBAction)socketConnetAction:(UIButton *)sender {
    
    // 1: 创建socket
    int socketID = socket(AF_INET, SOCK_STREAM, 0);
    self.clinenId= socketID;
    if (socketID == -1) {
        NSLog(@"创建socket 失败");
        return;
    }
    
    // 2: 连接socket
    struct sockaddr_in socketAddr;
    socketAddr.sin_family = AF_INET;
    socketAddr.sin_port   = SocketPort;
    struct in_addr socketIn_addr;
    socketIn_addr.s_addr  = SocketIP;
    socketAddr.sin_addr   = socketIn_addr;
    
    int result = connect(socketID, (const struct sockaddr *)&socketAddr, sizeof(socketAddr));

    if (result != 0) {
        NSLog(@"连接失败");
        return;
    }
    NSLog(@"连接成功");
    
    // 调用开始接受信息的方法
    // while 如果主线程会造成堵塞
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self recvMsg];
    });
    
}


#pragma mark - 发送消息

- (IBAction)sendMsgAction:(id)sender {
    //3: 发送消息
    if (self.sendMsgContent_tf.text.length == 0) {
        return;
    }
    const char *msg = self.sendMsgContent_tf.text.UTF8String;
    ssize_t sendLen = send(self.clinenId, msg, strlen(msg), 0);
    NSLog(@"发送 %ld 字节",sendLen);
}

#pragma mark - 接受数据
- (void)recvMsg{
    // 4. 接收数据
    while (1) {
        uint8_t buffer[1024];
        ssize_t recvLen = recv(self.clinenId, buffer, sizeof(buffer), 0);
        NSLog(@"接收到了:%ld字节",recvLen);
        if (recvLen == 0) {
            continue;
        }
        // buffer -> data -> string
        NSData *data = [NSData dataWithBytes:buffer length:recvLen];
        NSString *str= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@---%@",[NSThread currentThread],str);
    }
}

@end
