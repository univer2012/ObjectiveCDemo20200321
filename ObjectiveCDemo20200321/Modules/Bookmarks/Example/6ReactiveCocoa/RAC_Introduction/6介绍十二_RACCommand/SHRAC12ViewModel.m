//
//  SHRAC12ViewModel.m
//  ObjectiveCDemo160728
//
//  Created by Mac on 2019/12/22.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHRAC12ViewModel.h"

@implementation SHRAC12ViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        @weakify(self)
        self.priceSpreadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            @weakify(self)
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self)
                //NSLog(@"aldjfsjdofje ");
                NSLog(@"进行网络请求");
                [subscriber sendNext:@"请求处理完成"];
                //[subscriber sendNext:@(2)];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
        
        
        self.subscribeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSString * _Nullable input) {
            @strongify(self)
            NSLog(@"执行操作:%@__success",input);
            
            //return [RACSignal empty];
            //或者
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:@"OK"];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
        
        
    }
    return self;
}

@end
