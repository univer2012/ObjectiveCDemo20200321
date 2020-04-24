//
//  SGHSwitchToLatestViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHSwitchToLatestViewController.h"
#import "UIViewController+Description.h"

@interface SGHSwitchToLatestViewController ()

@end

@implementation SGHSwitchToLatestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITextField * textField = [[UITextField alloc]init];
    textField.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:textField];
    
    @weakify(self); //  __weak __typeof__(self) self_weak_ = self;
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self);   //  __strong __typeof__(self) self = self_weak_;
        make.size.mas_equalTo(CGSizeMake(180, 40));
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(120);
    }];
    
    UIButton *firstBtn = [self buildBtnWith:@"第1个例子"];
    firstBtn.tag = 1;
    [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(150);
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(60);
    }];
    UIButton *secondBtn = [self buildBtnWith:@"第2个例子"];
    secondBtn.tag = 2;
    [secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(firstBtn.mas_bottom).offset(20);
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(60);
    }];
    UIButton *thirdBtn = [self buildBtnWith:@"map的例子return RACSignal"];
    [thirdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(secondBtn.mas_bottom).offset(20);
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(60);
    }];
    UIButton *fourthBtn = [self buildBtnWith:@"map的例子return NSNumber"];
    [fourthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(thirdBtn.mas_bottom).offset(20);
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(60);
    }];
    UIButton *fifthBtn = [self buildBtnWith:@"flattenMap的例子"];
    [fifthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(fourthBtn.mas_bottom).offset(20);
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(60);
    }];
    
    
    firstBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        ///来自：[RAC switchToLatest](https://www.jianshu.com/p/cbeab1c0d69e)
        ///第2个例子
        RACSubject *signalOfSignals = [RACSubject subject];
        RACSubject *signalA = [RACSubject subject];
        RACSubject *signalB = [RACSubject subject];
        // 获取信号中信号最近发出信号，订阅最近发出的信号。
        // 注意switchToLatest：只能用于信号中的信号
        [signalOfSignals.switchToLatest subscribeNext:^(id x) {
            /// x不是RACSubject类型，而是`__NSCFConstantString`类型
            NSLog(@"%@",x);
        }];
        [signalOfSignals sendNext:signalA];
        [signalOfSignals sendNext:signalB];
        [signalA sendNext:@"signalA"];
        [signalB sendNext:@"signalB"];
        
        return  [RACSignal empty];
    }];
    
    [self showDescWith:@"rac_command的实现代码，不可执行多次，否则会被监听多次。不信可以点击多次「第2个例子」，看是不是会有多个打印"];
    //MARK: rac_command的实现代码，不可执行多次，否则会被监听多次。不信可以点击多次「第2个例子」，看是不是会有多个打印
    @weakify(textField)
    secondBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        //改进3
        //取消订阅 --->  switchToLatest
        // signal of signals
        @strongify(textField)
        [[[[[[textField.rac_textSignal throttle:0.3] distinctUntilChanged] ignore:@""]
           map:^id(id value) {
               
               return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                   
                   // request
                   [subscriber sendNext:value];
                   [subscriber sendCompleted];
                   
                   return [RACDisposable disposableWithBlock:^{
                       
                       //取消请求
                       //AFHTTPRequestOperation *operation = nil;
                       //[operation cancel];
                       
                   }];
                   
               }];
           }] switchToLatest]
         subscribeNext:^(id x) {
             LxDBAnyVar(x);
         }];
        
        return  [RACSignal empty];
    }];
    
    thirdBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(textField)
        //代码
        [[textField.rac_textSignal map:^id(id value) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                [subscriber sendNext:@"rac"];
                [subscriber sendCompleted];
                return nil;
                
            }];
        }] subscribeNext:^(id x) {
            //打印的是`RACSignal`
            LxDBAnyVar(x);
        }];
        
        return  [RACSignal empty];
    }];
    
    fourthBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(textField)
        //代码
        [[textField.rac_textSignal map:^id(NSString *text) {
            
            LxDBAnyVar(text);
            
            return @(text.length);
        }] subscribeNext:^(id x) {
            //打印的是`text.length`的结果
            LxDBAnyVar(x);
        }];
        
        return  [RACSignal empty];
    }];
    
    fifthBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(textField)
        // flattenMap  --->  扁平化映射
        [[textField.rac_textSignal flattenMap:^id(id value) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                [subscriber sendNext:@"rac"];
                [subscriber sendCompleted];
                return nil;
                
            }];
        }] subscribeNext:^(id x) {
            //打印的是字符串「rac」
            LxDBAnyVar(x);
        }];
        
        return  [RACSignal empty];
    }];
    
    
    
    
    
#if 0
    

    
    //signal of signals 的另一个例子
#pragma mark - map 和 flattenMap
    
#elif 0
    
    
#elif 0
    
    
    
#elif  0
#pragma mark - map的一个例子
    

    
#endif
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
