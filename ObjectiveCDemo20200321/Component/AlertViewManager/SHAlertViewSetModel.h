//
//  SHAlertViewSetModel.h
//  ObjectiveCDemo160728
//
//  Created by sengoln huang on 2019/1/31.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SHAlertAlignmentLeft = 0,
    SHAlertAlignmentCenter,
    SHAlertAlignmentRight,
} SHAlertMessageAlignment;

typedef enum : NSUInteger {
    SHAlertMessageActionStyleDefault = 1,
    SHAlertMessageActionStyleCancel,
    SHAlertMessageActionStyleDestructive,
} SHAlertMessageActionStyle;

NS_ASSUME_NONNULL_BEGIN

@interface SHAlertViewSetModel : NSObject

@property(nonatomic, copy)NSString *title;  //默认为@""
@property(nonatomic, copy)NSString *message; //默认为@""
@property(nonatomic, copy)NSString *ensureTitle; //默认为@""  位置在右边
@property(nonatomic, copy)NSString *cancelTitle; //默认为@""  位置在左边

@property(nonatomic, strong)UIColor *ensureColor; //默认为HEXCOLOR(0xff5637)
@property(nonatomic, strong)UIColor *cancelColor;  //默认为 [UIColor blackColor]
@property(nonatomic, strong)UIColor *messageColor;
@property(nonatomic, strong)UIColor *titleColor;

@property(nonatomic, assign)SHAlertMessageActionStyle cancelStyle;
@property(nonatomic, assign)SHAlertMessageActionStyle ensureStyle; //默认UIAlertActionStyleDestructive

@property(nonatomic, assign)CGFloat messageSize;//默认16.0f
@property(nonatomic, assign)SHAlertMessageAlignment alignment;//默认左对齐
@property(nonatomic, assign)BOOL isSystemDefault;//是否是系统默认的UIAlertController,默认为NO

@end

NS_ASSUME_NONNULL_END
