//
//  SGH170815IdentCodeAuthView.h
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/8/15.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGH170815IdentCodeAuthView : UIView
//字符素材数组
@property(strong,nonatomic)NSArray *dataArray;
//验证码字符串
@property(nonatomic,strong)NSMutableString *authCodeString;

@end
