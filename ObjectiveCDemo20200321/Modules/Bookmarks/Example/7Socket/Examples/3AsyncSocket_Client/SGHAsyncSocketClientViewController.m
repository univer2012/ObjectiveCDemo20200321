//
//  SGHAsyncSocketClientViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/26.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 来自：[iOS GCDAsyncSocket简单使用](https://www.jianshu.com/p/539876f5983c)
 */

#import "SGHAsyncSocketClientViewController.h"
#import <GCDAsyncSocket.h>


@interface SGHAsyncSocketClientViewController ()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *socket;

@property (weak, nonatomic) IBOutlet UITextField *sendMsgContent_tf;


@property (nonatomic, strong) NSMutableData *cacheData;

@end

@implementation SGHAsyncSocketClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 连接socket
///连接socket
- (IBAction)didClickConnectSocket:(id)sender {
    // 创建socket
    if (self.socket == nil)
        // 并发队列，这个队列将影响delegate回调,但里面是同步函数！保证数据不混乱，一条一条来
        // 这里最好是写自己并发队列
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    // 连接socket
    if (!self.socket.isConnected){
        NSError *error;
        [self.socket connectToHost:@"127.0.0.1" onPort:8040 withTimeout:-1 error:&error];
        if (error) NSLog(@"%@",error);
    }
}

///5.发送消息
- (IBAction)didClickSendAction:(id)sender {
    NSString *msgText = self.sendMsgContent_tf.text;
    if (msgText.length == 0) {
        return;
    }
    NSData *data = [msgText dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:-1 tag:10086];
}

///6.重连
- (IBAction)didClickReconnectAction:(id)sender {
    // 创建socket
    if (self.socket == nil)
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    // 连接socket
    if (!self.socket.isConnected){
        NSError *error;
        [self.socket connectToHost:@"127.0.0.1" onPort:8040 withTimeout:-1 error:&error];
        if (error) NSLog(@"%@",error);
    }
}

///7.关闭socket
- (IBAction)didClickCloseAction:(id)sender {
    [self.socket disconnect];
    self.socket = nil;
}

//MARK: GCDAsyncSocketDelegate
//已经连接到服务器
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(nonnull NSString *)host port:(uint16_t)port {
    NSLog(@"连接成功 : %@---%d",host,port);
    //连接成功或者收到消息，必须开始read，否则将无法收到消息,
    //不read的话，缓存区将会被关闭
    // -1 表示无限时长 ,永久不失效
    [self.socket readDataWithTimeout:-1 tag:10086];
}

// 连接断开
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"断开 socket连接 原因:%@",err);
}

//已经接收服务器返回来的数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"接收到tag = %ld : %ld 长度的数据",tag,data.length);
    
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"接收到的内容为：%@", str);
    //连接成功或者收到消息，必须开始read，否则将无法收到消息
    //不read的话，缓存区将会被关闭
    // -1 表示无限时长 ， tag
    [self.socket readDataWithTimeout:-1 tag:10086];
}

//消息发送成功 代理函数 向服务器 发送消息
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"%ld 发送数据成功",tag);
}



//MARK: 粘包和分包的 处理方式：
/// 在数据包头部加上内容长度以及数据类型

///1.发送数据
#pragma mark - 发送数据格式化
- (void)sendData:(NSData *)data dataType:(unsigned int)dataType{
    NSMutableData *mData = [NSMutableData data];
    // 1.计算数据总长度 data
    unsigned int dataLength = 4+4+(int)data.length;
    // 将长度转成data
    NSData *lengthData = [NSData dataWithBytes:&dataLength length:4];
    // mData 拼接长度data
    [mData appendData:lengthData];
    
    // 数据类型 data
    // 2.拼接指令类型(4~7:指令)
    NSData *typeData = [NSData dataWithBytes:&dataType length:4];
    // mData 拼接数据类型data
    [mData appendData:typeData];
    
    // 3.最后拼接真正的数据data
    [mData appendData:data];
    NSLog(@"发送数据的总字节大小:%ld",mData.length);
    
    // 发数据
    [self.socket writeData:mData withTimeout:-1 tag:10086];
}

//2.接收数据
//- (void)recvData:(NSData *)data{
//    //直接就给他缓存起来
//    [self.cacheData appendData:data];
//    // 获取总的数据包大小
//    // 整段数据长度(不包含长度跟类型)
//    NSData *totalSizeData = [data subdataWithRange:NSMakeRange(0, 4)];
//    unsigned int totalSize = 0;
//    [totalSizeData getBytes:&totalSize length:4];
//    //包含长度跟类型的数据长度
//    unsigned int completeSize = totalSize  + 8;
//    //必须要大于8 才会进这个循环
//    while (self.cacheData.length>8) {
//        if (self.cacheData.length < completeSize) {
//            //如果缓存的长度 还不如 我们传过来的数据长度，就让socket继续接收数据
//            [self.socket readDataWithTimeout:-1 tag:10086];
//            break;
//        }
//        //取出数据
//        NSData *resultData = [self.cacheData subdataWithRange:NSMakeRange(8, completeSize)];
//        //处理数据
//        [self handleRecvData:resultData];
//        //清空刚刚缓存的data
//        [self.cacheData replaceBytesInRange:NSMakeRange(0, completeSize) withBytes:nil length:0];
//        //如果缓存的数据长度还是大于8，再执行一次方法
//        if (self.cacheData.length > 8) {
//            [self recvData:nil];
//        }
//    }
//}

@end
