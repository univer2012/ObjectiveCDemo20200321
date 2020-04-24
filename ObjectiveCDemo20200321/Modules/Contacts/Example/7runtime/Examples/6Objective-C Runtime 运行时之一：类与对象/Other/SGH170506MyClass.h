//
//  SGH170506MyClass.h
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/6.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGH170506MyClass : NSObject<NSCopying, NSCoding>

@property(nonatomic,strong)NSArray *array;

@property(nonatomic, copy)NSString *string;
-(void)method1;
-(void)method2;
+(void)classMethod1;


@end
