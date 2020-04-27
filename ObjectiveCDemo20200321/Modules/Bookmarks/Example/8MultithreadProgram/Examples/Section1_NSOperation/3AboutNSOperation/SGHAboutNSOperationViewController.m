//
//  SGHAboutNSOperationViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/3/22.
//  Copyright © 2020 远平. All rights reserved.
//
/**
 * 本demo来自：
[iOS多线程NSOperation](https://blog.csdn.net/sevenquan/article/details/50403542)
*/
#import "SGHAboutNSOperationViewController.h"

@interface SGHAboutNSOperationViewController ()
//NSOperation操作队列
@property(nonatomic,strong)NSOperationQueue *queue;
@property (weak, nonatomic) IBOutlet UIButton *demo6Button;
@property (weak, nonatomic) IBOutlet UIButton *demo5Button;
@property (weak, nonatomic) IBOutlet UIButton *demo4Button;
@property (weak, nonatomic) IBOutlet UIButton *demo3Button;
@property (weak, nonatomic) IBOutlet UIButton *demo2Button;
@property (weak, nonatomic) IBOutlet UIButton *demo1Button;

@end

@implementation SGHAboutNSOperationViewController

#define STATUSBAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define TABBAR_HEIGHT (([TKDeviceHelper getDeviceResoluation] == TKUIDeviceResolution_iPhoneX) ? 83 : 49)
#define NAVBAR_HEIGHT 44
#define ISIPHONEX ([TKDeviceHelper getDeviceResoluation] == TKUIDeviceResolution_iPhoneX)

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *string = @"immutableObject";
    NSString *stringCopy = [string copy];
    NSMutableString *stringMutableCopy = [string mutableCopy];
    //打印对象的内存地址
    NSLog(@"\n string: %p,\n stringCopy: %p,\n stringMutableCopy: %p", string, stringCopy, stringMutableCopy);
    //打印指针自己的内存地址 d：十进制，x：16进制
    NSLog(@"\n string: %x,\n stringCopy: %x,\n stringMutableCopy: %x", &string, &stringCopy, &stringMutableCopy);


    [self.demo6Button addTarget:self action:@selector(opDemo6) forControlEvents:UIControlEventTouchUpInside];   //「依赖关系」
    [self.demo5Button addTarget:self action:@selector(opDemo5) forControlEvents:UIControlEventTouchUpInside];   //「最大并发数」
    [self.demo4Button addTarget:self action:@selector(opDemo4) forControlEvents:UIControlEventTouchUpInside];   //「添加执行块」
    [self.demo3Button addTarget:self action:@selector(opDemo3) forControlEvents:UIControlEventTouchUpInside];   //「添加块操作」
    [self.demo2Button addTarget:self action:@selector(opDemo2) forControlEvents:UIControlEventTouchUpInside];   //「NSBlockOperation」
    [self.demo1Button addTarget:self action:@selector(opDemo1) forControlEvents:UIControlEventTouchUpInside];   //「NSInvocationOperation」

    //1.状态栏的高度
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    NSLog(@"statusBarRect: %@", NSStringFromCGRect(statusBarRect));
    //2.导航栏的高度
    CGFloat naviBarHeight = self.navigationController.navigationBar.frame.size.height;
    NSLog(@"naviBarHeight: %f", naviBarHeight);

    //3.tabbar栏的高度
    CGFloat tabBarHeight = self.tabBarController.tabBar.bounds.size.height;
    NSLog(@"tabBarHeight: %f",tabBarHeight);
    //self.navigationController.navigationBarHidden = YES;

}



-(NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}
//MARK: 暂停挂起
//暂停操作
- (IBAction)pause:(id)sender {
    //1.判断队列汇总是否有操作
    if (self.queue.operationCount == 0) {
        NSLog(@"没有操作");
        return;
    }
    //2.如果没有被挂起(正在执行)，才需要暂停
    //只会挂起当前队列中还没有被调度（没有被安排到线程上工作的操作）才会被挂起
    if (!self.queue.isSuspended) {
        NSLog(@"暂停");
        [self.queue setSuspended:YES];
    }
    else {
        NSLog(@"已经暂停");
    }
}
//继续操作
- (IBAction)resume:(id)sender {
    //1.判断队列中是否有操作
    if (self.queue.operationCount ==  0) {
        NSLog(@"没有操作");
        return;
    }
    //2.如果有被挂起的操作，才需要继续(恢复)
    if (self.queue.isSuspended) {
        NSLog(@"继续");
        [self.queue setSuspended:NO];
    }
    else {
        NSLog(@"正在执行");
    }
}
//MARK: btn6.NSOperation指定操作之间的依赖关系
-(void)opDemo6 {


    ///MARK: 实例化storyboard里面的控制器
    //UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //SGHPushViewController *controller = [story instantiateViewControllerWithIdentifier:@"pushViewController"];
    //[self.navigationController pushViewController:controller animated:YES];

    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"正在下载苍老师全集... %@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"正在解压缩苍老师全集... %@",[NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"正在保存到磁盘... %@",[NSThread currentThread]);
    }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载完成... %@",[NSThread currentThread]);
    }];

    /*指定操作之间的”依赖“关系，某一个操作的执行，必须等待另一个操作完成才会开始
     依赖关系是可以跨队列指定的   */
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    [op4 addDependency:op3];

    // *** 添加依赖的时候，注意不要出现循环依赖
    //    [op3 addDependency:op4];

    [self.queue addOperation:op1];
    [self.queue addOperation:op2];
    [self.queue addOperation:op3];
    //主队列更新UI
    [[NSOperationQueue mainQueue] addOperation:op4];

}
//MARK: btn5.设置最大并发数
-(void)opDemo5 {
    // 设置队列的最大并发数，队列是负责调度操作的
    /** 最大并发数的应用场景：
     1> 用户在使用3G的时候          限制线程的数量，省电，省流量(省钱)
     2> 用户使用WIFI的时候（局域网） 增加线程数量，提高用户的体验
     maxConcurrentOperationCount 如果＝＝ 1，类似于串行队列异步方法  */
    self.queue.maxConcurrentOperationCount = 1;
    for (int i = 0; i < 10; i++) {
        [self.queue addOperationWithBlock:^{
            NSLog(@"正在下载: %@ %d", [NSThread currentThread], i);
        }];
    }
}
//MARK: btn4.Block操作，添加执行块
-(void)opDemo4 {
    //实例化block操作
    NSBlockOperation *op = [[NSBlockOperation alloc] init];
    //设置最大并发（操作）数，不会限制执行块！
    self.queue.maxConcurrentOperationCount = 2;

    //添加执行块
    [op addExecutionBlock:^{
        NSLog(@"下载苍老师全集1 %@", [NSThread currentThread]);
    }];

    [op addExecutionBlock:^{
        NSLog(@"下载苍老师全集2 %@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"下载苍老师全集3 %@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"下载苍老师全集4 %@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"下载苍老师全集5 %@", [NSThread currentThread]);
    }];

    /* 启动操作，在主线程执行
     1. 如果执行块的数量超过1，就会自动进入其他线程执行(异步)
     2. 具体开启线程的数量，由系统决定
     3. 执行块的调度与操作的调度非常像  */
//    [op start];
    [self.queue addOperation:op];
}

//MARK: btn3.直接添加块操作
-(void)opDemo3 {
//只要将操作添加到队列，就会立即被调度（执行）
    for (int i = 0; i < 10; i++) {
        [self.queue addOperationWithBlock:^{
            NSLog(@"下载开始 - %@ - %@", @(i), [NSThread currentThread]);
        }];
    }

    //向主队列中添加操作
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSLog(@"下载开始 -111 %@ - %@", [NSThread currentThread], nil);
    }];
}
//MARK: btn2.NSBlockOperation
-(void)opDemo2 {
    for (int i = 0; i < 10; i++) {
        //指定一个块操作
        NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"下载开始%@ - %@", [NSThread currentThread], @(i));
        }];
        //将块操作添加到队列，新开线程
        [self.queue addOperation:op1];
        /*打印结果还是  0~9  */
    }
}
//MARK: btn1.NSInvocationOperation
-(void)opDemo1 {
    for (int i = 0; i < 10; i++) {
        sleep(1);
        NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download:) object:@(i)];
        // 如果直接启动，会在主线程执行
        //    [op1 start];
        // 添加到队列，就会新建线程，异步执行
        [self.queue addOperation:op1];
        /*打印结果还是  0~9  */
    }

}
-(void)download:(id)obj {
    NSLog(@"开始下载 %@ - %@", [NSThread currentThread], obj);
}

@end
