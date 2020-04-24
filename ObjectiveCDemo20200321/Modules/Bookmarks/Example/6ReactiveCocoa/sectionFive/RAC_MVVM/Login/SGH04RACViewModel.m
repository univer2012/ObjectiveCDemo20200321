//
//  SGH04RACViewModel.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/4.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGH04RACViewModel.h"

@interface SGH04RACViewModel ()
@property (nonatomic, strong) RACSignal *userNameSignal;
@property (nonatomic, strong) RACSignal *passwordSignal;
@property (nonatomic, strong) NSArray *requestData;

@end

@implementation SGH04RACViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _userNameSignal = RACObserve(self, userName);
    _passwordSignal = RACObserve(self, password);
    _successObject = [RACSubject subject];
    _failureObject = [RACSubject subject];
    _errorObject = [RACSubject subject];
}

//合并两个输入框信号，并返回按钮bool类型的值
- (id) buttonIsValid {
    
    RACSignal *isValid = [RACSignal combineLatest:@[_userNameSignal, _passwordSignal] reduce:^id(NSString *userName, NSString *password){
        
        return @(userName.length >= 3 && password.length >= 3);
    }];
    
    return isValid;
}

- (void)login {
    
    //网络请求进行登录
    _requestData = @[_userName, _password];
    
    //成功发送成功的信号
    [_successObject sendNext:_requestData];
    
    //业务逻辑失败和网络请求失败发送fail或者error信号并传参

}

@end
