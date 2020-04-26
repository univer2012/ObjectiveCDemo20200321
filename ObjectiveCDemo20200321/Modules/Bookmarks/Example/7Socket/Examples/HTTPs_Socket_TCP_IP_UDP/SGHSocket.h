//
//  SGHSocket.h
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/8.
//  Copyright © 2020 远平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

NS_ASSUME_NONNULL_BEGIN

@interface SGHSocket : NSObject

@property (nonatomic, strong) GCDAsyncSocket *mySocket;

+ (SGHSocket *)defaultSocket;

@end

NS_ASSUME_NONNULL_END
