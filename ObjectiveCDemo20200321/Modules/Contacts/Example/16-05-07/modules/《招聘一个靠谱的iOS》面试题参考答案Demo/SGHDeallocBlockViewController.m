//
//  SGHDeallocBlockViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/3/22.
//  Copyright © 2020 远平. All rights reserved.
//
/**
  * 来自：
 [《招聘一个靠谱的iOS》面试题参考答案](https://blog.csdn.net/csdn15150525313/article/details/47316239)
 */
#import "SGHDeallocBlockViewController.h"
#import "NSObject+CYLRunAtDealloc.h"

@interface SGHDeallocBlockViewController ()

@property(nonatomic,strong)NSObject *foo;

@end

@implementation SGHDeallocBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.foo = [[NSObject alloc] init];
    [self.foo cyl_runAtDealloc:^{
        NSLog(@"正在释放foo！");
    }];
    
    
    UILabel *descLab = [UILabel new];
    descLab.text = @"监听foo是否成功释放，如果释放了，则会执行回调，控制台输出「正在释放foo！」\n\n" \
    "还有有关 「《招聘一个靠谱的iOS》面试题参考答案」 的Demo";
    descLab.numberOfLines = 0;
    [self.view addSubview:descLab];
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.left.top.right.equalTo(self.view);
        make.edges.equalTo(self.view);
    }];
}


@end
