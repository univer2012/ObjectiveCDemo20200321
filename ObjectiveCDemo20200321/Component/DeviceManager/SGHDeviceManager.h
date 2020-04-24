//
//  SGHDeviceManager.h
//  ObjectiveC
//
//  Created by sengoln huang on 2019/1/31.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
//平台类型
typedef enum : NSUInteger {
    SGHDeviceUnknown,
    
    SGHDeviceSimulator,
    SGHDeviceSimulatoriPhone,
    SGHDeviceSimulatoriPad,
    SGHDeviceSimulatorAppleTV,
    
    SGHDevice_iPhone1G,
    SGHDevice_iPhone3G,
    SGHDevice_iPhone3GS,
    SGHDevice_iPhone4,
    SGHDevice_iPhone4S,
    SGHDevice_iPhone5,
    SGHDevice_iPhone5C,
    SGHDevice_iPhone5S,
    SGHDevice_iPhone6,
    SGHDevice_iPhone6Plus,
    SGHDevice_iPhone6S,
    SGHDevice_iPhone6SPlus,
    SGHDevice_iPhoneSE,
    SGHDevice_iPhone7,
    SGHDevice_iPhone7Plus,
    SGHDevice_iPhone8,
    SGHDevice_iPhone8Plus,
    SGHDevice_iPhoneX,
    SGHDevice_iPhoneXS,
    SGHDevice_iPhoneXSMax,
    SGHDevice_iPhoneXR,
    
    SGHDevice_iPod1G,
    SGHDevice_iPod2G,
    SGHDevice_iPod3G,
    SGHDevice_iPod4G,
    SGHDevice_iPod5G,
    SGHDevice_iPod6G,
    SGHDevice_iPod7G,
    SGHDevice_iPod8G,
    SGHDevice_iPod9G,
    
    SGHDevice_iPad1G,
    SGHDevice_iPad2G,
    SGHDevice_iPad3G,
    SGHDevice_iPad4G,
    SGHDevice_iPad5G,
    SGHDevice_iPad6G,
    SGHDevice_iPad7G,
    SGHDevice_iPad8G,
    SGHDevice_iPad9G,
    
    SGHDeviceAppleTV2,
    SGHDeviceAppleTV3,
    SGHDeviceAppleTV4,
    
    SGHDeviceUnknowniPhone,
    SGHDeviceUnknowniPod,
    SGHDeviceUnknowniPad,
    SGHDeviceUnknownAppleTV,
    SGHDeviceIFPGA,
    
} SGHDevicePlatform;
//解锁类型
typedef enum : NSUInteger {
    SGHDeviceSecurityTypeTouchID = 8,
    SGHDeviceSecurityTypeFaceID,
    SGHDeviceSecurityTypeUnknown,
} SGHDeviceSecurityType;

//网络类型
typedef NS_ENUM(NSUInteger, SGHNetWorkStatus) {
    SGHNetWorkStatusNotReachable = 0,
    SGHNetWorkStatusUnknown = 1,
    SGHNetWorkStatusWWAN2G = 2,
    SGHNetWorkStatusWWAN3G = 3,
    SGHNetWorkStatusWWAN4G = 4,
    
    SGHNetWorkStatusWiFi = 9,
};

typedef enum : NSUInteger {
    SGHDeviceScreenSize3_5 = 9,  //3.5英寸640_960   @2x 320x480   //iPhone 2G/3G/3GS/4/4s
    SGHDeviceScreenSize4,        //4英寸640_1136    @2x 320x568   //iPhone 5/5s/5c/SE
    SGHDeviceScreenSize4_7,      //4.7英寸750_1334  @2x 375x667   //iPhone 6/6s/7/8
    SGHDeviceScreenSize5_5,      //5.5英寸1242_2208 @3x 414x736   //iPhone 6 Plus/6s Plus/7 Plus/8 Plus
    SGHDeviceScreenSize5_8,      //5.8英寸1125_2436 @3x 375x812   //iPhone X/XS
    SGHDeviceScreenSize6_1,      //6.1英寸828_1792  @2x 414x896   //iPhone XR
    SGHDeviceScreenSize6_5,      //6.5英寸1242_2688 @3x 414x896   //iPhone XS Max
} SGHDeviceScreenSize;


/** 屏幕像素 和 点 的比例 */
typedef enum : NSUInteger {
    SGHDeviceScreenPixelScale1X = 5,//@1x
    SGHDeviceScreenPixelScale2X,//@2x
    SGHDeviceScreenPixelScale3X,//@3x
} SGHDeviceScreenPixelScale;

NS_ASSUME_NONNULL_BEGIN

@interface SGHDeviceManager : NSObject

/**
 *  获取平台类型
 *
 *  @return 获取平台类型
 */
//+ (SGHDevicePlatform)getDevicePlatformType;
@property(class, nonatomic, readonly)SGHDevicePlatform devicePlatformType;
///获取平台类型的字符串
//+ (NSString *)getDevicePlatformTypeString;
@property(class, nonatomic, readonly)NSString *devicePlatformTypeString;

/** 获取屏幕尺寸类型 */
//+ (SGHDeviceScreenSize)getDeviceScreenSize;
@property(class, nonatomic, readonly)SGHDeviceScreenSize deviceScreenSize;
//获取当前网络类型
+ (SGHNetWorkStatus)getCurrentNetworkStatusWithHostName:(NSString *)hostName;

//获取手机拥有的安全方式
//+ (SGHDeviceSecurityType)getDeviceSecurityType;
@property(class, nonatomic, readonly)SGHDeviceSecurityType deviceSecurityType;
/** 获取手机屏幕对应的 像素点比例  @2x,@3x */
//+ (SGHDeviceScreenPixelScale)getDeviceScreenPixelScale;
@property(class, nonatomic, readonly)SGHDeviceScreenPixelScale deviceScreenPixelScale;

//+ (UIEdgeInsets)getSafeAreaInsets;
@property(class, nonatomic, readonly)UIEdgeInsets safeAreaInsets;

// 正则判断手机号码地址格式
+ (BOOL)isAvailableMobileNumber:(NSString *)mobileNum;

//字符串是否只包含字母和数字
+ (BOOL)onlyWordsAndNumbers:(NSString *)text;

/** 获取导航栏的高度 */
//+ (CGFloat)getNavigationBarHeight;
@property(class, nonatomic, readonly)CGFloat navigationBarHeight;
/** 状态栏的高度  */
//+ (CGFloat)getStatusBarHeight;
@property(class, nonatomic, readonly)CGFloat statusBarHeight;
/** 获取tabbar的高度 */
//+ (CGFloat)getTabbarHeight;
@property(class, nonatomic, readonly)CGFloat tabbarHeight;
/** documents文件夹路径  */
//+ (NSString *)documentsFilePath;
@property(class, nonatomic, readonly)NSString *documentsFilePath;
/** ================================================  */
/** 获取bundleId  */
//+ (NSString *)bundleIdentifier;
@property(class, nonatomic, readonly)NSString *bundleIdentifier;
//系统版本
//+ (NSString *)systemVersion;
@property(class, nonatomic, readonly)NSString *systemVersion;
//App版本号
//+ (NSString *)shortVersionString;
@property(class, nonatomic, readonly)NSString *shortVersionString;
/** 屏幕宽度与 375.0的比例  */
@property(class, nonatomic, readonly)CGFloat screenWidthRate;

/** 屏幕宽度 */
@property(class, nonatomic, readonly)CGFloat screenWidth;
/** 屏幕高度 */
@property(class, nonatomic, readonly)CGFloat screenHeight;

@end

NS_ASSUME_NONNULL_END
