//
//  SGH0401RACCommandViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/1.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGH0401RACCommandViewController.h"
#import "UIViewController+Description.h"
//#import <ReactiveCocoa/ReactiveCocoa.h>

/*
 * 来自：[iOS RAC - RACCommand](https://www.jianshu.com/p/baa5fe76191c)
 * 2. [RACCommand中的信号](https://www.cnblogs.com/guoxiaoqian/p/4716540.html)
 */
@interface SGH0401RACCommandViewController ()

@end

@implementation SGH0401RACCommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeMethod;
    
    NSArray *tempTitleArray = @[
        @"1.创建RACCommand，return nil(会崩溃)",
        @"2.创建RACCommand，return RACSignal",
        @"3.[subscriber sendNext:]",
        @"4.对[command execute:]拿到的signal，执行[signal subscribeNext:]",
        @"5.使用[command.executionSignals subscribeNext:]来拿signal，并执行[x subscribeNext:]",
        @"6.使用[command.executionSignals.switchToLatest subscribeNext:]直接订阅signal的消息",
        @"7.探索signalofsignal",
        @"8.探索[signalofsignal.switchToLatest subscribeNext:]的x类型",
        @"9.探索[signalofsignal.switchToLatest subscribeNext:]是不是拿到最后一个消息",
        @"10.探索「command.executing是否执行结束」",
        @"11.探索「command.executing是否执行结束」的改进1",
        @"12.探索「command.executing是否执行结束」的改进2:[command.executing skip:1]",
        @"13. executing的探索",
    ];
    NSArray *tempClassNameArray = @[
        @"exploreDemo1",
        @"exploreDemo2",
        @"exploreDemo3",
        @"exploreDemo4",
        @"exploreDemo5",
        @"exploreDemo6",
        @"exploreDemo7",
        @"exploreDemo8",
        @"exploreDemo9",
        @"exploreDemo10",
        @"exploreDemo11",
        @"exploreDemo12",
        @"executingDemo",
    ];
    
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:self.title];
    
    [self.tableView reloadData];
    
}
//MARK: 13. executing的探索
///来自：[RACCommand中的信号](https://www.cnblogs.com/guoxiaoqian/p/4716540.html)
- (void)executingDemo {
    UIButton *createButton = [self buildBtnWith:@"executing"];
    [self.view addSubview:createButton];
    [createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view).offset(-40);
    }];
    
    
    RACSignal* textSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@(1)];
        [subscriber sendNext:@(2)];
        [subscriber sendCompleted];
        //[subscriber sendError:[NSError new]];
        return nil;
    }];
    
    RACCommand* textCommad = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return textSignal;
    }];
    
    createButton.rac_command = textCommad;
    
    [textCommad.executing subscribeNext:^(id x) {
        NSLog(@"executing%@",x);
    }];
    
    [textCommad.executionSignals subscribeNext:^(id x) {
        NSLog(@"executionSignals%@",x);
    }];
    
    [[textCommad.executionSignals switchToLatest]subscribeNext:^(id x) {
        NSLog(@"executionSignals switchLatest%@",x);
    }];
    
    [textCommad.errors subscribeNext:^(id x) {
        NSLog(@"errors");
    }];
}

//MARK: 12.探索「command.executing是否执行结束」的改进2:[command.executing skip:1]
- (void)exploreDemo12 {
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"input - %@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"6666666666"];
            [subscriber sendCompleted];
            
            return nil;
        }];
    }];

    [command.executionSignals.switchToLatest subscribeNext:^(id _Nullable x) {
        NSLog(@"%@",x);
    }];

    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"还在执行");
        } else {
            NSLog(@"执行结束了");
        }
    }];

    [command execute:@"9999999999"];
}
//MARK: 11.探索「command.executing是否执行结束」的改进1
- (void)exploreDemo11 {
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"input - %@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"6666666666"];
            [subscriber sendCompleted];
            
            return nil;
        }];
    }];

    [command.executionSignals.switchToLatest subscribeNext:^(id _Nullable x) {
        NSLog(@"%@",x);
    }];

    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"还在执行");
        } else {
            NSLog(@"执行结束了");
        }
    }];

    [command execute:@"9999999999"];
}
//MARK: 10.探索「command.executing是否执行结束」
- (void)exploreDemo10 {
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"input - %@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"6666666666"];
            
            return nil;
        }];
    }];

    [command.executionSignals.switchToLatest subscribeNext:^(id _Nullable x) {
        NSLog(@"%@",x);
    }];

    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"还在执行");
        } else {
            NSLog(@"执行结束了");
        }
    }];

    [command execute:@"9999999999"];
}
//MARK: 9.探索[signalofsignal.switchToLatest subscribeNext:]是不是拿到最后一个消息
- (void)exploreDemo9 {
    RACSubject *signalofsignal = [RACSubject subject];
    RACSubject *signal1 = [RACSubject subject];
    RACSubject *signal2 = [RACSubject subject];
    RACSubject *signal3 = [RACSubject subject];
    RACSubject *signal4 = [RACSubject subject];

    [signalofsignal.switchToLatest subscribeNext:^(id _Nullable x) {
        NSLog(@"%@",x);
    }];

    [signalofsignal sendNext:signal1];
    [signalofsignal sendNext:signal2];
    [signalofsignal sendNext:signal3];
    [signalofsignal sendNext:signal4];

    [signal1 sendNext:@"1"];
    [signal2 sendNext:@"2"];
    [signal3 sendNext:@"3"];
    [signal4 sendNext:@"4"];
}
//MARK: 8.探索[signalofsignal.switchToLatest subscribeNext:]的x类型
- (void)exploreDemo8 {
    RACSubject *signalofsignal = [RACSubject subject];
    RACSubject *signal1 = [RACSubject subject];
    RACSubject *signal2 = [RACSubject subject];
    RACSubject *signal3 = [RACSubject subject];
    RACSubject *signal4 = [RACSubject subject];

    [signalofsignal.switchToLatest subscribeNext:^(id _Nullable x) {
        NSLog(@"%@",x);
    }];

    [signalofsignal sendNext:signal1];
    [signal1 sendNext:@"1"];
}
//MARK: 7.探索signalofsignal
- (void)exploreDemo7 {
    RACSubject *signalofsignal = [RACSubject subject];
    RACSubject *signal1 = [RACSubject subject];
    RACSubject *signal2 = [RACSubject subject];
    RACSubject *signal3 = [RACSubject subject];
    RACSubject *signal4 = [RACSubject subject];
    
    [signalofsignal subscribeNext:^(id  _Nullable x) {
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
        }];
    }];
    
    [signalofsignal sendNext:signal1];
    [signal1 sendNext:@"1"];
}

//MARK: 6.使用[command.executionSignals.switchToLatest subscribeNext:]直接订阅signal的消息
- (void)exploreDemo6 {
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"大佬大佬放过我"];
            
            return nil;
        }];
    }];

    [command.executionSignals.switchToLatest subscribeNext:^(id _Nullable x) {
        NSLog(@"接收数据 - %@",x);
    }];

    [command execute:@"开始飞起来"];
}
//MARK: 5. 使用[command.executionSignals subscribeNext:]来拿signal，并执行[x subscribeNext:]
- (void)exploreDemo5 {
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"大佬大佬放过我"];
            
            return nil;
        }];
    }];

    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"这里会是什么呢？ - %@",x);
        }];
        NSLog(@"接收数据 - %@",x);
    }];

    [command execute:@"开始飞起来"];
}
//MARK: 4. 对[command execute:]拿到的signal，执行[signal subscribeNext:]
- (void)exploreDemo4 {
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"大佬大佬放过我"];
            
            return nil;
        }];
    }];

    RACSignal * signal = [command execute:@"开始飞起来"];

    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收数据 - %@",x);
    }];
}
//MARK: 3. [subscriber sendNext:]
- (void)exploreDemo3 {
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"大佬大佬放过我"];
            
            return nil;
        }];
    }];
    [command execute:@"开始飞起来"];
}

//MARK: 2.创建RACCommand，return RACSignal
- (void)exploreDemo2 {
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"%@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            return nil;
        }];
    }];
    [command execute:@"开始飞起来"];
}

//MARK: 1.创建RACCommand，return nil(会崩溃)
- (void)exploreDemo1 {
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        return nil;
    }];

    [command execute:@"开始飞起来"];
}


@end
