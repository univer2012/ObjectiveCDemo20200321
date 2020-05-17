//
//  SGHisaMan.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/15.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHisaMan.h"

#define Tall_Mask       (1<<2) //0b00000100 //此二进制数对应十进制数为 4
#define Rich_Mask       (1<<1) //0b00000010 //此二进制数对应十进制数为 2
#define Handsome_Mask   (1<<0) //0b00000001 //此二进制数对应十进制数为 1

@interface SGHisaMan ()
{
    char _tallRichHandsome;
}

@end

@implementation SGHisaMan

- (instancetype)init {
    if (self = [super init]) {
        _tallRichHandsome = 0b00000100;
    }
    return self;
}

//MAKR: setter方法
- (void)setTall:(BOOL)tall {
    if (tall) { // 如果需要将值置为1，将源码和掩码进行按位或运算
        _tallRichHandsome |= Tall_Mask;
    } else { // 如果需要将值置为0 // 将源码和按位取反后的掩码进行按位与运算
        _tallRichHandsome &= ~Tall_Mask;
    }
}
- (void)setRich:(BOOL)rich {
    if (rich) {
        _tallRichHandsome |= Rich_Mask;
    } else {
        _tallRichHandsome &= ~Rich_Mask;
    }
}
- (void)setHandsome:(BOOL)handsome {
    if (handsome) {
        _tallRichHandsome |= Handsome_Mask;
    } else {
        _tallRichHandsome &= ~Handsome_Mask;
    }
}

//MARK: getter方法
- (BOOL)isTall {
    return !!(_tallRichHandsome & Tall_Mask);
}
- (BOOL)isRich {
    return !!(_tallRichHandsome & Rich_Mask);
}
- (BOOL)isHandsome {
    return !!(_tallRichHandsome & Handsome_Mask);
}

@end


@implementation SGHisaMan2

- (void)setTall:(BOOL)tall {
    _tallRichHandsome.tall = tall;
}
- (BOOL)isTall {
    return !!_tallRichHandsome.tall;
}

- (void)setRich:(BOOL)rich {
    _tallRichHandsome.rich = rich;
}
- (BOOL)isRich {
    return !!_tallRichHandsome.rich;
}

- (void)setHandsome:(BOOL)handsome {
    _tallRichHandsome.handsome = handsome;
}
- (BOOL)isHandsome {
    return !!_tallRichHandsome.handsome;
}

@end


@implementation SGHisaMan3


- (void)setTall:(BOOL)tall {
    if (tall) {
        _tallRichHandsome.bits |= Tall_Mask;
    } else {
        _tallRichHandsome.bits &= ~Tall_Mask;
    }
}

- (void)setRich:(BOOL)rich {
    if (rich) {
        _tallRichHandsome.bits |= Rich_Mask;
    } else {
        _tallRichHandsome.bits &= ~Rich_Mask;
    }
}
- (void)setHandsome:(BOOL)handsome {
    if (handsome) {
        _tallRichHandsome.bits |= Handsome_Mask;
    } else {
        _tallRichHandsome.bits &= ~Handsome_Mask;
    }
}

- (BOOL)isTall {
    return !!(_tallRichHandsome.bits & Tall_Mask);
}
- (BOOL)isRich {
    return !!(_tallRichHandsome.bits & Rich_Mask);
}
- (BOOL)isHandsome {
    return !!(_tallRichHandsome.bits & Handsome_Mask);
}

@end
