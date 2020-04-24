//
//  SGH1012GetIvarAndPropertyViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/10/12.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH1012GetIvarAndPropertyViewController.h"
#import <objc/runtime.h>

@interface SGH1012GetIvarAndPropertyViewController ()

@end

@implementation SGH1012GetIvarAndPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIAlertView *alertView = [UIAlertView new];
    //id accessoryView = [alertView valueForKey:@"accessoryView"];
    //NSLog(@"accessoryView : %@",accessoryView);
    NSLog(@"********所有变量/值:\n%@", [self p_getAllIvar:alertView]);
    NSLog(@"********所有属性:\n%@", [self p_getAllProperty:alertView]);
    
}

//获得所有变量
- (NSArray *)p_getAllIvar:(id)object
{
    NSMutableArray *array = [NSMutableArray array];
    
    unsigned int count;
    Ivar *ivars = class_copyIvarList([object class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *keyChar = ivar_getName(ivar);
        NSString *keyStr = [NSString stringWithCString:keyChar encoding:NSUTF8StringEncoding];
        @try {
            id valueStr = [object valueForKey:keyStr];
            NSDictionary *dic = nil;
            if (valueStr) {
                dic = @{keyStr : valueStr};
            } else {
                dic = @{keyStr : @"值为nil"};
            }
            [array addObject:dic];
        }
        @catch (NSException *exception) {}
    }
    return [array copy];
}

//获得所有属性
- (NSArray *)p_getAllProperty:(id)object
{
    NSMutableArray *array = [NSMutableArray array];
    
    unsigned int count;
    objc_property_t *propertys = class_copyPropertyList([object class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertys[i];
        const char *nameChar = property_getName(property);
        NSString *nameStr = [NSString stringWithCString:nameChar encoding:NSUTF8StringEncoding];
        [array addObject:nameStr];
    }
    return [array copy];
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
