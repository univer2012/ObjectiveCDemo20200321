//
//  SHUtility.m
//  ObjectiveC
//
//  Created by sengoln huang on 2019/1/31.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHUtility.h"

/** 常量  */
#import "BDTConstManager.h"

/** 检测推送是否开启 */
#ifdef __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#else
@protocol UNUserNotificationCenterDelegate <NSObject>@end
#endif

@implementation SHUtility

//NSString
+ (void)setString:(NSString *)str forKey:(NSString *)key {
    if (key.length > 0) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setValue:str forKey:key];
        [user synchronize];
    }
}
+ (NSString *)stringForKey:(NSString *)key {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    return [user valueForKey:key];
}
+ (void)removeStringForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}
//BOOL
+ (void)setBool:(BOOL)value forKey:(NSString *)key {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:value forKey:key];
    [user synchronize];
}
+ (BOOL)boolForKey:(NSString *)key {
    if (key.length > 0) {
        NSLog(@"key:%@",key);
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        return [user boolForKey:key];
    }
    return NO;
}
+ (void)removeBoolForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}
//NSArray
+ (void)setArray:(NSArray *)array forKey:(NSString *)key {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [user setValue:data forKey:key];
    [user synchronize];
}
+ (NSMutableArray *)arrayForKey:(NSString *)key {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
+ (void)removeArrayForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

//NSSet
+ (void)setSet:(NSMutableSet *)set forKey:(NSString *)key {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:set];
    [user setValue:data forKey:key];
    [user synchronize];
}
+ (NSMutableSet *)setForKey:(NSString *)key {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
+ (void)removeSetForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}
//NSDictionary
+ (void)setDictionary:(NSDictionary *)dict forKey:(NSString *)key {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [user setValue:data forKey:key];
    [user synchronize];
}
+ (NSMutableDictionary *)dictionaryForKey:(NSString *)key {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
+ (void)removeDictionaryForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

//+ (void)showMessage:(NSString *)msg withDelay:(NSTimeInterval)delay {
//    if (msg.length > 0) {
//        [SHUtility showHUDWithMsg:msg detail:nil withDelay:delay];
//    }
//}
//+ (void)showHUDWithMsg:(NSString *)msg detail:(NSString *)detail withDelay:(NSTimeInterval)delay {
//    UIWindow *window = [UIApplication sharedApplication].delegate.window;//防止键盘遮挡
//
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
//    hud.mode = MBProgressHUDModeText;
//    hud.label.text = msg;
//    hud.label.numberOfLines = 0;
//    hud.detailsLabel.text = detail;
//    hud.detailsLabel.numberOfLines = 0;
//    hud.removeFromSuperViewOnHide = YES;
//    [hud hideAnimated:YES afterDelay:delay];
//}
////对接口返回的状态进行过滤，显示过滤后的状态的错误文字
//+ (void)showBaseModelMessage:(BDTBaseNetworkModel *)baseModel withDelay:(NSTimeInterval)delay {
//    switch (baseModel.status) {
//        case BDTNetworkingStatus200:
//            break;
//        default: {
//            [SHUtility showMessage:baseModel.msg withDelay:delay];
//        }
//            break;
//    }
//}
/** 验证手机号码 是否有效  */
+ (BOOL)validateMobile:(NSString *)mobile {
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

/** 时间戳转日期字符串  */
+ (NSString *)timeStamp:(NSString *)timeStamp transformWithDateFormat:(NSString *)dateFormat {
    NSTimeInterval interval    = [timeStamp doubleValue];
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

/** 计算文字的size  */
+ (CGSize)boundingRactWithSize:(CGSize)size font:(UIFont *)font content:(NSString *)content {
    if ([content isKindOfClass:[NSNull class]]) {
        return CGSizeMake(0, 0);
    } else {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        CGSize retSize = [content boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                            attributes:attribute context:nil].size;
        return retSize;
    }
}

/**
 比较2个字符串时间的时间差
 
 @param starTime 开始时间
 @param endTime 结束时间
 @param dateFormat 时间格式
 @return 时间差，单位：秒
 */
+ (NSTimeInterval)distanceWithStarTime:(NSString *)starTime endTime:(NSString *)endTime dateFormat:(NSString *)dateFormat {
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:dateFormat];//@"mm:ss"];//根据自己的需求定义格式
    NSDate* startDate = [formater dateFromString:starTime];
    NSDate* endDate = [formater dateFromString:endTime];
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    return time;
}
/**
 比较2个字符串时间的时间差
 
 @param starTime 开始时间
 @param endTime 结束时间
 @return 时间差，包含年、月、日、时、分、秒
 */
+ (NSDateComponents *)dateTimeDifferenceWithStarTime:(NSString *)starTime endTime:(NSString *)endTime {
    // 1.将时间转换为date
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date1 = [formatter1 dateFromString:starTime];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    formatter2.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *date2 = [formatter2 dateFromString:endTime];
    // 2.创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 3.利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
    //4.输出结果
    //NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    return cmps;
}

/** MARK: 检测是否开启 远程推送 */
+ (void)checkRemoteNotificSwitch {
    /** 检测是否开启 远程推送
     安装后第一次启动会走这里，不会走applicationWillEnterForeground:方法*/
    [SHUtility setBool:NO forKey:BDTApplicationOpenSettingsFlag];
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (settings.authorizationStatus == UNAuthorizationStatusAuthorized){
                    [SHUtility setBool:YES forKey:BDTApplicationOpenSettingsFlag];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:BDTAPPWillEnterForeground object:nil];
            });
            
        }];
    }
    else if (@available(iOS 8.0, *)) {
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  != UIUserNotificationTypeNone) {
            [SHUtility setBool:YES forKey:BDTApplicationOpenSettingsFlag];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:BDTAPPWillEnterForeground object:nil];
    }
}

@end
