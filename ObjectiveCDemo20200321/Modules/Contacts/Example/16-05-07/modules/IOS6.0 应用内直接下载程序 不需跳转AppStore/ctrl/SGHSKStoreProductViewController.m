//
//  SGHSKStoreProductViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/5/4.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHSKStoreProductViewController.h"
#import <StoreKit/StoreKit.h>
#import "Masonry.h"

#import "Harpy.h"

//#import "ASIFormDataRequest.h"

@interface SGHSKStoreProductViewController ()<SKStoreProductViewControllerDelegate, NSURLSessionDelegate>

@end

@implementation SGHSKStoreProductViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *clickStoreProductButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"clickStoreProductViewController" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor grayColor];
        [button addTarget:self action:@selector(clickStoreProduct:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    [clickStoreProductButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 50));
    }];
    
    
    
    [Harpy checkVersion];
    
}

-(void)clickStoreProduct:(UIButton *)button {
    [self showStoreProductInApp:@"963463279"];
}


- (void)showStoreProductInApp:(NSString *)appID{
    
    Class isAllow = NSClassFromString(@"SKStoreProductViewController");
    
    if (isAllow != nil) {
        
        SKStoreProductViewController *sKStoreProductViewController = [[SKStoreProductViewController alloc] init];
        [sKStoreProductViewController setDelegate:self];
        [sKStoreProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : appID} completionBlock:^(BOOL result, NSError *error) {
            if (result) {
                [self presentViewController:sKStoreProductViewController animated:YES completion:nil];
                //[self removeNotice];
                
            }
            else {
                NSLog(@"error:%@",error);
            }
        }];
    }
    else {
        //https://itunes.apple.com/cn/app/hua-zhao-cai-bao-hua-zheng/id963463279?mt=8
        //低于iOS6的系统版本没有这个类,不支持这个功能
        //itms-apps://itunes.apple.com/cn/app/id963463279?mt=8
        NSString *string = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",appID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
    }
    /*
     这个方法的第一个参数是NSDictionary类型,其中的Key为，
     NSString * const  SKStoreProductParameterITunesItemIdentifier ;
     NSString * const  SKStoreProductParameterAffiliateToken ;
     NSString * const  SKStoreProductParameterCampaignToken;
     
     三种类型。
     SKStoreProductParameterITunesItemIdentifier是希望展示App的AppID，该Key所关联的值是一个NSNumber类型。支持iOS6以后的系统版本。
     SKStoreProductParameterAffiliateToken是附属令牌，该Key所关联的值是NSString类型。例如在iBook中app的ID,是iOS8中新添加的，支持iOS8以后的系统版本。
     SKStoreProductParameterCampaignToken是混合令牌，该Key所关联的值是一个40byte的NSString类型，使用这个令牌，你能看到点击和销售的数据报告。支持iOS8以后的系统版本。
     */
    
    
    
   
    
    
}

#pragma mark - SKStoreProductViewControllerDelegate

//对视图消失的处理

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    
    [viewController dismissViewControllerAnimated:YES completion:nil];
    
}


@end
