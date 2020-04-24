//
//  SGHSocketClientViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/9.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 * 来自：[iOS中 HTTP/Socket/TCP/IP通信协议详解 韩俊强的博客](https://blog.csdn.net/qq_31810357/article/details/50419437)
 */
#import "SGHSocketClientViewController.h"
#import <GCDAsyncSocket.h>
#import "SGHSocket.h"

@interface SGHSocketClientViewController ()

@property (weak, nonatomic) IBOutlet UITextField *addressTF;

@property (weak, nonatomic) IBOutlet UITextField *portTF;

@property (weak, nonatomic) IBOutlet UITextField *message;

@property (weak, nonatomic) IBOutlet UITextView *content;  // 多行文本输入

@property (nonatomic, strong) GCDAsyncSocket *socket;

@end

@implementation SGHSocketClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //////// 客户端 ////////
    
    [_content scrollRangeToVisible:NSMakeRange(_content.text.length, 1)];
    _content.layoutManager.allowsNonContiguousLayout = NO;
}

// 和服务器进行链接
- (IBAction)connect:(UIButton *)sender
{
    // 1. 创建socket
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    // 2. 与服务器的socket链接起来
    NSError *error = nil;
    BOOL result = [self.socket connectToHost:self.addressTF.text onPort:self.portTF.text.integerValue error:&error];
    
    // 3. 判断链接是否成功
    if (result) {
        [self addText:@"客户端链接服务器成功"];
    } else {
        [self addText:@"客户端链接服务器失败"];
    }
    [self hidTheKeyword];
}

// 接收数据
- (IBAction)receiveMassage:(UIButton *)sender
{
    [self.socket readDataWithTimeout:-1 tag:0];
    [self hidTheKeyword];
}

// 发送消息
- (IBAction)sendMassage:(UIButton *)sender
{
    NSData *data = [self.message.text dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:-1 tag:0];
    
    SGHSocket *socket = [SGHSocket defaultSocket];
    [socket.mySocket readDataWithTimeout:-1 tag:0];
    [self hidTheKeyword];
}

#pragma mark - GCDAsyncSocketDelegate
// 客户端链接服务器端成功, 客户端获取地址和端口号
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    [self addText:[NSString stringWithFormat:@"链接服务器%@", host]];
    
    SGHSocket *socket = [SGHSocket defaultSocket];
    socket.mySocket = self.socket;
}

// 客户端已经获取到内容
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self addText:content];
}

// textView填写内容
- (void)addText:(NSString *)text
{
    self.content.text = [self.content.text stringByAppendingFormat:@"%@\n", text];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hidTheKeyword];
}

// hiddenKeyword
- (void)hidTheKeyword
{
    [self.addressTF resignFirstResponder];
    [self.portTF resignFirstResponder];
    [self.message resignFirstResponder];
    [self.content endEditing:YES];
}

@end
