//
//  SHAlertViewManager.h
//  ObjectiveCDemo160728
//
//  Created by sengoln huang on 2019/1/31.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SHAlertViewSetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHAlertViewManager : NSObject



//+ (instancetype)shareInstance;

+ (void)alertViewWithModel:(SHAlertViewSetModel *)model controller:(UIViewController *)controller ensureHander:(void (^)(UIAlertAction *action))ensureHander cancelHander:(void (^)(UIAlertAction *action))cancelHander;

@end

NS_ASSUME_NONNULL_END
