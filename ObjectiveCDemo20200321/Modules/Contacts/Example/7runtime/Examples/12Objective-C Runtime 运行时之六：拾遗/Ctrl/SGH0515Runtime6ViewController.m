//
//  SGH0515Runtime6ViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/15.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0515Runtime6ViewController.h"
#import <objc/runtime.h>

@interface SGH0515MyClass : NSObject

@end

@implementation SGH0515MyClass

-(void)test {
    NSLog(@"self class: %@", self.class);
    NSLog(@"super class: %@", super.class);
}

@end
//--------------------------------------------
@interface SGH0515MyRuntimeBlock : NSObject

@end

@implementation SGH0515MyRuntimeBlock

@end


//--------------------------------------------


//--------------------------------------------

@interface SGH0515Runtime6ViewController ()

@end

@implementation SGH0515Runtime6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[[SGH0515MyClass new] test];
    
    //[self p_librariesProcessing];
    
    [self p_blockProcessing];
    
    
}

-(void)p_blockProcessing {
    //测试代码
    IMP imp = imp_implementationWithBlock(^(id obj, NSString *str){
        NSLog(@"%@", str);
    });
    class_addMethod(SGH0515MyRuntimeBlock.class, @selector(testBlock:), imp, "v@:@");
    SGH0515MyRuntimeBlock *runtime = [[SGH0515MyRuntimeBlock alloc]init];
    [runtime performSelector:@selector(testBlock:) withObject:@"hello world!"];
}

-(void)p_librariesProcessing {
    NSLog(@"获取指定类所在动态库");
    NSLog(@"UIView's Framework: %s", class_getImageName(NSClassFromString(@"UIView")));
    
    NSLog(@"获取指定库或框架中所有类的类名");
    unsigned int outCount;
    const char ** classes = objc_copyClassNamesForImage(class_getImageName(NSClassFromString(@"UIView")), &outCount);
    for (int i = 0; i < outCount; i++) {
        NSLog(@"class name: %s", classes[i]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
