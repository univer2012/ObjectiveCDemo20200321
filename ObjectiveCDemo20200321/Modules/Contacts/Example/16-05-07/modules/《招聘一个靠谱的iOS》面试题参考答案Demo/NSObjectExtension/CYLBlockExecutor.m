//
//  CYLBlockExecutor.m
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/12/11.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//
/**
 * 来自：
[《招聘一个靠谱的iOS》面试题参考答案](https://blog.csdn.net/csdn15150525313/article/details/47316239)
*/

#import "CYLBlockExecutor.h"
@interface CYLBlockExecutor() {
    voidBlock _block;
}
@end

@implementation CYLBlockExecutor
-(id)initWithBlock:(voidBlock)aBlock {
    self = [super init];
    if (self) {
        _block = [aBlock copy];
    }
    return self;
}
-(void)dealloc {
    _block ? _block() : nil;
}
@end
