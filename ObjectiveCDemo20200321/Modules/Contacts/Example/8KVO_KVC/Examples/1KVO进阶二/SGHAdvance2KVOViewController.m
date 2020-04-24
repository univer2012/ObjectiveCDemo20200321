//
//  SGHAdvance2KVOViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/24.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 * 来自：
 [KVO进阶（二）](https://www.jianshu.com/p/a8809c1eaecc)
 */
#import "SGHAdvance2KVOViewController.h"
#import "SGH0324Person.h"
#import "SGH0324Observer.h"

#import "UIViewController+Description.h"

@interface SGHAdvance2KVOViewController ()

@end

@implementation SGHAdvance2KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SGH0324Observer *observer = [SGH0324Observer new];
    SGH0324Person *person = [[SGH0324Person alloc]init];
    [person addObserver:observer forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    person.name=@"Jack";
    person.name=@"Jack";
//        [person setValue:@"Jhon" forKey:@"name"];
//        [person changeName:@"Jiji"];
    
    [person removeObserver:observer forKeyPath:@"name" context:NULL];
    
    
    
    ///文字说明
    [self showDescWith:@"请查看控制台的日志打印"];
}


@end
