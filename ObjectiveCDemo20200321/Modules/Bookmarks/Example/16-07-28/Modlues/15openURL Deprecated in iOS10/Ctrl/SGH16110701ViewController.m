//
//  SGH16110701ViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2016/11/7.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//
/*
 “设置”中各个页面的“地址”
 About — prefs:root=General&path=About
 Accessibility — prefs:root=General&path=ACCESSIBILITY
 Airplane Mode On — prefs:root=AIRPLANE_MODE
 Auto-Lock — prefs:root=General&path=AUTOLOCK
 Brightness — prefs:root=Brightness
 Bluetooth — prefs:root=General&path=Bluetooth
 Date & Time — prefs:root=General&path=DATE_AND_TIME
 FaceTime — prefs:root=FACETIME
 General — prefs:root=General
 Keyboard — prefs:root=General&path=Keyboard
 iCloud — prefs:root=CASTLE
 iCloud Storage & Backup — prefs:root=CASTLE&path=STORAGE_AND_BACKUP
 International — prefs:root=General&path=INTERNATIONAL
 Location Services — prefs:root=LOCATION_SERVICES
 Music — prefs:root=MUSIC
 Music Equalizer — prefs:root=MUSIC&path=EQ
 Music Volume Limit — prefs:root=MUSIC&path=VolumeLimit
 Network — prefs:root=General&path=Network
 Nike + iPod — prefs:root=NIKE_PLUS_IPOD
 Notes — prefs:root=NOTES
 Notification — prefs:root=NOTIFICATIONS_ID
 Phone — prefs:root=Phone
 Photos — prefs:root=Photos
 Profile — prefs:root=General&path=ManagedConfigurationList
 Reset — prefs:root=General&path=Reset
 Safari — prefs:root=Safari
 Siri — prefs:root=General&path=Assistant
 Sounds — prefs:root=Sounds
 Software Update — prefs:root=General&path=SOFTWARE_UPDATE_LINK
 Store — prefs:root=STORE
 Twitter — prefs:root=TWITTER
 Usage — prefs:root=General&path=USAGE
 VPN — prefs:root=General&path=Network/VPN
 Wallpaper — prefs:root=Wallpaper
 Wi-Fi — prefs:root=WIFI
 Setting —prefs:root=INTERNET_TETHERING
 
 蜂窝网络：prefs:root=MOBILE_DATA_SETTINGS_ID
 */
#import "SGH16110701ViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>

@interface SGH16110701ViewController ()

@end

@implementation SGH16110701ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self p_jumpToWIFI];
    //跳转到“设置”
    //[self p_jumpToSettings];
    //跳转系统设置的蜂窝移动网络
    [self p_jumpToNetwork];
}


//跳转系统WIFI 设置
-(void)p_jumpToWIFI {
    
    NSURL *url = [NSURL URLWithString:@"prefs:root=WIFI"];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0) {
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            
            [[UIApplication sharedApplication] openURL:url]; // iOS 9 的跳转
        }
    }
    else {
        //下句代码无效
        //[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];// iOS 10 的跳转方式
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @YES} completionHandler:nil];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}
//跳转系统设置的蜂窝移动网络
-(void)p_jumpToNetwork {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0) {
        NSURL *url = [NSURL URLWithString:@"prefs:root=MOBILE_DATA_SETTINGS_ID"];
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
        }
        else{
            NSLog(@"can not open");  
        }
    }
    else {
//        NSURL *url = [NSURL URLWithString:@"Prefs:root=MOBILE_DATA_SETTINGS_ID"];
//        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) { }];
        
        
         //openURL:url];
        
        //iOS10可以跳转的方式
#if 0
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenURLOptionUniversalLinksOnly]];
#elif 1
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//        NSURL *url = [NSURL URLWithString:@"prefs:root=WIFI"];
        if( [[UIApplication sharedApplication]canOpenURL:url] ) {
            [[UIApplication sharedApplication]openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@NO}completionHandler:^(BOOL success) {
                
            }];
        }
#endif
    }
}

//跳转到“设置”
-(void)p_jumpToSettings {
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion < 10.0 && systemVersion >= 8.0) {
        //>=iOS8.0可用
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenURLOptionUniversalLinksOnly]];//UIApplicationOpenSettingsURLString]];
    }
    
}

-(void)p_jumpToSettingsLocation {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0)  {
        //注意首字母改成了大写，prefs->Prefs
        NSURL*url=[NSURL URLWithString:@"Prefs:root=Privacy&path=LOCATION"];
        Class LSApplicationWorkspace = NSClassFromString(@"LSApplicationWorkspace");
        [[LSApplicationWorkspace performSelector:@selector(defaultWorkspace)] performSelector:@selector(openSensitiveURL:withOptions:) withObject:url withObject:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
