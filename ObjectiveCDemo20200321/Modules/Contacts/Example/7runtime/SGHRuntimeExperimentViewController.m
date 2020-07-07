//
//  SGHRuntimeExperimentViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/24.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHRuntimeExperimentViewController.h"

@interface SGHRuntimeExperimentViewController ()

@end

@implementation SGHRuntimeExperimentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.type = SHBaseTableTypeNewVC;
    
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"6、Objective-C Runtime 运行时之一：类与对象",
        @"8、Objective-C Runtime 运行时之二：成员变量与属性",
        @"9、Objective-C Runtime 运行时之三：方法与消息",
        @"10、Objective-C Runtime 运行时之四：Method Swizzling",
        @"11、Objective-C Runtime 运行时之五：协议与分类",
        @"12、Objective-C Runtime 运行时之六：拾遗",
    ];
    NSArray *tempClassNameArray = @[
        @"SGH0506OCRuntime1ViewController",
        @"SGH0510Runtime2ViewController",
        @"SGH0511Runtime3ViewController",
        @"SGH0512Runtime4ViewController",
        @"SGH0512Runtime5ViewController",
        @"SGH0515Runtime6ViewController",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"Objective-C Runtime 运行时"];
    
    //MARK: section 2
    NSArray *tempTitleArray2 = @[
        @"14、Runtime方法的使用—Class篇",
        @"runtime获取私有属性强制更改私有属性以及获取私有方法",
        @"iOS runtime实战应用：Method Swizzling",
        @"runtime+KVC实现多层字典模型转换",
        @"3.Runtime的基本使用",
    ];
    NSArray *tempClassNameArray2 = @[
        @"SGH0515ClassViewController",
        @"SGHRuntimeAttriMethodViewController",
        @"SGHMethodSwizzlingViewController",
        @"SGHModelTransformViewController",
        @"SGHRuntimeUseViewController",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray2 titleArray:tempTitleArray2 title:@"Runtime 的使用"];
    
    [self.tableView reloadData];
}



@end
