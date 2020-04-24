//
//  SGHSocket.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/8.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHSocket.h"

@implementation SGHSocket

+ (SGHSocket *)defaultSocket {
    static SGHSocket *socket = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socket = [[SGHSocket alloc] init];
    });
    return socket;
}

@end
