//
//  SGHisaMan.h
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/15.
//  Copyright © 2020 远平. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface SGHisaMan : NSObject

@property (nonatomic, assign, getter = isTall) BOOL tall;
@property (nonatomic, assign, getter = isRich) BOOL rich;
@property (nonatomic, assign, getter = isHandsome) BOOL handsome;

@end

@interface SGHisaMan2 : NSObject
{
    //位域
    struct {
        char tall : 1;
        char rich : 1;
        char handsome : 1;
    } _tallRichHandsome;
}
@property (nonatomic, assign, getter = isTall) BOOL tall;
@property (nonatomic, assign, getter = isRich) BOOL rich;
@property (nonatomic, assign, getter = isHandsome) BOOL handsome;

@end

@interface SGHisaMan3 : NSObject
{
    union {
        char bits;
       // 结构体仅仅是为了增强代码可读性
        struct {
            char tall : 1;
            char rich : 1;
            char handsome : 1;
        };
    } _tallRichHandsome;
}

@property (nonatomic, assign, getter = isTall) BOOL tall;
@property (nonatomic, assign, getter = isRich) BOOL rich;
@property (nonatomic, assign, getter = isHandsome) BOOL handsome;

@end

NS_ASSUME_NONNULL_END
