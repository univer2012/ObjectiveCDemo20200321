//
//  SHSocketStruc0218ViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/2/18.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHSocketStruc0218ViewController.h"



/** socket  */
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@interface SHSocketStruc0218ViewController ()

@end

@implementation SHSocketStruc0218ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self socketDemo];
    
    
}
#pragma mark - sokect 演练
- (void)socketDemo {
    //1. 创建Socket
    /** 参数
     */
    
    /**
     参数

     @param domain: 协议域，AF_INET  -->IPV4
     @param type:   Socket 类型，SOCK_STREAM(流) TCP/SOCK_DGRAM(报文 UDP)
     @param protocol:  IPPROTO_TCP，如果传入0，会自动根据第二个参数，选择合适的协议
     @return 返回值  socket > 0，就是成功
     */
    int clientSockt = socket(AF_INET, SOCK_STREAM, 0);
    //2.连接到服务器
    /** 参数
     1> 客户端socket
     2> 指向数据结构sockaddr的指针，期中包括目的端口和IP地址
     3> 结构体数据长度
     返回值
     0 成功/其他  错误代号
     */
    struct sockaddr_in serverAddr;
    serverAddr.sin_family = AF_INET;
    //端口
    /** 运行完下一句代码后，查看端口号是`20480`，原因是：将二进制的最高位和低位进行了一个互换。这是个常识问题，因为在网络传输过程中，高位和低位与我们平时开发中的进制表是不一样的，  */
    serverAddr.sin_port = htons(12345);//htons(80);
    //IP地址
    /** 查看s_addr的值变为了 `16777343`。真正在网络中的显示的ip地址是这个`16777343`  */
    serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    /** 第2个参数传`&serverAddr`时，会报警告，此时要进行强制转换:`(const struct sockaddr *)&serverAddr`  */
    /** 在c语言开发中，经常传递一个数据结构体的指针，同时需要你传入结构的长度。  */
    int connResult = connect(clientSockt , (const struct sockaddr *)&serverAddr, sizeof(serverAddr));
    if (connResult == 0) {
        NSLog(@"连接成功");
    } else {
        NSLog(@"失败 %d",connResult);
        return;
    }
    //3.发送数据到服务器
    /** 参数
     1> 客户端socket
     2> 发送内容地址
     3> 发送内容长度
     4> 发送方式标志，一般为0
     返回值
     如果成功，则返回发送的字节数，失败则返回SOCKET_ERROR*/
    NSString *sendMsg = @"Hello";
    ssize_t sendLen = send(clientSockt, sendMsg.UTF8String, strlen(sendMsg.UTF8String), 0);
    NSLog(@"发送了%ld 个字节",sendLen);
    
    //4.从服务器接收数据
    /** 参数
     1> 客户端socket
     2> 接受内容缓冲区地址，  需要提前准备
     3> 接收内容缓冲区长度
     4> 接收方式，0表示阻塞，必须等待服务器返回数据
     返回值
     如果成功，则返回读入的字节数，失败则返回SOCKET_ERROR
     */
    uint8_t buffer[1024];//把空间先准备好
    ssize_t recvLen = recv(clientSockt, buffer, sizeof(buffer), 0);
    NSLog(@"接收了 %ld 个字节",recvLen);
    
    //获取服务器返回的数据，从缓冲区中读取recvLen 个字节！
    NSData *data = [NSData dataWithBytes:buffer length:recvLen];
    //转换成字符串
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", str);
    
    
    //5.断开连接
    /**
     长连接：连上就一直聊！通常用于QQ，即时通讯，效率很高！(一对一)
     短连接：通讯一次，马上断开，下次再次建立连接，效率低！(一对多)
     */
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
