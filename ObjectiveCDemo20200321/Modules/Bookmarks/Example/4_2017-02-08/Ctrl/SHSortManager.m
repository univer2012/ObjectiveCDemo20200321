//
//  SHSortManager.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/4/22.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHSortManager.h"

@implementation SHSortManager
//直接插入排序算法
- (void)insertSort:(NSMutableArray *)oriArray {
    NSUInteger n = oriArray.count;
    NSNumber *key;//哨兵
    for (int i=1; i<n; i++) {
        key = oriArray[i];//暂存待插关键码，设置哨兵
        int j = i - 1;
        while (j >= 0 && key.floatValue < [oriArray[j] floatValue]) {//寻找插入位置
            oriArray[j+1]=oriArray[j];//记录后移
            j--;
        }
        oriArray[j+1]=key;
    }
}
//起泡排序
- (void)bubbleSort:(NSMutableArray *)array {
    NSNumber *temp;
    NSUInteger exchange;//记录某趟最后一次交换的下标
    NSUInteger bound;//无序区的最后一个下标
    exchange = array.count - 1;
    while (exchange) {
        bound = exchange;
        exchange = 0;
        for (NSUInteger j = 0; j<bound; j++) {
            if ([array[j] floatValue] > [array[j+1] floatValue]) {
                temp = array[j];
                array[j] = array[j+1];
                array[j+1] = temp;
                exchange = j;
            }
        }
    }
}

@end
