//
//  Girl.m
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/12/1.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "Girl.h"

@interface Girl ()

@property (nonatomic, copy) NSString *littleName;   //小名

@end

@implementation Girl


+(void)load {
    NSLog(@"%s", __func__);
}
//+(void)initialize {
//    [super initialize];
//    NSLog(@"%s", __func__);
//}
- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%s", __func__);
    }
    return self;
}

- (void)setLittleName:(NSString *)littleName {
    NSLog(@"私有属性暴露成功!");
    _littleName = littleName;
}

///私有方法
- (void)runText {
    NSLog(@"分类暴露私有方法成功!!!");
}

@end
