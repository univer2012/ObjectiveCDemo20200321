//
//  SGHAboutKVOAndKVCViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/24.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHAboutKVOAndKVCViewController.h"

#import "SGH0324Person.h"
#import "SGH0324Observer.h"


@interface SGHAboutKVOAndKVCViewController ()


@end

@implementation SGHAboutKVOAndKVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.type = SHBaseTableTypeMethod;
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"1.探究KVO，用第三者来监听person.name的变化",
        @"2.通过手动调用，让成员变量也响应KVO",
    ];
    NSArray *tempClassNameArray = @[
        @"sec1demo1",
        @"sec1demo2",
    ];
    
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"KVO的原理探究"];
    
    //MARK: - section 2
    NSArray *tempTitleArray2 = @[
        @"1.kvo在a线程监听，b线程修改：会在b线程收到通知",
        @"2.NSNotificationCenter在a线程监听，b线程发送通知：会在b线程收到通知",
    ];
    NSArray *tempClassNameArray2 = @[
        @"sec2demo1",
        @"sec2demo2",
    ];
    
    [self addSectionDataWithClassNameArray:tempClassNameArray2 titleArray:tempTitleArray2 title:@"KVO与线程"];
    
    
    [self.tableView reloadData];
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notice) name:@"test" object:nil];
}
//MARK: 2.NSNotificationCenter在a线程监听，b线程发送通知：会在b线程收到通知
//来自：[iOS 通知和kvo中的线程问题](https://blog.csdn.net/qq_20037693/article/details/56280251)
- (void)sec2demo2 {
    [self performSelectorInBackground:@selector(noticeOnthread) withObject:nil];
}
 - (void)noticeOnthread {
     NSLog(@"在Background线程发送通知：%@", [NSThread currentThread]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:nil];
     /*output:
      在Background线程发送通知：<NSThread: 0x600001ae2800>{number = 8, name = (null)}
      */
}
 - (void)notice {
     NSLog(@"收到监听结果的线程：%@", [NSThread currentThread]);
     /*output:
      收到监听结果的线程：<NSThread: 0x600001ae2800>{number = 8, name = (null)}
     */
}

//MARK: 1.kvo在a线程监听，b线程修改：会在b线程收到通知
- (void)sec2demo1 {
    [self pushToNewVCWith:@"SGHABThreadKVOViewController" title:nil inBookmarkStoryboard:NO selText:nil];
}



//MARK: 2.手动调用`willChangeValueForKey:` 和 `didChangeValueForKey:`，让成员变量也响应KVO
- (void)sec1demo2 {
    
    SGH0324Observer *observer = [SGH0324Observer new];
    SGH0324Person *person = [[SGH0324Person alloc] init];
    
    [person addObserver:observer forKeyPath:@"littleName" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    person->littleName = @"Li mama"; //set default value
    
    [person willChangeValueForKey:@"littleName"];
    person->littleName = @"dragon mama";
    person->littleName = @"dragon mama";
    [person didChangeValueForKey:@"littleName"];
    
    [person removeObserver:observer forKeyPath:@"littleName" context:NULL];
}

//MARK: - section 1

//MARK: 1.探究KVO，用第三者来监听person.name的变化
- (void)sec1demo1 {
    /*
    * 来自：
    [KVO进阶（二）](https://www.jianshu.com/p/a8809c1eaecc)
    */
    
    SGH0324Observer *observer = [SGH0324Observer new];
    SGH0324Person *person = [[SGH0324Person alloc] init];
    [person addObserver:observer forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    person.name = @"Jack";
    person.name = @"Jack";
//        [person setValue:@"Jhon" forKey:@"name"];
//        [person changeName:@"Jiji"];
    
    [person removeObserver:observer forKeyPath:@"name" context:NULL];
}





@end
