//
//  SHKVOExploreViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/3.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHKVOExploreViewController.h"
#import "EOCFamily.h"

#import <objc/runtime.h>

@interface SHKVOExploreViewController () {
    EOCFamily *_eocFamily;
}

@end

@implementation SHKVOExploreViewController
/**
 NSOperation
 NSOperationQueue
 RAC
 
 KVO 观察者莫斯
 观察者，被观察的对象属性  移除观察者
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _eocFamily = [EOCFamily new];
    
    _eocFamily.name = @"EOC_Old";
    
    [_eocFamily addObserver:self forKeyPath:@"person" options:NSKeyValueObservingOptionNew context:nil];
    _eocFamily.person.age = @"11";
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *tempName = @"eoc";
    _eocFamily.name = tempName;
    NSLog(@"two:%p", _eocFamily.name);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"change:%@", change);
}
    


+ (NSArray *)findSubClass:(Class)defaultClass {
    int count = objc_getClassList(NULL, 0);
    if (count <= 0) {
        return [NSArray array];
    }
    NSMutableArray *output = [NSMutableArray arrayWithObject:defaultClass];
    Class *classes = (Class *)malloc(sizeof(Class) * count);
    objc_getClassList(classes, count);
    for (int i = 0; i < count; i++) {
        if (defaultClass == class_getSuperclass(classes[i])) {
            [output addObject:classes[i]];
        }
    }
    free(classes);
    return output;
}
    
@end
