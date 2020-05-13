//
//  SGHCustomKVOViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/13.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHCustomKVOViewController.h"

#import "SGHCustomKVOPerson.h"

@interface SGHCustomKVOViewController ()

@property(nonatomic, strong)SGHCustomKVOPerson *p1;

@property(nonatomic, strong)SGHCustomKVOPerson *p2;

@end

@implementation SGHCustomKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.type = SHBaseTableTypeMethod;
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"1.系统的KVO方式",
        @"2.自定义的KVO方式",
    ];
    NSArray *tempClassNameArray = @[
        @"sec1demo1",
        @"sec1demo2",
    ];
    
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:self.title];
    
    
    [self.tableView reloadData];
    
    
}

//MARK: 2.自定义的KVO方式
- (void)sec1demo2 {
    _p1 = [SGHCustomKVOPerson new];
    _p2 = [SGHCustomKVOPerson new];
    
    _p2.name = @"Kody";
    
    NSLog(@"监听之前 --- p1:%p,p2:%p", [_p1 methodForSelector:@selector(setName:)], [_p2 methodForSelector:@selector(setName:)]);
        
    [_p1 lg_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:NULL];
    
    
    _p1.name = @"Tom";
    NSLog(@"监听之后 --- p1:%p,p2:%p", [_p1 methodForSelector:@selector(setName:)], [_p2 methodForSelector:@selector(setName:)]);
}

//MARK: 1.系统的KVO方式
- (void)sec1demo1 {
    _p1 = [SGHCustomKVOPerson new];
    _p2 = [SGHCustomKVOPerson new];
    
    _p2.name = @"Kody";
    
    NSLog(@"监听之前 --- p1:%p,p2:%p", [_p1 methodForSelector:@selector(setName:)], [_p2 methodForSelector:@selector(setName:)]);
    
    [_p1 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    
    _p1.name = @"Tom";
    NSLog(@"监听之后 --- p1:%p,p2:%p", [_p1 methodForSelector:@selector(setName:)], [_p2 methodForSelector:@selector(setName:)]);
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"change === %@",change);
}

@end
