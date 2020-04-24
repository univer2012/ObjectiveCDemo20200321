//
//  SGHTakeLastViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHTakeLastViewController.h"
#import "UIViewController+Description.h"

@interface SGHTakeLastViewController ()

@end

@implementation SGHTakeLastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ///理解：拿最后（或倒数）的xx个
    [self showDescWith:@"takeLast 后面的数字表示，写了多个sendNext: 方法，但是 只 执行 倒数的 3个"];
    
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"rac1"];
        [subscriber sendNext:@"rac2"];
        [subscriber sendNext:@"rac3"];
        [subscriber sendNext:@"rac4"];
        [subscriber sendNext:@"rac5"];
        [subscriber sendCompleted];
        
        return nil;
    }]takeLast:3] subscribeNext:^(id x) {
        
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
