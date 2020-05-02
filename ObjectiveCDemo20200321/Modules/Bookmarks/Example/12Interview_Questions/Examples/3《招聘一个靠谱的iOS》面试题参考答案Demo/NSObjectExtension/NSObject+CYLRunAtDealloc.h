//
//  NSObject+CYLRunAtDealloc.h
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/12/11.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYLBlockExecutor.h"

@interface NSObject (CYLRunAtDealloc)
- (void)cyl_runAtDealloc:(voidBlock)block;
@end
