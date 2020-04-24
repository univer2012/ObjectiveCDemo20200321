//
//  SHSortManager.h
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/4/22.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHSortManager : NSObject

//直接插入排序算法
- (void)insertSort:(NSMutableArray *)oriArray;

//起泡排序
- (void)bubbleSort:(NSMutableArray *)array;

@end

NS_ASSUME_NONNULL_END
