//
//  SGHDeviceManager.m
//  ObjectiveC
//
//  Created by sengoln huang on 2019/1/31.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SGHDeviceManager.h"

#import <sys/sysctl.h>
//判断网络类型
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <UIKit/UIKit.h>
#import <netinet/in.h>

@implementation SGHDeviceManager

/**
 *  根据标志符得到设备系统相关信息
 *
 *  @param typeSpecifier 标志符号
 *
 *  @return 系统信息
 */
+(NSString *) getSysInfoByName:(char *)typeSpecifier {
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

/**
 *  获取系统设备平台(系统自带的，没经过处理翻译)
 *
 *  @return 系统设备平台
 */
+(NSString *)getDevicePlatform {
    return [SGHDeviceManager getSysInfoByName:"hw.machine"];
}

/**
 *  获取平台类型
 *
 *  @return 获取平台类型
 */
//+(SGHDevicePlatform)getDevicePlatformType
+ (SGHDevicePlatform)devicePlatformType {
    NSString *platform = [SGHDeviceManager getDevicePlatform];
    
    // The ever mysterious iFPGA
    if ([platform isEqualToString:@"iFPGA"])        return SGHDeviceIFPGA;
    
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])    return SGHDevice_iPhone1G;
    if ([platform isEqualToString:@"iPhone1,2"])    return SGHDevice_iPhone3G;
    
    if ([platform hasPrefix:@"iPhone2"])            return SGHDevice_iPhone3GS;
    
    if ([platform hasPrefix:@"iPhone3"])            return SGHDevice_iPhone4;
    
    if ([platform hasPrefix:@"iPhone4"])            return SGHDevice_iPhone4S;
    
    if ([platform hasPrefix:@"iPhone5,1"])          return SGHDevice_iPhone5;
    if ([platform hasPrefix:@"iPhone5,2"])          return SGHDevice_iPhone5;
    if ([platform hasPrefix:@"iPhone5,3"])          return SGHDevice_iPhone5C;
    if ([platform hasPrefix:@"iPhone5,4"])          return SGHDevice_iPhone5C;
    
    if ([platform hasPrefix:@"iPhone6,1"])          return SGHDevice_iPhone5S;
    if ([platform hasPrefix:@"iPhone6,2"])          return SGHDevice_iPhone5S;
    
    if ([platform hasPrefix:@"iPhone7,1"])          return SGHDevice_iPhone6Plus;
    if ([platform hasPrefix:@"iPhone7,2"])          return SGHDevice_iPhone6;
    
    if ([platform hasPrefix:@"iPhone8,1"])          return SGHDevice_iPhone6S;
    if ([platform hasPrefix:@"iPhone8,2"])          return SGHDevice_iPhone6SPlus;
    if ([platform hasPrefix:@"iPhone8,3"])          return SGHDevice_iPhoneSE;
    if ([platform hasPrefix:@"iPhone8,4"])          return SGHDevice_iPhoneSE;
    
    if ([platform hasPrefix:@"iPhone9,1"])          return SGHDevice_iPhone7;
    if ([platform hasPrefix:@"iPhone9,2"])          return SGHDevice_iPhone7Plus;
    if ([platform hasPrefix:@"iPhone9,3"])          return SGHDevice_iPhone7;
    if ([platform hasPrefix:@"iPhone9,4"])          return SGHDevice_iPhone7Plus;
    
    if ([platform hasPrefix:@"iPhone10,1"])          return SGHDevice_iPhone8;
    if ([platform hasPrefix:@"iPhone10,2"])          return SGHDevice_iPhone8Plus;
    if ([platform hasPrefix:@"iPhone10,3"])          return SGHDevice_iPhoneX;
    if ([platform hasPrefix:@"iPhone10,4"])          return SGHDevice_iPhone8;
    if ([platform hasPrefix:@"iPhone10,5"])          return SGHDevice_iPhone8Plus;
    if ([platform hasPrefix:@"iPhone10,6"])          return SGHDevice_iPhoneX;
    
    if ([platform isEqualToString:@"iPhone11,2"]) return SGHDevice_iPhoneXS;
    if ([platform isEqualToString:@"iPhone11,4"]) return SGHDevice_iPhoneXSMax;
    if ([platform isEqualToString:@"iPhone11,6"]) return SGHDevice_iPhoneXSMax;
    if ([platform isEqualToString:@"iPhone11,8"]) return SGHDevice_iPhoneXR;
    
    // iPod
    if ([platform hasPrefix:@"iPod1"])              return SGHDevice_iPod1G;
    if ([platform hasPrefix:@"iPod2"])              return SGHDevice_iPod2G;
    if ([platform hasPrefix:@"iPod3"])              return SGHDevice_iPod3G;
    if ([platform hasPrefix:@"iPod4"])              return SGHDevice_iPod4G;
    if ([platform hasPrefix:@"iPod5"])              return SGHDevice_iPod5G;
    if ([platform hasPrefix:@"iPod6"])              return SGHDevice_iPod6G;
    if ([platform hasPrefix:@"iPod7"])              return SGHDevice_iPod7G;
    if ([platform hasPrefix:@"iPod8"])              return SGHDevice_iPod8G;
    if ([platform hasPrefix:@"iPod9"])              return SGHDevice_iPod9G;
    
    // iPad
    if ([platform hasPrefix:@"iPad1"])              return SGHDevice_iPad1G;
    if ([platform hasPrefix:@"iPad2"])              return SGHDevice_iPad2G;
    if ([platform hasPrefix:@"iPad3"])              return SGHDevice_iPad3G;
    if ([platform hasPrefix:@"iPad4"])              return SGHDevice_iPad4G;
    if ([platform hasPrefix:@"iPad5"])              return SGHDevice_iPad5G;
    if ([platform hasPrefix:@"iPad6"])              return SGHDevice_iPad6G;
    if ([platform hasPrefix:@"iPad7"])              return SGHDevice_iPad7G;
    if ([platform hasPrefix:@"iPad8"])              return SGHDevice_iPad8G;
    if ([platform hasPrefix:@"iPad9"])              return SGHDevice_iPad9G;
    
    // Apple TV
    if ([platform hasPrefix:@"AppleTV2"])           return SGHDeviceAppleTV2;
    if ([platform hasPrefix:@"AppleTV3"])           return SGHDeviceAppleTV3;
    
    if ([platform hasPrefix:@"iPhone"])             return SGHDeviceUnknowniPhone;
    if ([platform hasPrefix:@"iPod"])               return SGHDeviceUnknowniPod;
    if ([platform hasPrefix:@"iPad"])               return SGHDeviceUnknowniPad;
    if ([platform hasPrefix:@"AppleTV"])            return SGHDeviceUnknownAppleTV;
    
    // Simulator thanks Jordan Breeding
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"]) {
        BOOL smallerScreen = [[UIScreen mainScreen] bounds].size.width < 768;
        return smallerScreen ? SGHDeviceSimulatoriPhone : SGHDeviceSimulatoriPad;
    }
    
    return SGHDeviceUnknown;
}

///获取平台类型的字符串
//+ (NSString *)getDevicePlatformTypeString {
+ (NSString *)devicePlatformTypeString {
    NSString *platform = [SGHDeviceManager getDevicePlatform];
    
    // The ever mysterious iFPGA
    if ([platform isEqualToString:@"iFPGA"])        return @"iFPGA";
    
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    
    if ([platform hasPrefix:@"iPhone2"])            return @"iPhone 3GS";
    
    if ([platform hasPrefix:@"iPhone3"])            return @"iPhone 4";
    
    if ([platform hasPrefix:@"iPhone4"])            return @"iPhone 4S";
    
    if ([platform hasPrefix:@"iPhone5,1"])          return @"iPhone 5";
    if ([platform hasPrefix:@"iPhone5,2"])          return @"iPhone 5";
    if ([platform hasPrefix:@"iPhone5,3"])          return @"iPhone 5C";
    if ([platform hasPrefix:@"iPhone5,4"])          return @"iPhone 5C";
    
    if ([platform hasPrefix:@"iPhone6,1"])          return @"iPhone 5S";
    if ([platform hasPrefix:@"iPhone6,2"])          return @"iPhone 5S";
    
    if ([platform hasPrefix:@"iPhone7,1"])          return @"iPhone 6 Plus";
    if ([platform hasPrefix:@"iPhone7,2"])          return @"iPhone 6";
    
    if ([platform hasPrefix:@"iPhone8,1"])          return @"iPhone 6S";
    if ([platform hasPrefix:@"iPhone8,2"])          return @"iPhone 6S Plus";
    if ([platform hasPrefix:@"iPhone8,3"])          return @"iPhone SE";
    if ([platform hasPrefix:@"iPhone8,4"])          return @"iPhone SE";
    
    if ([platform hasPrefix:@"iPhone9,1"])          return @"iPhone 7";
    if ([platform hasPrefix:@"iPhone9,2"])          return @"iPhone 7 Plus";
    if ([platform hasPrefix:@"iPhone9,3"])          return @"iPhone 7";
    if ([platform hasPrefix:@"iPhone9,4"])          return @"iPhone 7 Plus";
    
    if ([platform hasPrefix:@"iPhone10,1"])          return @"iPhone 8";
    if ([platform hasPrefix:@"iPhone10,2"])          return @"iPhone 8 Plus";
    if ([platform hasPrefix:@"iPhone10,3"])          return @"iPhone X";
    if ([platform hasPrefix:@"iPhone10,4"])          return @"iPhone 8";
    if ([platform hasPrefix:@"iPhone10,5"])          return @"iPhone 8 Plus";
    if ([platform hasPrefix:@"iPhone10,6"])          return @"iPhone X";
    
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    
    // iPod
    if ([platform hasPrefix:@"iPod1"])              return @"iPod 1G";
    if ([platform hasPrefix:@"iPod2"])              return @"iPod 2G";
    if ([platform hasPrefix:@"iPod3"])              return @"iPod 3G";
    if ([platform hasPrefix:@"iPod4"])              return @"iPod 4G";
    if ([platform hasPrefix:@"iPod5"])              return @"iPod 5G";
    if ([platform hasPrefix:@"iPod6"])              return @"iPod 6G";
    if ([platform hasPrefix:@"iPod7"])              return @"iPod 7G";
    if ([platform hasPrefix:@"iPod8"])              return @"iPod 8G";
    if ([platform hasPrefix:@"iPod9"])              return @"iPod 9G";
    
    // iPad
    if ([platform hasPrefix:@"iPad1"])              return @"iPad 1G";
    if ([platform hasPrefix:@"iPad2"])              return @"iPad 2G";
    if ([platform hasPrefix:@"iPad3"])              return @"iPad 3G";
    if ([platform hasPrefix:@"iPad4"])              return @"iPad 4G";
    if ([platform hasPrefix:@"iPad5"])              return @"iPad 5G";
    if ([platform hasPrefix:@"iPad6"])              return @"iPad 6G";
    if ([platform hasPrefix:@"iPad7"])              return @"iPad 7G";
    if ([platform hasPrefix:@"iPad8"])              return @"iPad 8G";
    if ([platform hasPrefix:@"iPad9"])              return @"iPad 9G";
    
    // Apple TV
    if ([platform hasPrefix:@"AppleTV2"])           return @"AppleTV 2";
    if ([platform hasPrefix:@"AppleTV3"])           return @"AppleTV 3";
    
    if ([platform hasPrefix:@"iPhone"])             return @"Unknown iPhone";
    if ([platform hasPrefix:@"iPod"])               return @"Unknown iPod";
    if ([platform hasPrefix:@"iPad"])               return @"Unknown iPad";
    if ([platform hasPrefix:@"AppleTV"])            return @"Unknown AppleTV";
    
    // Simulator thanks Jordan Breeding
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"]) {
        BOOL smallerScreen = [[UIScreen mainScreen] bounds].size.width < 768;
        return smallerScreen ? @"Simulator iPhone" : @"Simulator iPad";
    }
    return @"Unknown";
}

//获取屏幕尺寸类型
//+ (SGHDeviceScreenSize)getDeviceScreenSize {
+ (SGHDeviceScreenSize)deviceScreenSize {
    CGSize size = [UIScreen mainScreen].bounds.size;
    if (size.width == 320 && size.height == 480) {
        return SGHDeviceScreenSize3_5;
    }
    else if (size.width == 320 && size.height == 568) {
        return SGHDeviceScreenSize4;
    }
    else if (size.width == 375 && size.height == 667) {
        return SGHDeviceScreenSize4_7;
    }
    else if (size.width == 414 && size.height == 736) {
        return SGHDeviceScreenSize5_5;
    }
    else if (size.width == 375 && size.height == 812) {
        return SGHDeviceScreenSize5_8;
    }
    else if (size.width == 414 && size.height == 896) {
        switch (SGHDeviceManager.devicePlatformType) {
            case SGHDevice_iPhoneXR: {
                return SGHDeviceScreenSize6_1;
            }
                break;
            case SGHDevice_iPhoneXSMax: {
                return SGHDeviceScreenSize6_5;
            }
                break;
            default: {
                return SGHDeviceScreenSize6_5;
                //return SGHDeviceScreenSize6_1;
            }
                break;
        }
    }
    return SGHDeviceScreenSize5_8;
}


//获取当前网络类型
+ (SGHNetWorkStatus)getCurrentNetworkStatusWithHostName:(NSString *)hostName {
    //    SCNetworkReachabilityRef reachabilityRef;
    SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithName(NULL, [hostName UTF8String]);
    SGHNetWorkStatus returnValue = SGHNetWorkStatusNotReachable;
    SCNetworkReachabilityFlags flags;
    if (SCNetworkReachabilityGetFlags(reachabilityRef, &flags))
    {
        if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
        {
            // The target host is not reachable.
            return SGHNetWorkStatusNotReachable;
        }
        
        //SGHNetWorkStatus returnValue = SGHNetWorkStatusNotReachable;
        if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
        {
            /*
             If the target host is reachable and no connection is required then we'll assume (for now) that you're on Wi-Fi...
             */
            returnValue = SGHNetWorkStatusWiFi;
        }
        
        if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
             (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
        {
            /*
             ... and the connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs...
             */
            if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
            {
                /*
                 ... and no [user] intervention is needed...
                 */
                returnValue = SGHNetWorkStatusWiFi;
            }
        }
        
        if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
        {
            /*
             ... but WWAN connections are OK if the calling application is using the CFNetwork APIs.
             */
            NSArray *typeStrings2G = @[CTRadioAccessTechnologyEdge,
                                       CTRadioAccessTechnologyGPRS,
                                       CTRadioAccessTechnologyCDMA1x];
            
            NSArray *typeStrings3G = @[CTRadioAccessTechnologyHSDPA,
                                       CTRadioAccessTechnologyWCDMA,
                                       CTRadioAccessTechnologyHSUPA,
                                       CTRadioAccessTechnologyCDMAEVDORev0,
                                       CTRadioAccessTechnologyCDMAEVDORevA,
                                       CTRadioAccessTechnologyCDMAEVDORevB,
                                       CTRadioAccessTechnologyeHRPD];
            
            NSArray *typeStrings4G = @[CTRadioAccessTechnologyLTE];
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                CTTelephonyNetworkInfo *teleInfo= [[CTTelephonyNetworkInfo alloc] init];
                NSString *accessString = teleInfo.currentRadioAccessTechnology;
                if ([typeStrings4G containsObject:accessString]) {
                    return SGHNetWorkStatusWWAN4G;
                } else if ([typeStrings3G containsObject:accessString]) {
                    return SGHNetWorkStatusWWAN3G;
                } else if ([typeStrings2G containsObject:accessString]) {
                    return SGHNetWorkStatusWWAN2G;
                } else {
                    return SGHNetWorkStatusUnknown;
                }
            } else {
                return SGHNetWorkStatusUnknown;
            }
        }
    }
    return returnValue;
}


//获取手机拥有的安全方式
//+ (SGHDeviceSecurityType)getDeviceSecurityType {
+ (SGHDeviceSecurityType)deviceSecurityType {
    SGHDevicePlatform platform = SGHDeviceManager.devicePlatformType;
    switch (platform) {
        case SGHDevice_iPhone5S:
        case SGHDevice_iPhone6:
        case SGHDevice_iPhone6Plus:
        case SGHDevice_iPhone6S:
        case SGHDevice_iPhone6SPlus:
        case SGHDevice_iPhoneSE:
        case SGHDevice_iPhone7:
        case SGHDevice_iPhone7Plus:
        case SGHDevice_iPhone8:
        case SGHDevice_iPhone8Plus: {
            return SGHDeviceSecurityTypeTouchID;
        }
            break;
        case SGHDevice_iPhoneXSMax:
        case SGHDevice_iPhoneXS:
        case SGHDevice_iPhoneXR:
        case SGHDevice_iPhoneX: {
            return SGHDeviceSecurityTypeFaceID;
        }
            break;
            
        default:
            break;
            //UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone
            //            UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad;
    }
    return SGHDeviceSecurityTypeUnknown;
}

/** 获取手机屏幕对应的 像素点比例  @2x,@3x */
//+ (SGHDeviceScreenPixelScale)getDeviceScreenPixelScale {
+ (SGHDeviceScreenPixelScale)deviceScreenPixelScale {
    switch (SGHDeviceManager.deviceScreenSize) {
        case SGHDeviceScreenSize3_5:
        case SGHDeviceScreenSize4:
        case SGHDeviceScreenSize4_7:
        case SGHDeviceScreenSize6_1: {
            return SGHDeviceScreenPixelScale2X;
        }
            break;
        case SGHDeviceScreenSize5_5:
        case SGHDeviceScreenSize5_8:
        case SGHDeviceScreenSize6_5:  {
            return SGHDeviceScreenPixelScale3X;
        }
            break;
        default: {
            return SGHDeviceScreenPixelScale1X;
        }
            break;
    }
}

//+ (UIEdgeInsets)getSafeAreaInsets {
+ (UIEdgeInsets)safeAreaInsets {
    if (@available(iOS 11.0, *)) {
        return [UIApplication sharedApplication].delegate.window.safeAreaInsets;
    } else {
        // Fallback on earlier versions
        return UIEdgeInsetsMake([[UIApplication sharedApplication] statusBarFrame].size.height, 0, 0, 0);
    }
}

// 正则判断手机号码地址格式
+ (BOOL)isAvailableMobileNumber:(NSString *)mobileNum {
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    BOOL isMobileNum = [regextestmobile evaluateWithObject:mobileNum];
    NSLog(@"isMobileNum : %@",(isMobileNum ? @"YES" : @"NO"));
    return isMobileNum;
}
//字符串是否只包含字母和数字
+ (BOOL)onlyWordsAndNumbers:(NSString *)text {
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]"options:NSRegularExpressionCaseInsensitive error:nil];
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:text options:NSMatchingReportProgress range:NSMakeRange(0, text.length)];
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]"options:NSRegularExpressionCaseInsensitive error:nil];
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:text options:NSMatchingReportProgress range:NSMakeRange(0, text.length)];
    if (tNumMatchCount == text.length) {
        //全部符合数字，表示沒有英文
        return YES;
    } else if (tLetterMatchCount == text.length) {
        //全部符合英文，表示沒有数字
        return YES;
    } else if (tNumMatchCount + tLetterMatchCount == text.length) {
        //符合英文和符合数字条件的相加等于密码长度
        return YES;
    } else {
        return NO;
        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
    }
    
}
/** 获取导航栏的高度 */
//+ (CGFloat)getNavigationBarHeight {
+ (CGFloat)navigationBarHeight {
    static CGFloat shareInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        switch (SGHDeviceManager.deviceScreenSize) {
            case SGHDeviceScreenSize5_8:
            case SGHDeviceScreenSize6_5:
            case SGHDeviceScreenSize6_1: {
                shareInstance = 88;
            }
                break;
            default: {
                shareInstance = 64;
            }
                break;
        }
    });
    return shareInstance;
    
    
}
/** 状态栏的高度  */
//+ (CGFloat)getStatusBarHeight {
+ (CGFloat)statusBarHeight {
    static CGFloat shareInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[UIApplication sharedApplication] statusBarFrame].size.height;
    });
    return shareInstance;
    
}
/** 获取tabbar的高度 */
//+ (CGFloat)getTabbarHeight {
+ (CGFloat)tabbarHeight {
    static CGFloat shareInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        switch (SGHDeviceManager.deviceScreenSize) {
            case SGHDeviceScreenSize5_8:
            case SGHDeviceScreenSize6_5:
            case SGHDeviceScreenSize6_1: {
                shareInstance = 83;
            }
                break;
            default: {
                shareInstance = 49;
            }
                break;
        }
    });
    return shareInstance;
    
    
}

/** documents文件夹路径  */
//+ (NSString *)documentsFilePath {
+ (NSString *)documentsFilePath {
    static NSString *shareInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    });
    return shareInstance;
}

/** ================================================  */
/** 获取bundleId  */
//+ (NSString *)bundleIdentifier {
+ (NSString *)bundleIdentifier {
    static NSString *shareInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    });
    return shareInstance;
}
//系统版本
+ (NSString *)systemVersion {
    static NSString *shareInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[UIDevice currentDevice] systemVersion];
    });
    return shareInstance;
}
//App版本号
+ (NSString *)shortVersionString {
    static NSString *shareInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    });
    return shareInstance;
}
/** 屏幕宽度与 375.0的比例  */
+ (CGFloat)screenWidthRate {
    static CGFloat shareInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [UIScreen mainScreen].bounds.size.width / 375.0;
    });
    return shareInstance;
}
/** 屏幕宽度 */
+ (CGFloat)screenWidth {
    static CGFloat shareInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [UIScreen mainScreen].bounds.size.width;
    });
    return shareInstance;
}
/** 屏幕高度 */
+ (CGFloat)screenHeight {
    static CGFloat shareInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [UIScreen mainScreen].bounds.size.height;
    });
    return shareInstance;
}


@end
