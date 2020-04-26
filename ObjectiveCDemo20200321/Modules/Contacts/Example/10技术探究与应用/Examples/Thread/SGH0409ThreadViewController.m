//
//  SGH0409ThreadViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/9.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGH0409ThreadViewController.h"

@interface SGH0409ThreadViewController ()

@property (nonatomic,assign) NSInteger ticketCount;


@end

@implementation SGH0409ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.type = SHBaseTableTypeMethod;
    //section 1
    NSArray *tempTitleArray=@[
        @"1.线程的创建和使用实例：模拟售票",
        @"2.改进1",
        @"3. 执行完成后，让其中线程一直运行，（窗口一直开放，可以随时指派其卖演唱会的门票的任务），答案就是给线程加上runLoop",
    ];
    NSArray *tempSelectorArray=@[
        @"originDemo",
        @"inproveDemo1",
        @"threadDemo3",
    ];
    [self addSectionDataWithClassNameArray:tempSelectorArray titleArray:tempTitleArray title:@""];
    
    [self.tableView reloadData];
    
}
//MARK: 3. 执行完成后，让其中线程一直运行，（窗口一直开放，可以随时指派其卖演唱会的门票的任务），答案就是给线程加上runLoop
- (void)threadDemo3 {
    //先监听线程退出的通知，以便知道线程什么时候退出
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(threadExitNotice) name:NSThreadWillExitNotification object:nil];
     
     //设置演唱会的门票数量
    _ticketCount = 50;
    
    //新建两个子线程（代表两个窗口同时销售门票）
    NSThread * window1 = [[NSThread alloc]initWithTarget:self selector:@selector(thread1) object:nil];
    [window1 start];
    
    NSThread * window2 = [[NSThread alloc]initWithTarget:self selector:@selector(thread2) object:nil];
    [window2 start];
    
    [self performSelector:@selector(saleTicket) onThread:window1 withObject:nil waitUntilDone:NO];
    [self performSelector:@selector(saleTicket) onThread:window2 withObject:nil waitUntilDone:NO];
}

- (void)thread1 {
    [NSThread currentThread].name = @"北京售票窗口";
    NSRunLoop * runLoop1 = [NSRunLoop currentRunLoop];
    [runLoop1 runUntilDate:[NSDate date]]; //一直运行
}
     
- (void)thread2 {
    [NSThread currentThread].name = @"广州售票窗口";
    NSRunLoop * runLoop2 = [NSRunLoop currentRunLoop];
    [runLoop2 runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10.0]]; //自定义运行时间
}

//对saleTicket方法的改进2
- (void)saleTicket2 {
    while (1) {
        @synchronized (self) {
            //如果还有票，继续售卖
            if (_ticketCount > 0) {
                _ticketCount --;
                NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", _ticketCount, [NSThread currentThread].name]);
                [NSThread sleepForTimeInterval:0.2];
            }
            //如果已卖完，关闭售票窗口
            else {
                if ([NSThread currentThread].isCancelled) {
                    break;
                }else {
                    NSLog(@"售卖完毕");
                    //给当前线程标记为取消状态
                    [[NSThread currentThread] cancel];
                //停止当前线程的runLoop
                CFRunLoopStop(CFRunLoopGetCurrent());
                }
            }
        }
    }
}


//MARK: 2.改进1
- (void)inproveDemo1 {
    //先监听线程退出的通知，以便知道线程什么时候退出
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(threadExitNotice) name:NSThreadWillExitNotification object:nil];
     
     //设置演唱会的门票数量
    _ticketCount = 50;

    //新建两个子线程（代表两个窗口同时销售门票）
     NSThread * window1 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket1) object:nil];
     window1.name = @"北京售票窗口";
     [window1 start];
     
     NSThread * window2 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket1) object:nil];
     window2.name = @"广州售票窗口";
     [window2 start];
    
}


- (void)saleTicket1 {
    while (1) {
        @synchronized (self) {
            //如果还有票，继续售卖
            if (_ticketCount > 0) {
                _ticketCount --;
                NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", _ticketCount, [NSThread currentThread].name]);
                [NSThread sleepForTimeInterval:0.2];
            }
            //如果已卖完，关闭售票窗口
            else {
                break;
            }
        }
    }
}




//MARK: 1.线程的创建和使用实例：模拟售票
- (void)originDemo {
    //先监听线程退出的通知，以便知道线程什么时候退出
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(threadExitNotice) name:NSThreadWillExitNotification object:nil];
     
     //设置演唱会的门票数量
    _ticketCount = 50;

    //新建两个子线程（代表两个窗口同时销售门票）
     NSThread * window1 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
     window1.name = @"北京售票窗口";
     [window1 start];
     
     NSThread * window2 = [[NSThread alloc]initWithTarget:self selector:@selector(saleTicket) object:nil];
     window2.name = @"广州售票窗口";
     [window2 start];
    
}
- (void)threadExitNotice {
    NSLog(@"%@ Will Exit",[NSThread currentThread]);
}

- (void)saleTicket {
    while (1) {
        //如果还有票，继续售卖
        if (_ticketCount > 0) {
            _ticketCount --;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", _ticketCount, [NSThread currentThread].name]);
            [NSThread sleepForTimeInterval:0.2];
        }
        //如果已卖完，关闭售票窗口
        else {
            break;
        }
    }
}

@end
