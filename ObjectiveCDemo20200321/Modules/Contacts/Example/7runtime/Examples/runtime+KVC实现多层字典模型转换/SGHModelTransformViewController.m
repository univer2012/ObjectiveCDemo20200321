//
//  SGHModelTransformViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/24.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 * 来自：
 [runtime+KVC实现多层字典模型转换（多层数据：模型嵌套模型，模型嵌套数组，数组嵌套模型）](https://www.jianshu.com/p/885b65688b96)
 */
#import "SGHModelTransformViewController.h"
#import "NSObject+EnumDictOneLevel.h"

#import "Status.h"
#import "PersonModel.h"

#import "UIViewController+Description.h"

@interface SGHModelTransformViewController ()

@property (nonatomic, copy) NSMutableArray *statuses;

@end

@implementation SGHModelTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showDescWith:@"运行起来后，打断点来查看转换的model是否一致。"];
    
#pragma mark - test for cm_modelWithDict1
//    NSDictionary *dict = @{
//                           @"iconStr":@"小明",
//                           @"showStr":@"这是我的第一条心情"
//                           };
//    PersonModel *testPerson = [PersonModel cm_modelWithDict1:dict];
//    // 测试数据
//    NSLog(@"%@",testPerson);

    
#pragma mark - test for NSObject+EnumDict
    // 解析Plist文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"statuses.plist" ofType:nil];
    NSDictionary *statusDict = [NSDictionary dictionaryWithContentsOfFile:filePath];

    // 获取字典数组
    NSArray *dictArr = statusDict[@"statuses"];
    NSMutableArray *statusArr = [NSMutableArray array];

    // 遍历字典数组
    for (NSDictionary *dict in dictArr) {

        Status *status = [Status cm_modelWithDict:dict];

        [statusArr addObject:status];
    }
    NSLog(@"%@",statusArr);

    
#pragma mark - test for NSObject+EnumArr
//    // 解析Plist文件
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"statuses.plist" ofType:nil];
//    NSDictionary *statusDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
//
//    // 获取字典数组
//    NSArray *dictArr = statusDict[@"statuses"];
//    _statuses = [NSMutableArray array];
//
//    // 遍历字典数组
//    for (NSDictionary *dict in dictArr) {
//
//        Status *status = [Status modelWithDict:dict];
//
//        [_statuses addObject:status];
//    }
//
//    NSLog(@"%@",_statuses);
       
}

@end
