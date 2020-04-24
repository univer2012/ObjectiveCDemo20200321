//
//  SGHRuntimeAttriMethodViewController.m
//  ObjectiveCDemo
//
//  Created by huangaengoln on 16/3/22.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHRuntimeAttriMethodViewController.h"
#import "SGHPerson.h"
#import <objc/runtime.h>

@interface SGHRuntimeAttriMethodViewController ()

@end

@implementation SGHRuntimeAttriMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SGHPerson *onePerson = [[SGHPerson alloc]init];
    NSLog(@"first time : %@",[onePerson description]);
    
    unsigned  int count = 0;
    Ivar *members = class_copyIvarList([SGHPerson class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar var = members[i];
        const char *memberAddress = ivar_getName(var);
        const char *memberType = ivar_getTypeEncoding(var);
        NSLog(@"address = %s ; type = %s",memberAddress,memberType);
    }
    
    //对私有变量的更改
    Ivar m_address = members[1];
    object_setIvar(onePerson, m_address, @"朝阳公园");
    NSLog(@"second time : %@",[onePerson description]);
    
    //控制私有函数
    [self private];
    //
    //    //添加新方法
    //    [self addFun];
}
- (void)private
{
    unsigned int count = 0;
    Method *memberFuncs = class_copyMethodList([SGHPerson class], &count);
    for (int i = 0; i < count; i++)
    {
        SEL address = method_getName(memberFuncs[i]);
        NSString *methodName = [NSString stringWithCString:sel_getName(address) encoding:NSUTF8StringEncoding];
        NSLog(@"member method : %@",methodName);
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
