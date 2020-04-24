//
//  SGHSkipUntilBlockViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHSkipUntilBlockViewController.h"
#import "UIViewController+Description.h"

@interface SGHSkipUntilBlockViewController ()

@end

@implementation SGHSkipUntilBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ///理解：直到执行块返回NO时，才跳过
    NSString *text = @"skipUntilBlock: 返回NO时，我就skip；直到返回YES时，我才开始接收消息。" \
    "\n\n示例中，当`[x isEqualToString:@\"rac1\"]`时，返回NO，否则返回YES";
    [self showDescWith:text];
    
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"rac1"];
        [subscriber sendNext:@"rac2"];
        [subscriber sendNext:@"rac3"];
        [subscriber sendNext:@"rac4"];
        [subscriber sendCompleted];
        return nil;
        
    }] skipUntilBlock:^BOOL(id x) {
        
        //返回NO时，我就skip；直到返回YES时，我才开始接收消息
        
        if ([x isEqualToString:@"rac1"]) {
            return NO;  //跳过
        } else
            return YES; //不跳过
        
    }] subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
    }];
}

-(void)p_isDisposable {
    
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"rac1"];
        [subscriber sendNext:@"rac2"];
        [subscriber sendNext:@"rac3"];
        [subscriber sendNext:@"rac4"];
        [subscriber sendCompleted];
        
        //当信号要作销毁处理时，就要返回 RACDisposable
        return [RACDisposable disposableWithBlock:^{
            //然后把你 取消订阅的处理 写到这里来
        }];
        
    }] skipUntilBlock:^BOOL(id x) {
        
        return YES;
        
    }] subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
    }];
    
    //问：就是说，不过你不取消订阅的话，就一直是处于订阅状态的，是吧？
    //答：对，可以这么说。其实是根据你这个信号 的 持有者，如果你这个信号是局部变量，局部变量用完了，它也会销毁。
    //有时候你会把它做成全局的，全局手动销毁时，你就需要 返回CRADisposable 这个东西
    
    //问：就是全局时，return nil; 一下，局部变量时，就不用 return nil; 了？
    //答：不确定。可能把这个信号封装成一个库 什么的。所以你最好不要学我这个写法(即 return nil;)，最好都要有 返回值CARDisposable
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
