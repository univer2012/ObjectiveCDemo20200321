//
//  SHRAC12ViewModel.h
//  ObjectiveCDemo160728
//
//  Created by Mac on 2019/12/22.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHRAC12ViewModel : NSObject

@property (nonatomic, strong) RACCommand *priceSpreadCommand;

@property (nonatomic, strong) RACCommand *subscribeCommand; //订阅长链接

@end

NS_ASSUME_NONNULL_END
