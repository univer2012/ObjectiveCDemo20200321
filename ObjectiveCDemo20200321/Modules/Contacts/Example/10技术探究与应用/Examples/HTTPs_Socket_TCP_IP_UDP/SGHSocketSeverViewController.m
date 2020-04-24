//
//  SGHSocketSeverViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/9.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[iOS中 HTTP/Socket/TCP/IP通信协议详解 韩俊强的博客](https://blog.csdn.net/qq_31810357/article/details/50419437)
*/
#import "SGHSocketSeverViewController.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>
#import "SGHSocket.h"

@interface SGHSocketSeverViewController ()

@property (weak, nonatomic) IBOutlet UITextField *portTF;   // 端口号

@property (weak, nonatomic) IBOutlet UITextField *contentTF;// 内容

@property (weak, nonatomic) IBOutlet UITextView *message;   // 多行文本输入框

@property (nonatomic, strong) GCDAsyncSocket *serverSocket; // 服务器socket

@property (nonatomic, strong) GCDAsyncSocket *clientSocket; // 为客户端生成的socket

@end

@implementation SGHSocketSeverViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //////// 服务端 ////////
    
    [_message scrollRangeToVisible:NSMakeRange(_message.text.length, 1)];
    _message.layoutManager.allowsNonContiguousLayout = NO;
}

// 服务端监听某个端口
- (IBAction)listen:(UIButton *)sender
{
    // 1. 创建服务器socket
    self.serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    // 2. 开放哪些端口
    NSError *error = nil;
    BOOL result = [self.serverSocket acceptOnPort:self.portTF.text.integerValue error:&error];
    
    // 3. 判断端口号是否开放成功
    if (result) {
        [self addText:@"端口开放成功"];
    } else {
        [self addText:@"端口开放失败"];
    }
    [self hidTheKeyword];
}

#pragma mark - GCDAsyncSocketDelegate
// 当客户端链接服务器端的socket, 为客户端单生成一个socket
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    [self addText:@"链接成功"];
    //IP: newSocket.connectedHost
    //端口号: newSocket.connectedPort
    [self addText:[NSString stringWithFormat:@"链接地址:%@", newSocket.connectedHost]];
    [self addText:[NSString stringWithFormat:@"端口号:%hu", newSocket.connectedPort]];
    // short: %hd
    // unsigned short: %hu
    
    // 存储新的端口号
    self.clientSocket = newSocket;
}

// 服务端接收到消息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self addText:message];
}

// 发送
- (IBAction)sendMessage:(UIButton *)sender
{
    NSData *data = [self.contentTF.text dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:-1 tag:0];
    
    SGHSocket *socket = [SGHSocket defaultSocket];
    [socket.mySocket readDataWithTimeout:-1 tag:0];
}

// 接收消息
- (IBAction)receiveMassage:(UIButton *)sender
{
    [self.clientSocket readDataWithTimeout:-1 tag:0];
    [self hidTheKeyword];
}

// textView填写内容
- (void)addText:(NSString *)text
{
    self.message.text = [self.message.text stringByAppendingFormat:@"%@\n", text];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hidTheKeyword];
}

// hiddenKeyword
- (void)hidTheKeyword
{
    [self.contentTF resignFirstResponder];
    [self.portTF resignFirstResponder];
    [self.message endEditing:YES];
}

@end
