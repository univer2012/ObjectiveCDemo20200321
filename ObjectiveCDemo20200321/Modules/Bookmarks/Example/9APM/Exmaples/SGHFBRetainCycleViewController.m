//
//  SGHFBRetainCycleViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/27.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHFBRetainCycleViewController.h"
#import <FBRetainCycleDetector/FBRetainCycleDetector.h>

#import "SGHObjectB.h"
#import "SGHObjectA.h"

@interface SGHFBRetainCycleViewController ()

@property (nonatomic,strong)NSTimer *AdTimer;

@property (nonatomic )NSTimer *adTwoTimer;

@property (nonatomic, weak)NSTimer *adThreeTimer;

@property (nonatomic,strong)SGHObjectA *aObj;
@property (nonatomic,strong)SGHObjectB *bObj;

@end

@implementation SGHFBRetainCycleViewController
{
    void (^_handlerBlock)();
    
    NSInteger _launchAdTimeNumber;
    NSTimer * tempTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeMethod;
    //MARK: section 1
    
    NSArray *tempTitleArray = @[
        @"1.两个对象相互强引用",
        @"1_2.两个对象相互强引用 \n解决办法是，使用weak给其中一个对象松耦合。",
        @"2.block内引用了外部变量self",
        @"2_2.block内引用了外部变量self \n解决办法是，block里面要引用外部的所有对象，都用__block或者__weak修饰以后，再使用。",
        @"3.NSTimer 通过成为正在运行的定时器的Target而被持有。",
        @"3_1.NSTimer作为成员变量，也会造成retain cycle",
        @"3_2.NSTimer不用strong修饰也会造成retain cycle",
        @"3_3.NSTimer用weak也会造成retain cycle",
    ];
    NSArray *tempClassNameArray = @[
        @"demo1",
        @"demo1_2",
        @"demo2",
        @"demo2_2",
        @"demo3",
        @"demo3_1",
        @"demo3_2",
        @"demo3_3",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"NSOperation&NSOperationQueue"];
    
    [self.tableView reloadData];
}
//MARK:3_3.NSTimer用weak也会造成retain cycle
- (void)demo3_3 {
    
//    self.adThreeTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(launshAdMainThread_3) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:self.adThreeTimer forMode:NSRunLoopCommonModes]; //使用weak修饰NSTimer，在这里会崩溃
    
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(launshAdMainThread_3) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.adThreeTimer = timer;
    
    _launchAdTimeNumber = 6;
    
    

//    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
//    [detector addCandidate:self];
//    NSSet *retainCycles = [detector findRetainCycles];
//    NSLog(@"%@",retainCycles);
}
-(void)launshAdMainThread_3 {
    if (_launchAdTimeNumber <= 0) {
        [self.adThreeTimer invalidate];
        return;
    } else {
        NSLog(@"_launchAdTimeNumber: %ld", _launchAdTimeNumber);
    }
    _launchAdTimeNumber--;
}
- (void)dealloc
{
    [self.adThreeTimer invalidate];
    self.adThreeTimer = nil;
}



//MARK:3_2.NSTimer不用strong修饰也会造成retain cycle
- (void)demo3_2 {
    self.adTwoTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(launshAdMainThread_2) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.adTwoTimer forMode:NSRunLoopCommonModes];
    _launchAdTimeNumber = 6;

//    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
//    [detector addCandidate:self];
//    NSSet *retainCycles = [detector findRetainCycles];
//    NSLog(@"%@",retainCycles);
}
-(void)launshAdMainThread_2 {
    if (_launchAdTimeNumber <= 0) {
        [self.adTwoTimer invalidate];
        return;
    } else {
        NSLog(@"_launchAdTimeNumber: %ld", _launchAdTimeNumber);
    }
    _launchAdTimeNumber--;
}


//MARK:3_1.NSTimer作为成员变量，也会造成retain cycle
- (void)demo3_1 {
    tempTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(launshAdMainThread_1) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:tempTimer forMode:NSRunLoopCommonModes];
    _launchAdTimeNumber = 6;

//    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
//    [detector addCandidate:self];
//    NSSet *retainCycles = [detector findRetainCycles];
//    NSLog(@"%@",retainCycles);
}

-(void)launshAdMainThread_1 {
    if (_launchAdTimeNumber <= 0) {
        [tempTimer invalidate];
        return;
    } else {
        NSLog(@"_launchAdTimeNumber: %ld", _launchAdTimeNumber);
    }
    _launchAdTimeNumber--;
}

//MARK:3.NSTimer 通过成为正在运行的定时器的Target而被持有。
- (void)demo3 {
    self.AdTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(p_launshAdMainThread) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.AdTimer forMode:NSRunLoopCommonModes];
    _launchAdTimeNumber = 6;

//    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
//    [detector addCandidate:self.AdTimer];
//    NSSet *retainCycles = [detector findRetainCycles];
//    NSLog(@"%@",retainCycles);
}
-(void)p_launshAdMainThread {
    if (_launchAdTimeNumber <= 0) {
        [self.AdTimer invalidate];
        return;
    } else {
        NSLog(@"_launchAdTimeNumber: %ld", _launchAdTimeNumber);
    }
    _launchAdTimeNumber--;
}

//MARK:2_2.block内引用了外部变量self \n解决办法是，block里面要引用外部的所有对象，都用__block或者__weak修饰以后，再使用。
- (void)demo2_2 {
    
    __weak typeof(self) weakSelf = self;
    _handlerBlock = ^{
        NSLog(@"%@",weakSelf);
    };
//    FBRetainCycleDetector *oneDetector = [FBRetainCycleDetector new];
//    [oneDetector addCandidate:self];
//    NSSet *oneRetainCycles = [oneDetector findRetainCycles];
//    NSLog(@"%@",oneRetainCycles);
}

//MARK:2.block内引用了外部变量self
- (void)demo2 {
    _handlerBlock = ^{
        NSLog(@"%@",self);
    };
//    FBRetainCycleDetector *oneDetector = [FBRetainCycleDetector new];
//    [oneDetector addCandidate:self];
//    NSSet *oneRetainCycles = [oneDetector findRetainCycles];
//    NSLog(@"%@",oneRetainCycles);
}

//MARK:1_2.两个对象相互强引用 - 解决办法是，使用weak给其中一个对象松耦合。
- (void)demo1_2 {
    self.aObj = [SGHObjectA new];
    self.bObj = [SGHObjectB new];
    _aObj.b = _bObj;
    _bObj.objectA = _aObj;
    
//    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
//    [detector addCandidate:aObj];
//    NSSet *retainCycles = [detector findRetainCycles];
//    NSLog(@"%@",retainCycles);
}

//MARK:1.两个对象相互强引用
- (void)demo1 {
    self.aObj = [SGHObjectA new];
    self.bObj = [SGHObjectB new];
    _aObj.objectB = _bObj;
    _bObj.objectA = _aObj;
    
//    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
//    [detector addCandidate:self.aObj];
//    NSSet *retainCycles = [detector findRetainCycles];
//    NSLog(@"%@",retainCycles);
}



@end
