//
//  SGHUniqueUUID_UDIDViewController.m
//  ObjectiveCDemo
//
//  Created by huangaengoln on 16/4/6.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHUniqueUUID_UDIDViewController.h"

@implementation SGHUniqueUUID_UDIDViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    
    
}
#if 0
+ (NSString *)UUID {
    
    //MARK:此处的 @"5CKSJSE23P.com.haodf.mainGroup" 字串不能动，否则会导致获取的值错误或者 nil
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"HuangyibiaoAppID" accessGroup:@"com.huangyibiao.test.group"];
    NSString *UUID = [wrapper objectForKey:(__bridge id)kSecValueData];
    
    if (UUID.length == 0) {
        UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [wrapper setObject:UUID forKey:(__bridge id)kSecValueData];
    }
    
    return UUID;
}
#endif

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
