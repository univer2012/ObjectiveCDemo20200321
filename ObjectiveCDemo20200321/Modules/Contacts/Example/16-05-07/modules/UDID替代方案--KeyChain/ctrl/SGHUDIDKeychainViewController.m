//
//  SGHUDIDKeychainViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/5/7.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHUDIDKeychainViewController.h"
#import "YYQKeyChain.h"

@implementation SGHUDIDKeychainViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSString *UDID = [YYQKeyChain getUDIDWithUniqueKey:@"69876879877"];
    NSLog(@"%@", UDID);
    
}

@end
