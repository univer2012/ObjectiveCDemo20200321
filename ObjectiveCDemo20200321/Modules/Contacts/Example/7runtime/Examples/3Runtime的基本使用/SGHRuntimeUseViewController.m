//
//  SGHRuntimeUseViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/13.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHRuntimeUseViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface SGHRuntimeUseViewController ()

@end

@implementation SGHRuntimeUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = SHBaseTableTypeMethod;
    
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"1.获取UILabel类的所有属性和方法",
        @"2.利用`objc_msgSend(id self, SEL op, ...)`来实例化一个对象",
    ];
    NSArray *tempClassNameArray = @[
        @"sec1demo1",
        @"sec1demo2",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"Runtime 的使用"];
    
    [self.tableView reloadData];
}
//MARK: 2.利用`objc_msgSend(id self, SEL op, ...)`来实例化一个对象
- (void)sec1demo2 {
    // id 谁发送消息
    // SEL 发送什么消息
    // 在xcode6之后，苹果不推荐使用runtime
    id objc = objc_msgSend([NSObject class], @selector(alloc));
    objc = objc_msgSend(objc, @selector(init));
    
    //等价于：
    //NSObject *objc = [[NSObject alloc] init];
}


//MARK: - section 1
//MARK: 1.获取UILabel类的所有属性和方法
- (void)sec1demo1 {
    UILabel *label = [[UILabel alloc] init];
    //UIPanGestureRecognizer *label = [[UIPanGestureRecognizer alloc] init];
    NSLog(@"********所有变量/值:\n%@", [self getAllIvar:label]);
    NSLog(@"********所有属性:\n%@", [self getAllProperty:label]);
}

//获得所有变量
- (NSArray *)getAllIvar:(id)object
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
- (NSArray *)getAllProperty:(id)object
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



@end
