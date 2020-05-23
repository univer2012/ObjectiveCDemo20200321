//
//  UIView+NeastPublicView.m
//  ObjectiveCDemo
//
//  Created by Mac on 2020/4/30.
//  Copyright © 2020 远平. All rights reserved.
//

#import "UIView+NeastPublicView.h"

@implementation UIView (NeastPublicView)


///方法3：还可以使用类似归并排序的思想，用两个「指针」，分别指向两个路径的根节点，
///然后从根节点开始，找第一个不同的节点，第一个不同节点的上一个公共节点，就是我们的答案。
/* O(N) Solution */
+ (UIView *)commonView_3:(UIView *)viewA andView:(UIView *)viewB {
    NSArray *arr1 = [self superViews:viewA];
    NSArray *arr2 = [self superViews:viewB];
    NSInteger p1 = arr1.count - 1;
    NSInteger p2 = arr2.count - 1;
    UIView *answer = nil;
    while (p1 >= 0 && p2 >= 0) {
        if (arr1[p1] == arr2[p2]) {
            answer = arr1[p1];
        }
        p1--;
        p2--;
    }
    return answer;
}

///方法2：改进的办法：我们将一个路径中的所有点先放进 NSSet 中。
///因为 NSSet 的内部实现是一个 hash 表，所以查找元素的时间复杂度变成了 O（1），
///我们一共有 N 个节点，所以总时间复杂度优化到了 O（N）。
+ (UIView *)commonView_2:(UIView *)viewA andView:(UIView *)viewB {
    NSArray *arr1 = [self superViews:viewA];
    NSArray *arr2 = [self superViews:viewB];
    NSSet *set = [NSSet setWithArray:arr2];
    for (NSUInteger i = 0; i < arr1.count; ++i) {
        UIView *targetView = arr1[i];
        if ([set containsObject:targetView]) {
            return targetView;
        }
    }
    return nil;
}

///方法1：拿第一个路径中的所有节点，去第二个节点中查找。假设路径的平均长度是 N，
///因为每个节点都要找 N 次，一共有 N 个节点，所以这个办法的时间复杂度是 O（N^2）。
+ (UIView *)commonView_1:(UIView *)viewA andView:(UIView *)viewB {
    NSArray *arr1 = [self superViews:viewA];//arr1是从叶子结点到根结点的 路径数组
    NSArray *arr2 = [self superViews:viewB];//arr1是从叶子结点到根结点的 路径数组
    for (NSUInteger i = 0; i < arr1.count; ++i) {
        UIView *targetView = arr1[i];
        for (NSUInteger j = 0; j < arr2.count; ++j) {
            if (targetView == arr2[j]) {
                return targetView;
            }
        }
    }
    return nil;
}

+ (NSArray *)superViews:(UIView *)view {
    if (view == nil) {
        return @[];
    }
    NSMutableArray *result = [NSMutableArray array];
    while (view != nil) {
        [result addObject:view];
        view = view.superview;
    }
    return [result copy];
    /* 返回的是  从叶子到根结点的路径  数组
     <__NSArrayM 0x6000014f4120>(
     <UIView: 0x7fd8d60308f0; frame = (0 0; 0 0); tag = 4; layer = <CALayer: 0x600001a29360>>,
     <UIView: 0x7fd8d600a9b0; frame = (0 0; 0 0); tag = 3; layer = <CALayer: 0x600001a29c20>>,
     <UIView: 0x7fd8d6031450; frame = (0 0; 0 0); tag = 2; layer = <CALayer: 0x600001a29aa0>>,
     <UIView: 0x7fd8d602e020; frame = (0 0; 0 0); tag = 1; layer = <CALayer: 0x600001a298e0>>,
     <UIView: 0x7fd8d551b0f0; frame = (0 0; 414 896); autoresize = W+H; layer = <CALayer: 0x600001a24600>>,
     <UIViewControllerWrapperView: 0x7fd8d5545dd0; frame = (0 0; 414 896); autoresize = W+H; layer = <CALayer: 0x600001a06240>>,
     <UINavigationTransitionView: 0x7fd8d540f1c0; frame = (0 0; 414 896); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x600001abee00>>,
     <UILayoutContainerView: 0x7fd8d5513ef0; frame = (0 0; 414 896); clipsToBounds = YES; autoresize = W+H; gestureRecognizers = <NSArray: 0x6000014d2970>; layer = <CALayer: 0x600001ae7f00>>,
     <UIViewControllerWrapperView: 0x7fd8d55327a0; frame = (0 0; 414 896); autoresize = W+H; layer = <CALayer: 0x600001af1200>>,
     <UITransitionView: 0x7fd8d5510900; frame = (0 0; 414 896); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x600001ae7d00>>,
     <UILayoutContainerView: 0x7fd8d540d5f0; frame = (0 0; 414 896); autoresize = W+H; layer = <CALayer: 0x600001abe620>>,
     <UIDropShadowView: 0x7fd8d6019780; frame = (0 0; 414 896); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x600001ae28a0>>,
     <UITransitionView: 0x7fd8d6019200; frame = (0 0; 414 896); autoresize = W+H; layer = <CALayer: 0x600001ae26e0>>,
     <UIWindow: 0x7fd8d551ebf0; frame = (0 0; 414 896); gestureRecognizers = <NSArray: 0x6000014e5860>; layer = <UIWindowLayer: 0x600001ae6880>>
     )
     */
}

@end
