//
//  SHDispatchMethodsViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/15.
//  Copyright © 2019 huangaengoln. All rights reserved.
//
//来自：[系统提供的dispatch方法](https://blog.csdn.net/iosdevtip/article/details/44589861)
#import "SHDispatchMethodsViewController.h"

@interface SHDispatchMethodsViewController ()

@end

@implementation SHDispatchMethodsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //为了方便地使用GCD，苹果提供了一些方法方便我们将block放在主线程或后台线程执行，或者延后执行。使用的例子如下所示：
    //后台执行：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //something
    });
    //主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        //something
    });
    //一次性执行：
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //code to bbe executed once
    });
    //延迟2秒执行：
    double delayInSeconds=2.0;
    dispatch_time_t popTime=dispatch_time(DISPATCH_TIME_NOW, delayInSeconds*NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        //code to be executed on the main queue after delay
    });
    
#if false   //FIXME:要执行这段代码，需要把Automatic Reference Counting设置为NO
    //dispatch_queue_t 也可以自己定义，如要自定义queue，可以用dispatch_queue_create方法，示例如下：
    dispatch_queue_t urls_queue=dispatch_queue_create("blog.devtang.com", NULL);
    dispatch_async(urls_queue, ^{
        //your code
    });
    dispatch_release(urls_queue);//MRC模式
#endif
    
    //另外，GCD还有一些高级用法，例如让后台两个线程并行执行，然后等两个线程都结束后，再汇总执行结果。这个可以用dispatch_group、dispatch_group_async和dispatch_group_notify来实现，示例如下：
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        //并行执行的线程一
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        //并行执行的线程二
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        //汇总结果
    });
    
    //-----------------11.2.3 修改block之外的变量
    //默认情况下，在程序块中访问的外部变量是复制过去的，即写操作不对原变量生效。但是你可以加上__block来让其写操作生效，示例代码如下：
    __block int a=0;
    void (^foo)(void)=^ {
        a=1;
    };
    foo();//这里，a的值被修改为1
    
    
    
    
}

@end
