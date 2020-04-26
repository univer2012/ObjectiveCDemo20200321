//
//  SHReactiveCocoaViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/15.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHReactiveCocoaViewController.h"
#import "SGHCellModel.h"

#pragma mark - controller
@interface SHReactiveCocoaViewController ()

@end

@implementation SHReactiveCocoaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"RAC Example";
    
    
    //section 1
    NSArray *tempClassNameArray=@[
        @"LxDBAnythingViewController",
        @"SGHTargetActionViewController",
        @"SGHGesturerViewController",
        @"SGHNotificationViewController",
        @"SGHSchedulerViewController",
        @"SGHSwitchDelegateViewController",
        @"SGHKVOViewController"
    ];
    NSArray *tempTitleArray=@[
        @"1、LxDBAnything Example",
        @"2、文本框响应事件",
        @"3、手势",
        @"4、通知(不需要removeObserver:)",
        @"5、定时器",
        @"6、替换代理(有局限，只能取代没有返回值的代理方法)",
        @"7、KVO"
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"基础"];
    
    //section 2
    tempClassNameArray=@[
        @"SGHSignalViewController",
        @"SGHMapViewController",
        @"SGHFilterViewController",
        @"SGHDelayViewController",
        @"SGHStartWithViewController",
        @"SGHTimeoutViewController",
        @"SGHTakeViewController",
        @"SGHSkipViewController",
        @"SGHTakeLastViewController",
        @"SGHTakeUntilViewController",
        @"SGHTakeWhileBlockViewController",
        @"SGHSkipWhileBlockViewController",
        @"SGHSkipUntilBlockViewController",
        @"SGHThrottleViewController",
        @"SGHDistinctUntilChangedViewController",
        @"SGHIgnoreViewController",
        @"SGHSwitchToLatestViewController",
        @"SGHRepeatViewController"
    ];
    tempTitleArray=@[
        @"1、信号订阅与接收",
        @"2、map映射",
        @"3、filter过滤",
        @"4、delay延迟",
        @"5、startWith",
        @"6、timeout:超时",
        @"7、take:",
        @"8、skip:",
        @"9、takeLast:",
        @"10、takeUntil",
        @"11、takeWhileBlock",
        @"12、skipWhileBlock",
        @"13、skipUntilBlock",
        @"14、throttle(即时搜索优化)",
        @"15、distinctUntilChanged(即时搜索优化改进1)",
        @"16、ignore(即时搜索优化改进2)",
        @"17、switchToLatest(即时搜索优化改进3)",
        @"18、repeat重复"
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"进阶(单个信号)"];
    
    //section 3
    tempClassNameArray=@[
        @"SGHMergeViewController",
        @"SGHCombineLatestReduceViewController",
        @"SGHConcatViewController",
        @"SGHZipwithViewController",
        @"SGHDefineRACViewController",
        @"SGHStopwatchViewController",
        @"SGHSumupViewController"
    ];
    tempTitleArray=@[
        @"1、merge合并",
        @"2、combineLatest:reduce:(还没写例子)",
        @"3、concat(一个异步请求完成后，再启动另一个)",
        @"4、zipWith:(多个异步请求都完成后，再做某件事)",
        @"5、宏RAC(TARGET,...)",
        @"6、用最少的代码写一个秒表",
        @"7、总结/大量使用RAC的写法"
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"多个信号"];
    
    //section 4
    tempClassNameArray=@[
        @"SHRAC1ViewController",
        @"SHRAC10ViewController",
        @"SHRAC12ViewController",
        @"SGH0401RACCommandViewController",
    ];
    tempTitleArray=@[
        @"2、介绍（一）——基本介绍",
        @"5、介绍十_RACMulticastConnection-多路广播",
        @"6、介绍十二_RACCommand",
        @"7、RACCommand的使用探究"
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"RAC介绍系列"];
    
    //section 5
    tempClassNameArray=@[
        @"SGH0404SequenceMapViewController",
    ];
    tempTitleArray=@[
        @"1、iOS开发之ReactiveCocoa下的MVVM-Demo",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"文章的demo"];
    
    
    self.inStoryboardVCArray = @[
        @"SHRAC1ViewController",
    ];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
