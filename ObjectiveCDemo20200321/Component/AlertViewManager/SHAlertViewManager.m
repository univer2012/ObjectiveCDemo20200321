//
//  SHAlertViewManager.m
//  ObjectiveCDemo160728
//
//  Created by sengoln huang on 2019/1/31.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHAlertViewManager.h"

#import <objc/runtime.h>

@interface SHAlertViewManager ()

@property(class,nonatomic,assign,readonly) BOOL hasTitleTextColor;

@end

@implementation SHAlertViewManager

//+ (instancetype)shareInstance {
//    static dispatch_once_t onceToken;
//    static XGAlertViewManager *shareInstance;
//    dispatch_once(&onceToken, ^{
//        shareInstance = [self new];
//    });
//    return shareInstance;
//}
//- (XGUpdateView *)updateView {
//    if (!_updateView) {
//        _updateView = [[XGUpdateView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        _updateView.delegate = self;
//        [UIView animateWithDuration:.25f delay:0.f usingSpringWithDamping:.6f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            _updateView.alpha = 1.0;
//            [[UIApplication sharedApplication].delegate.window addSubview:_updateView];
//        } completion:nil];
//    }
//    return _updateView;
//}
////MARK: XGUpdateViewDelegate
//- (void)updateView:(XGUpdateView *)updateView action:(XGUpdateAction)action updateStatus:(NSInteger)updateStatus {
//    kBlockSelf;
//    switch (action) {
//        case XGUpdateActionEnsure: {
//            self.ensureHander();
//            [UIView animateWithDuration:.25f delay:0.f usingSpringWithDamping:.6f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                blockSelf.updateView.alpha = 0.0;
//            } completion:^(BOOL finished) {
//                [blockSelf.updateView removeFromSuperview];
//                blockSelf.updateView = nil;
//            }];
//        }
//            break;
//        case XGUpdateActionCancel: {
//            self.cancelHander();
//            [UIView animateWithDuration:.25f delay:0.f usingSpringWithDamping:.6f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                blockSelf.updateView.alpha = 0.0;
//            } completion:^(BOOL finished) {
//                [blockSelf.updateView removeFromSuperview];
//                blockSelf.updateView = nil;
//            }];
//        }
//            break;
//    }
//}

//MARK: 方法类型
+ (void)alertViewWithModel:(SHAlertViewSetModel *)model controller:(UIViewController *)controller ensureHander:(void (^)(UIAlertAction *action))ensureHander cancelHander:(void (^)(UIAlertAction *action))cancelHander {
    //默认设置
    if (!model.title) {
        model.title = @"";
    }
    if (!model.message) {
        model.message = @"";
    }
    if (!model.ensureColor) {
        model.ensureColor = [UIColor colorWithRed:255.0/255.0 green:86.0/255.0 blue:55.0/255.0 alpha:1.0f];
    }
    if (!model.cancelColor) {
        model.cancelColor = [UIColor blackColor];
    }
    if (model.messageSize == 0.0) {
        model.messageSize = 16.0;
    }
    NSTextAlignment alignment = NSTextAlignmentLeft; //默认左对齐
    switch (model.alignment) {
        case SHAlertAlignmentCenter:
            alignment = NSTextAlignmentCenter;
            break;
        case SHAlertAlignmentRight:
            alignment = NSTextAlignmentRight;
            break;
        default:
            break;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:model.title message:model.message preferredStyle:UIAlertControllerStyleAlert];
    if (!model.isSystemDefault) {
        //修改message
        NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:model.message];
        //左对齐
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = alignment;
        
        NSDictionary *atti = @{NSFontAttributeName: [UIFont systemFontOfSize:model.messageSize], NSParagraphStyleAttributeName: paragraphStyle};
        [alertMessageStr addAttributes:atti range:NSMakeRange(0, model.message.length)];
        [alertController setValue:alertMessageStr forKey:@"_attributedMessage"];
    }
    
    //取消
    if (model.cancelTitle.length > 0) {
        UIAlertActionStyle style = UIAlertActionStyleDefault;//默认
        if (model.cancelStyle) {
            style = model.cancelStyle - 1;
        }
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:model.cancelTitle style:style handler:cancelHander];
        if (!model.isSystemDefault) {
            if (SHAlertViewManager.hasTitleTextColor) {
                [cancelAction setValue:model.cancelColor forKey:@"_titleTextColor"];
            }
        }
        [alertController addAction:cancelAction];
    }
    //确定
    if (model.ensureTitle.length > 0) {
        UIAlertActionStyle style = UIAlertActionStyleDestructive;//默认
        if (model.ensureStyle) {
            style = model.ensureStyle - 1;
        }
        UIAlertAction *ensureAction = [UIAlertAction actionWithTitle:model.ensureTitle style:style handler:ensureHander];//
        if (!model.isSystemDefault) {
            if (SHAlertViewManager.hasTitleTextColor) {
                [ensureAction setValue:model.ensureColor forKey:@"_titleTextColor"];
            }
        }
        [alertController addAction:ensureAction];
    }
    [controller presentViewController:alertController animated:YES completion:nil];
}

+ (BOOL)hasTitleTextColor {
     BOOL shareInstance = NO;
    unsigned int count;
    Ivar *ivars =  class_copyIvarList([UIAlertAction class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char * cName =  ivar_getName(ivar);
        NSString *ocName = [NSString stringWithUTF8String:cName];
        if ([ocName isEqualToString:@"_titleTextColor"]) {
            shareInstance = YES;
            break;
        }
    }
    free(ivars);
    return shareInstance;
    
#if 0
    static BOOL shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        unsigned int count;
        Ivar *ivars =  class_copyIvarList([UIAlertAction class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char * cName =  ivar_getName(ivar);
            NSString *ocName = [NSString stringWithUTF8String:cName];
            if ([ocName isEqualToString:@"_titleTextColor"]) {
                shareInstance = YES;
                break;
            }
        }
        free(ivars);
    });
    return shareInstance;
#endif
}


@end
