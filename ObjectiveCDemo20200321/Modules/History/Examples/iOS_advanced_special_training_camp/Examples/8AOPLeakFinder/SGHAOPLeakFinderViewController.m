//
//  SGHAOPLeakFinderViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/25.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHAOPLeakFinderViewController.h"
#import "UIViewController+LGLeaksTest.h"
#import "UINavigationController+LGLeaksTest.h"



@interface SGHAOPLeakFinderViewController ()

@property (nonatomic, copy) dispatch_block_t block;
@property (nonatomic, copy) NSString *str;

@end

@implementation SGHAOPLeakFinderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.str = @"hello";
    
    self.block = ^{
        NSLog(@"%@",self.str);
    };
    self.block();
    
    
}

- (void)dealloc
{
    NSLog(@"CurrentVC Dealloc");
}

@end
