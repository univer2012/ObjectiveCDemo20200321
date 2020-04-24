//
//  SHRAC12ViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/23.
//  Copyright © 2019 huangaengoln. All rights reserved.
//
/*
 * 来自：[RAC(ReactiveCocoa)介绍（十二）——RACCommand](https://www.jianshu.com/p/75681ea2256e)
 */
#import "SHRAC12ViewController.h"
#import "SHRAC12ViewModel.h"
#import "UIViewController+Description.h"

@interface SHRAC12ViewController ()

@property(nonatomic, strong)SHRAC12ViewModel *viewModel;
@property(nonatomic, strong)UITextField *priceTextFld;

@end

@implementation SHRAC12ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeMethod;
    
    NSArray *tempTitleArray = @[
        @"1.原代码",
        @"2.改进1",
        @"3.改进2",
        @"4.另一个有关priceTextFld的监听的demo",
        @"5.subscribeDemo的demo-没有回调",
        @"6.subscribeDemo的demo-有回调",
        @"7.subscribeDemo-不主动调用，只监听",
    ];
    NSArray *tempClassNameArray = @[
        @"originalCode",
        @"improved1Code",
        @"improved2Code",
        @"aboutTextFieldDemo",
        @"subscribeDemo",
        @"subscribeDemoHasSubscribeNext",
        @"subscribeDemoOnlySubscribeNext",
    ];
    
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:self.title];
    
    [self.tableView reloadData];
    
    
}

//MARK:7.subscribeDemo-不主动调用，只监听
- (void)subscribeDemoOnlySubscribeNext {
    
    self.viewModel = [[SHRAC12ViewModel alloc] init];
    
    self.priceTextFld = [[UITextField alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 40)];
    self.priceTextFld.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.priceTextFld];
    
    //不主动调用，只监听
    [self.viewModel.subscribeCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"监听后执行：%@",x);
        
    }];
    
    @weakify(self)
    //监听价格输入
    [[RACObserve(self.priceTextFld, text) merge:self.priceTextFld.rac_textSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSLog(@"callBack_succeed_observer:%@__OK",x);
        [self.viewModel.subscribeCommand execute:@"不主动调用，只监听"];
    }];
}

//MARK:6.subscribeDemo的demo-有回调
- (void)subscribeDemoHasSubscribeNext {
    self.viewModel = [[SHRAC12ViewModel alloc] init];
    
    self.priceTextFld = [[UITextField alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 40)];
    self.priceTextFld.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.priceTextFld];
    
    @weakify(self)
    //监听价格输入
    [[RACObserve(self.priceTextFld, text) merge:self.priceTextFld.rac_textSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSLog(@"callBack_succeed_observer:%@__OK",x);
        [[self.viewModel.subscribeCommand execute:@"有回调"] subscribeNext:^(NSString * _Nullable text) {
            NSLog(@"callBack_succeed：%@__haode",text);
        }];
    }];
    
}

//MARK:5.subscribeDemo的demo-没有回调
- (void)subscribeDemo {
    self.viewModel = [[SHRAC12ViewModel alloc] init];
    
    self.priceTextFld = [[UITextField alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 40)];
    self.priceTextFld.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.priceTextFld];
    
    @weakify(self)
    //监听价格输入
    [[RACObserve(self.priceTextFld, text) merge:self.priceTextFld.rac_textSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSLog(@"callBack_succeed_observer:%@__OK",x);
        [self.viewModel.subscribeCommand execute:@"没有回调"];
    }];
    
}

//MARK:4.另一个有关priceTextFld的监听的demo
- (void)aboutTextFieldDemo {
    
    self.viewModel = [[SHRAC12ViewModel alloc] init];
    
    self.priceTextFld = [[UITextField alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 40)];
    self.priceTextFld.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.priceTextFld];
    
    @weakify(self)
    //监听价格输入
    [[RACObserve(self.priceTextFld, text) merge:self.priceTextFld.rac_textSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSLog(@"priceTextFld_text:%@",x);
        @weakify(self)
        [[self.viewModel.priceSpreadCommand execute:nil] subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            NSLog(@"priceSpreadCommand订阅：%@",x);
        }];
    }];
    
    //更新价差
    [self.viewModel.priceSpreadCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        //@strongify(self)
        NSLog(@"executionSignals_switchToLatest:%@",x);
    }];
    
    ///priceSpreadCommand execute:nil] subscribeNext: 这种写法不会受到任何信息
    [[self.viewModel.priceSpreadCommand execute:nil] subscribeNext:^(id  _Nullable x) {
        //@strongify(self)
        NSLog(@"priceSpreadCommand订阅2：%@",x);
        //NSLog(@"before_dljfojsojfl ");
        //[self.headerView.priceView refreshUIWithRefreshPrice:NO];
    }];
}

//MARK:3.改进2
- (void)improved2Code {
    //创建command信号
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        //返回RACSignal信号类型对象
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"this is signal of command"];
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:1234 userInfo:@{@"key": @"error"}];
            [subscriber sendError:error];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"销毁了");
            }];
        }];
    }];
    
    //command信号是否正在执行
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"executing_skip1 == %@",x);
    }];
    
    //错误信号
    [command.errors subscribeNext:^(NSError * _Nullable x) {
        NSLog(@"errors == %@",x);
    }];
    
    //监听最后一次发送的信号
    [[command.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        NSLog(@"executionSignals_switchToLatest == %@",x);
    }];
    
    //必须执行命令，否则所有信号都不会订阅到
    [command execute:@"command执行"];
}
//MARK:2.改进1
- (void)improved1Code {
    //创建command信号
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        //返回RACSignal信号类型对象
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"this is signal of command"];
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:1234 userInfo:@{@"key": @"error"}];
            [subscriber sendError:error];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"销毁了");
            }];
        }];
    }];
    
    //command信号是否正在执行
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"executing_skip1 == %@",x);
    }];
    
    //错误信号
    [command.errors subscribeNext:^(NSError * _Nullable x) {
        NSLog(@"errors == %@",x);
    }];
    
    
   //command信号中signal信号发送出来的订阅信号
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        NSLog(@"executionSignals == %@",x);
    }];
    
    //必须执行命令，否则所有信号都不会订阅到
    [command execute:@"command执行"];
}

//MARK:1.原代码
- (void)originalCode {
    //创建command信号
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        //返回RACSignal信号类型对象
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"this is signal of command"];
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:1234 userInfo:@{@"key": @"error"}];
            [subscriber sendError:error];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"销毁了");
            }];
        }];
    }];
    
    //command信号是否正在执行
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"executing == %@",x);
    }];
    
    //错误信号
    [command.errors subscribeNext:^(NSError * _Nullable x) {
        NSLog(@"errors == %@",x);
    }];
    
    //command信号中signal信号发送出来的订阅信号
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        NSLog(@"executionSignals == %@",x);
    }];
    
    //必须执行命令，否则所有信号都不会订阅到
    [command execute:@"command执行"];
}


@end
