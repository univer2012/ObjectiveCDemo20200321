//
//  SGHTakeViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHTakeViewController.h"
#import "UIViewController+Description.h"

@interface SGHTakeViewController ()

@end

@implementation SGHTakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ///理解：拿前面的 xx个
    [self showDescWith:@"take 后面的数字表示，写了多个sendNext: 方法，但是只执行前2次"];
    
    //
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"rac1"];
        [subscriber sendNext:@"rac2"];
        [subscriber sendNext:@"rac3"];
        [subscriber sendNext:@"rac4"];
        [subscriber sendCompleted];
        
        return nil;
    }] take:2] subscribeNext:^(id x) {
       
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
