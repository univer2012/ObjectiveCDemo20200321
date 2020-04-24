//
//  SGH1108UpdateAppViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2016/11/8.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH1108UpdateAppViewController.h"


static const NSString *kAppID = @"963463279";
@interface SGH1108UpdateAppViewController ()

@end

@implementation SGH1108UpdateAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    double a = 3.45678901234456;
    NSLog(@"a : %f",a);
    //double --> NSDecimalNumber
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc]initWithDouble:a];
    NSLog(@"decimalNumber : %@",decimalNumber);
    //NSDecimalNumber --> double
    a = [decimalNumber doubleValue];
    NSLog(@"a : %f",a);
    
    //nsstring --> NSDecimalNumber --> double
    NSString *string = @"3.45678901234456";
    NSLog(@"string : %@",string);
    NSDecimalNumber *decimalNum = [[NSDecimalNumber alloc]initWithString:string];
    NSLog(@"decimalNum : %@",decimalNum);
    double stringDouble = [decimalNum doubleValue];
    NSLog(@"stringDouble : %f",stringDouble);
    
    stringDouble = stringDouble * 2.345678;
    NSLog(@"stringDouble : %f",stringDouble);
    
    
    
    [self updateVersion];
}

-(void)p_getAppID {
    //定义的App地址
    NSString *appIdUrl = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",kAppID];
    //AppID即是如图红色箭头获取的AppID
    //PS:有的时候可能会请求不到数据，但是AppID对了，有可能是App是上架区域范围的原因，建议使用在com末尾加上“／cn”
    //例：NSString *url = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",AppID];
    
    
    //网络请求App的信息（我们取Version就够了）
    NSURL *url = [NSURL URLWithString:appIdUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableDictionary *receiveStatusDic=[[NSMutableDictionary alloc]init];
        if (data) {
            
            //data是有关于App所有的信息
            NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//            if ([[receiveDic valueForKey:@"resultCount"] intValue]>0) {
            
                [receiveStatusDic setValue:@"1" forKey:@"status"];
                [receiveStatusDic setValue:[[[receiveDic valueForKey:@"results"] objectAtIndex:0] valueForKey:@"version"]   forKey:@"version"];
                
                //请求的有数据，进行版本比较
                [self performSelectorOnMainThread:@selector(receiveData:) withObject:receiveStatusDic waitUntilDone:NO];
//            }else{
//                
//                [receiveStatusDic setValue:@"-1" forKey:@"status"];
//            }
        }else{
            [receiveStatusDic setValue:@"-1" forKey:@"status"];
        }
        
    }];
    
    [task resume];
}

//1.弹窗比较
-(void)receiveData:(id)sender
{
    //获取APP自身版本号
    NSString *localVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    
    NSArray *localArray = [localVersion componentsSeparatedByString:@"."];
    NSArray *versionArray = [sender[@"version"] componentsSeparatedByString:@"."];
    
    
    if ((versionArray.count == 3) && (localArray.count == versionArray.count)) {
        
        if ([localArray[0] intValue] <  [versionArray[0] intValue]) {
            [self updateVersion];
        }else if ([localArray[0] intValue]  ==  [versionArray[0] intValue]){
            if ([localArray[1] intValue] <  [versionArray[1] intValue]) {
                [self updateVersion];
            }else if ([localArray[1] intValue] ==  [versionArray[1] intValue]){
                if ([localArray[2] intValue] <  [versionArray[2] intValue]) {
                    [self updateVersion];
                }
            }
        }
    }
}

//d,e升级提示及跳转
-(void)updateVersion{
    NSString *msg = [NSString stringWithFormat:@"又出新版本啦，快点更新吧!"];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"升级提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"现在升级"style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",kAppID]];
        [[UIApplication sharedApplication]openURL:url];
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    ;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
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
