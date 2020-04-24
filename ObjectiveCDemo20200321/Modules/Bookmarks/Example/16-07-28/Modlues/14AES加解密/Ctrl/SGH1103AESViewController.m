//
//  SGH1103AESViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2016/11/3.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH1103AESViewController.h"

#import "TKAesHelper.h"
#import "GTMBase64.h"

@interface SGH1103AESViewController ()

@end

@implementation SGH1103AESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.title = @"AES加解密";
    
    [self p_aesDecode];
    
    /*
      resultString : 8NlFw0ZEs/PM4l/AKSMs+THi5Zsjkw/+e6lpf6bs05QxVbOtxzUawuzcqbDTta42
     */
}

-(void)p_aesDecodeDemo {
    NSString *string = @"htqfapp,101,null,13145862913,1478138435";
    // -- 1 用utf8转NSData格式
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // -- 2 AES加密
    NSData *encryptData = [TKAesHelper dataWithAesEncryptData:data withKey:@"B49A86FA425D439d"];
    NSLog(@"encryptData : %@",encryptData);
    // -- 3 base64编码
    NSData *encodeData = [GTMBase64 encodeData:encryptData];
    NSLog(@"encodeData : %@",encodeData);
    // -- 4 用utf8转为NSSString
    NSString *resultString = [[NSString alloc] initWithData:encodeData encoding:NSUTF8StringEncoding];
    NSLog(@"resultString : %@", resultString);
    
}

-(void)p_aesDecode {
    NSString *string = @"htqfapp,101,null,13145862913,1478138435";
    //@"\"htqfapp,101,810001842,13145862913,1478136910\"";//@"helloworld123456!@#$%^";
    // -- 1 用utf8转NSData格式
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // -- 2 AES加密
    NSData *encryptData = [TKAesHelper dataWithAesEncryptData:data withKey:@"B49A86FA425D439d"];
    NSLog(@"encryptData : %@",encryptData);
    // -- 3 base64编码
    NSData *encodeData = [GTMBase64 encodeData:encryptData];
    NSLog(@"encodeData : %@",encodeData);
    // -- 4 用utf8转为NSSString
    NSString *resultString = [[NSString alloc] initWithData:encodeData encoding:NSUTF8StringEncoding];
    NSLog(@"resultString : %@", resultString);

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
