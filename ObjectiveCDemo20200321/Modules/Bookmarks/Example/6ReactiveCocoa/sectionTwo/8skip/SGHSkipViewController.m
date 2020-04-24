//
//  SGHSkipViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHSkipViewController.h"
#import "UIViewController+Description.h"

@interface SGHSkipViewController ()

@end

@implementation SGHSkipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ///理解：跳过 前面的xx个
    [self showDescWith:@"skip 后面的数字表示，写了多个sendNext: 方法，但是 跳过前2次 再执行"];
    //
    
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"rac1"];
        [subscriber sendNext:@"rac2"];
        [subscriber sendNext:@"rac3"];
        [subscriber sendNext:@"rac4"];
        [subscriber sendNext:@"rac5"];
        [subscriber sendCompleted];
        
        return nil;
    }]skip:2] subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
    }];
    
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
