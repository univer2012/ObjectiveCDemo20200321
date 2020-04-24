//
//  SGH04RACViewModel.h
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/4.
//  Copyright © 2020 远平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGH04RACViewModel : NSObject

@property (nonatomic, strong)NSString *userName;
@property (nonatomic, strong)NSString *password;
@property (nonatomic, strong) RACSubject *successObject;
@property (nonatomic, strong) RACSubject *failureObject;
@property (nonatomic, strong) RACSubject *errorObject;

- (id) buttonIsValid;
- (void)login;

@end

NS_ASSUME_NONNULL_END
