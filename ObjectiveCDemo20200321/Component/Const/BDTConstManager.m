//
//  BDTConstManager.m
//  DailyRead
//
//  Created by sengoln huang on 2018/12/26.
//  Copyright © 2018年 爱阅读. All rights reserved.
//


NSString *const BDTLoginToken = @"BDTLoginToken";
/** 请求地址配置的key  */
NSString *const BDTReqUrlConfigArrayKey = @"BDTReqUrlConfigArrayKey";


//存取urlPath Key
NSString *const BDTUrlPathConfigKey = @"BDTUrlPathConfigKey";
//url
#if kIsTestingEnvironment == 1
NSString * BDTUrlPathConfig = kBDTRequestUrlPath_dev;
#elif kIsTestingEnvironment == 2
NSString * BDTUrlPathConfig = kBDTRequestUrlPath_text;
#endif

//缓存当前手机号
NSString *const BDTCurrentPhoneCache = @"BDTCurrentPhoneCache";
//偏好设置是否设置了
NSString *const BDTFreferenceSetting = @"BDTFreferenceSetting";

//是否开启远程推送的 缓存
NSString *const BDTApplicationOpenSettingsFlag = @"BDTApplicationOpenSettingsFlag";
//WillEnterForeground的通知
NSString *const BDTAPPWillEnterForeground = @"BDTAPPWillEnterForeground";

//启动页被点击的链接缓存的key
NSString *const BDTLaunchAdvertisingUrlKey = @"BDTLaunchAdvertisingUrlKey";


