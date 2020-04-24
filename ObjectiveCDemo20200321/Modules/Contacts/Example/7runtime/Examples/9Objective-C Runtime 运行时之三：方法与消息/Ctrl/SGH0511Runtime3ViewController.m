//
//  SGH0511Runtime3ViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/11.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0511Runtime3ViewController.h"
#import <objc/runtime.h>
#import "SGH0511RuntimeMethod.h"

@interface SGH0511Runtime3ViewController ()

@end

@implementation SGH0511Runtime3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self p_testSelector];
    
    //[self performSelector:@selector(method1)];
    
    [[SGH0511RuntimeMethod object]test];
    
}

/*============================================*/
void functionForMethod1(id self, SEL _cmd) {
    NSLog(@"%@, %p",self,_cmd);
}

+(BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selectorString = NSStringFromSelector(sel);
    if ([selectorString isEqualToString:@"method1"]) {
        class_addMethod(self.class, @selector(method1), (IMP)functionForMethod1, "@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
//-(void)method1 {
//    
//}
/*============================================*/

-(void)p_testMethodForSelector {
    NSArray *targetList = [NSArray array];
    void (*setter)(id, SEL, BOOL);
    int i;
    NSObject *target = [NSObject new];
    setter = (void (*)(id, SEL, BOOL))[target methodForSelector:@selector(setFilled:)];
    for (i = 0; i < 100; i++) {
        setter(targetList[i], @selector(setFilled:), YES);
    }
}
  

-(void)p_testSelector {
    SEL sel1 = @selector(method1);
    NSLog(@"sel: %p",sel1);
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
