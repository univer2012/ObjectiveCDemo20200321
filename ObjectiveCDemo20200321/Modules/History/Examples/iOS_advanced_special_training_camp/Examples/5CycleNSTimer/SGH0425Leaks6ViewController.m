//
//  SGH0425Leaks6ViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/25.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGH0425Leaks6ViewController.h"
#import "SGHTimerProxy.h"

@interface SGH0425Leaks6ViewController ()

@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, assign) BOOL flag;

@property (nonatomic, assign) BOOL flagTwo;

@property (nonatomic, assign) BOOL flagThree;

@property (nonatomic, strong) NSObject *target;

@property (nonatomic, strong) SGHTimerProxy* lgProxy;

@end

@implementation SGH0425Leaks6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = SHBaseTableTypeMethod;
    
    NSArray *tempTitleArray = @[
        @"1.NSTimer导致的内存泄漏",
        @"1_2.「1」中的代码相当于如下代码：",
        @"2.第1种解决方案：\n当`didMoveToParentViewController:`中的`parent == nil`时，对timer执行释放",
        @"3.第2种解决方案：\n不让NSTimer持有self，采用「消息转发」来解决循环引用的问题",
        @"4.第3种解决方案：\n使用中间变量NSProxy，弱持有self，来打破self与NSTimer中间的循环。",
    ];
    NSArray *tempClassNameArray = @[
        @"demo1",
        @"demo1_2",
        @"demo2",
        @"demo3",
        @"demo4",
    ];
    
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:self.title];
    
    [self.tableView reloadData];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pushOther)];
}

//MARK: 4.第3种解决方案：\n使用中间变量NSProxy，弱持有self，来打破self与NSTimer中间的循环。
- (void)demo4 {
    //NSProxy
    //运用到了「消息转发」机制
    //处理的是第3点，慢速转发，
    
    self.flagThree = YES;
    
    _lgProxy = [SGHTimerProxy alloc]; //NSProxy只有alloc方法
    _lgProxy.target = self;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:_lgProxy selector:@selector(fire) userInfo:nil repeats:YES];
}


//MARK: 3.第2种解决方案：\n不让NSTimer持有self，采用「消息转发」来解决循环引用的问题
- (void)demo3 {
    self.flagTwo = YES;
    
    _target = [NSObject new];
    class_addMethod([_target class], @selector(fire), (IMP)fireImp, "v@:");
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:_target selector:@selector(fire) userInfo:nil repeats:YES];
}

void fireImp(id self, SEL _cmd) {
    NSLog(@"fireIMP --- fire.....");
}


//MARK: 2.第1种解决方案：\n当`didMoveToParentViewController:`中的`parent == nil`时，对timer执行释放
- (void)demo2 {
    self.flag = YES;
    
    [self demo1_2];
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    //if (parent == nil) {
    if (parent.presentingViewController == nil) {
        if (self.flag) {
            [self.timer invalidate];
            self.timer = nil;
        }
    }
}

//MARK: 1_2.「1」中的代码相当于如下代码。即使你在dealloc中写了释放代码，也不会执行dealloc
- (void)demo1_2 {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(fire) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

//MARK: 1.NSTimer导致的内存泄漏
- (void)demo1 {
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(fire) userInfo:nil repeats:YES];
}

- (void)fire {
    NSLog(@"fire.....");
}

- (void)dealloc
{
    NSLog(@"SGH0425Leaks6ViewController Dealloc");
    if (self.flagTwo || self.flagThree) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
//    [self.timer invalidate];
//    self.timer = nil;
}

- (void)pushOther {
    [self pushToNewVCWith:@"SGH0425Leaks6ViewController" title:@"" inBookmarkStoryboard:NO selText:@""];
}

@end
