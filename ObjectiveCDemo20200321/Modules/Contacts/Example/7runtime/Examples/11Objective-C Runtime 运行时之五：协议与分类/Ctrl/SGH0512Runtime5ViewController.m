//
//  SGH0512Runtime5ViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/12.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0512Runtime5ViewController.h"
#import <objc/runtime.h>

@interface SGH0512RuntimeCategoryClass : NSObject
-(void)method1;

@end

@interface SGH0512RuntimeCategoryClass (Cetegory)
-(void)method2;

@end

@implementation SGH0512RuntimeCategoryClass

-(void)method1 {
    
}
@end

@implementation SGH0512RuntimeCategoryClass (Cetegory)

-(void)method2 {
    
}

@end


@interface SGH0512Runtime5ViewController ()

@end

@implementation SGH0512Runtime5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"测试objc_class中的方法列表是否包含分类中的方法");
    unsigned int outCount = 0;
    Method *methodList = class_copyMethodList(SGH0512RuntimeCategoryClass.class, &outCount);
    
    for (int i = 0; i < outCount; i++) {
        Method method = methodList[i];
        
        const char *name = sel_getName(method_getName(method));
        NSLog(@"SGH0512RuntimeCategoryClass's method: %s", name);
        if (strcmp(name, sel_getName(@selector(method2)))) {
            NSLog(@"分类方法method2在objc_class的方法列表中");
        }
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
