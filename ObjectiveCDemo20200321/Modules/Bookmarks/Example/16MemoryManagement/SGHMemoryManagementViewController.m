//
//  SGHMemoryManagementViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/18.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHMemoryManagementViewController.h"

#import "SGHMemoryManagementViewController+MRC.h"

@interface SGHMemoryManagementViewController ()

@end

@implementation SGHMemoryManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeMethod;
    
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"1.自己生成的对象，自己持有",
        @"2.非自己生成的对象，自己也能持有",
        @"3.不再需要自己持有对象时释放（会崩溃）",
        @"4.无法释放 非自己持有的对象（会崩溃）",
        @"5.模拟类方法`array`的实现",
    ];
    NSArray *tempClassNameArray = @[
        @"sec1demo1",
        @"sec1demo2",
        @"sec1demo3",
        @"sec1demo4",
        @"sec1demo5",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"内存管理"];
    
    
    //MARK: section 2
    NSArray *tempTitleArray2 = @[
        @"1.实例化NSAutoreleasePool",
    ];
    NSArray *tempClassNameArray2 = @[
        @"sec2demo1",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray2 titleArray:tempTitleArray2 title:@"NSAutoreleasePool"];
    
    //MARK: section 3
    NSArray *tempTitleArray3 = @[
        @"1.使用`__bridge`，把NSString转为CFStringRef",
        @"2.使用`__bridge_retained`，将内存管理的责任由原来的 Objective-C 交给Core Foundation 来处理，也就是将 ARC 转变为 MRC。",
        @"3.使用`__bridge_transfer`，将管理的责任由 Core Foundation 转交给 Objective-C，即将管理方式由 MRC 转变为 ARC。",
    ];
    NSArray *tempClassNameArray3 = @[
        @"sec3demo1",
        @"sec3demo2",
        @"sec3demo3",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray3 titleArray:tempTitleArray3 title:@"Toll-Free Bridging"];
    
    
    [self.tableView reloadData];
    
    
    
    /*
     来自：[IOS 使代码在ARC和MRC环境编译通用](https://blog.csdn.net/weixin_30279751/article/details/97799105)
     */
#if __has_feature(objc_arc)
    // 下面写ARC代码
#else
    // 下面写MRC代码
    
#endif
    
}

//MARK: 3.使用`__bridge_transfer`，将管理的责任由 Core Foundation 转交给 Objective-C，即将管理方式由 MRC 转变为 ARC。
- (void)sec3demo3 {
    NSString *uncodeString = @"ABCDEFG";
    
    CFStringRef result = CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef) uncodeString,NULL,(CFStringRef) @"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
    
    NSString *s = (__bridge_transfer NSString *)result;
    //或者
    //NSString *s = (NSString *)CFBridgingRelease(result);
}

//MARK: 2.使用`__bridge_retained`，将内存管理的责任由原来的 Objective-C 交给Core Foundation 来处理，也就是将 ARC 转变为 MRC。
- (void)sec3demo2 {
    NSString *name = @"Sengoln Huang";
    NSString *s1 = [[NSString alloc] initWithFormat:@"Hello, %@!", name];
    
    CFStringRef s2 = (__bridge_retained CFStringRef)s1;
    // 或者
    //CFStringRef s2 = (CFStringRef)CFBridgingRetain(s1);
    
    // do something with s2
    //...
    
    CFRelease(s2); // 注意要在使用结束后加这个
}

//MARK: - section 3
//MARK: 1.使用`__bridge`，把NSString转为CFStringRef
- (void)sec3demo1 {
    NSString *name = @"Sengoln Huang";
    CFStringRef s1 = (__bridge CFStringRef) [[NSString alloc] initWithFormat:@"Hello, %@!", name];
    
    //CFRelease(s1);
    //只是做了 NSString 到 CFStringRef 的转化，但管理规则未变，
    //依然要用 Objective-C 类型的 ARC 来管理 s1，你不能用 CFRelease() 去释放 s1。
}

//MARK: 1.自己生成的对象，自己持有
- (void)sec1demo1 {
    // 使用了alloc分配了内存，obj指向了对象，该对象本身引用计数为1,不需要retain
    id obj = [[NSObject alloc] init];
    // 使用了new分配了内存,objc指向了对象，该对象本身引用计数为1，不需要retain
    id obj1 = [NSObject new];
}

@end
