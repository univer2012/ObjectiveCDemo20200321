//
//  SGHReferenceCycleViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/24.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHReferenceCycleViewController.h"



@interface Test : NSObject

@property (strong, nonatomic) id objc;

@end

@implementation Test

@end

//================================

@interface SGHReferenceCycleViewController ()

@end

@implementation SGHReferenceCycleViewController

#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    // 创建两个对象test1和test2
    Test *test1 = [Test new];
    Test *test2 = [Test new];

    // 互相引用对方
    test1.objc = test2;
    test2.objc = test1;
}

@end
