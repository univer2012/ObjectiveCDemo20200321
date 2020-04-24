//
//  SGHKVOViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/30.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHKVOViewController.h"

@interface SGHKVOViewController ()

@end

@implementation SGHKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.delegate = (id<UIScrollViewDelegate>)self;
    [self.view addSubview:scrollView];
    
    UIView * scrollViewContentView = [[UIView alloc]init];
    scrollViewContentView.backgroundColor = [UIColor yellowColor];
    [scrollView addSubview:scrollViewContentView];
    
    @weakify(self);
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self);
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(80, 80, 80, 80));
    }];
    
    [scrollViewContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self);
        make.edges.equalTo(scrollView);
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)));
    }];
    
    [RACObserve(scrollView, contentOffset) subscribeNext:^(id x) {
        LxDBAnyVar(x);
    }];
    
    // 好处：写法简单，keypath有代码提示）
    
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
