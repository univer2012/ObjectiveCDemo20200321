//
//  TKAesHelper.m
//  AESDemo
//
//  Created by huangaengoln on 16/6/14.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "TKAesHelper.h"

#import <CommonCrypto/CommonCryptor.h>
#define kCCBlockSizeAES128_16 16
#define kCCBlockSizeAES128_32 32

@implementation TKAesHelper



+(NSData *)dataWithAesEncryptData:(NSData *)data withKey:(NSString *)key
{
    if (data && data.length > 0 && (key != nil && ![key isEqualToString:@""]))
    {
        
        //[TKStringHelper isNotEmpty:key]
        int blockSize = (key.length > 16) ? kCCBlockSizeAES128_32 : kCCBlockSizeAES128_16;
        char keyPtr[blockSize + 1];
        bzero(keyPtr, sizeof(keyPtr));
        [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
        NSUInteger dataLength = [data length];
        size_t bufferSize = (dataLength + blockSize);
        void *buffer = malloc(bufferSize);
        size_t numBytesEncrypted = 0;
        CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                              kCCOptionPKCS7Padding | kCCOptionECBMode,
                                              keyPtr, blockSize,
                                              NULL,
                                              [data bytes], dataLength,
                                              buffer, bufferSize,
                                              &numBytesEncrypted);
        if (cryptStatus == kCCSuccess)
        {
            return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        }
        free(buffer);
        return [NSData data];
    }
    return [NSData data];
}

@end
