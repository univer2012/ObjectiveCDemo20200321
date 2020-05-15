//
//  SGHABThreadKVOViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/15.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 来自：[KVO与线程的问题](https://m.meiwen.com.cn/subject/bdwmcqtx.html)
 */
#import "SGHABThreadKVOViewController.h"

#import "SGH0324Person.h"

@interface SGHABThreadKVOViewController ()

@property (nonatomic, strong)SGH0324Person *person;

@end

@implementation SGHABThreadKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.person = [[SGH0324Person alloc] init];
    NSLog(@"KVO在主线程监听");
    [_person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"监听结构的线程：%@", [NSThread currentThread]);
    NSLog(@"%d", _person.age);
    /*output:
     监听结构的线程：<NSThread: 0x6000026a0700>{number = 7, name = (null)}
     1
    */
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (@available(iOS 10.0, *)) {
        [NSThread detachNewThreadWithBlock:^{
            NSLog(@"在新线程修改：%@", [NSThread currentThread]);
            self.person.age ++;
            /*output:
             在新线程修改：<NSThread: 0x6000026a0700>{number = 7, name = (null)}
             */
        }];
    } else {
        // Fallback on earlier versions
    }
}

@end
