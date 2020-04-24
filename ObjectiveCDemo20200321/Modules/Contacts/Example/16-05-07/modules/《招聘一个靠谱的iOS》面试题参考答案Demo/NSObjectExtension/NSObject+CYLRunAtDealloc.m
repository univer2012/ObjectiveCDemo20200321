//
//  NSObject+CYLRunAtDealloc.m
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/12/11.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//
/**
 * 来自：
[《招聘一个靠谱的iOS》面试题参考答案](https://blog.csdn.net/csdn15150525313/article/details/47316239)
*/

#import "NSObject+CYLRunAtDealloc.h"
#import <objc/runtime.h>
const void *runAtDeallocBlockKey = &runAtDeallocBlockKey;
@implementation NSObject (CYLRunAtDealloc)
-(void)cyl_runAtDealloc:(voidBlock)block {
    if (block) {
        CYLBlockExecutor *executor = [[CYLBlockExecutor alloc] initWithBlock:block];
        objc_setAssociatedObject(self, runAtDeallocBlockKey, executor, OBJC_ASSOCIATION_RETAIN);
    }
}
@end
