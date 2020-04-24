//
//  SHUtility.h
//  ObjectiveC
//
//  Created by sengoln huang on 2019/1/31.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class BDTBaseNetworkModel;

@interface SHUtility : NSObject


//存取String
+ (void)setString:(NSString *)str forKey:(NSString *)key;
+ (NSString *)stringForKey:(NSString *)key;
+ (void)removeStringForKey:(NSString *)key;
//存取BOOL
+ (void)setBool:(BOOL)value forKey:(NSString *)key;
+ (BOOL)boolForKey:(NSString *)key;
+ (void)removeBoolForKey:(NSString *)key;
//存取Array
+ (void)setArray:(NSArray *)array forKey:(NSString *)key;
+ (NSMutableArray *)arrayForKey:(NSString *)key;
+ (void)removeArrayForKey:(NSString *)key;
//NSSet
+ (void)setSet:(NSMutableSet *)set forKey:(NSString *)key;
+ (NSMutableSet *)setForKey:(NSString *)key;
+ (void)removeSetForKey:(NSString *)key;
//NSDictionary
+ (void)setDictionary:(NSDictionary *)dict forKey:(NSString *)key;
+ (NSMutableDictionary *)dictionaryForKey:(NSString *)key;
+ (void)removeDictionaryForKey:(NSString *)key;

//+ (void)showMessage:(NSString *)msg withDelay:(NSTimeInterval)delay;
////对接口返回的状态进行过滤，显示过滤后的状态的错误文字
//+ (void)showBaseModelMessage:(BDTBaseNetworkModel *)baseModel withDelay:(NSTimeInterval)delay;

/** 验证手机号码 是否有效  */
+ (BOOL)validateMobile:(NSString *)mobile;
/** 时间戳转日期字符串  */
+ (NSString *)timeStamp:(NSString *)timeStamp transformWithDateFormat:(NSString *)dateFormat;

/** 计算文字的size  */
+ (CGSize)boundingRactWithSize:(CGSize)size font:(UIFont *)font content:(NSString *)content;

/**
 比较2个字符串时间的时间差
 
 @param starTime 开始时间
 @param endTime 结束时间
 @return 时间差，单位：秒
 */
+ (NSTimeInterval)distanceWithStarTime:(NSString *)starTime endTime:(NSString *)endTime dateFormat:(NSString *)dateFormat;

/**
 比较2个字符串时间的时间差
 
 @param starTime 开始时间
 @param endTime 结束时间
 @return 时间差，包含年、月、日、时、分、秒
 */
+ (NSDateComponents *)dateTimeDifferenceWithStarTime:(NSString *)starTime endTime:(NSString *)endTime;

/** MARK: 检测是否开启 远程推送 */
+ (void)checkRemoteNotificSwitch;

@end

NS_ASSUME_NONNULL_END
