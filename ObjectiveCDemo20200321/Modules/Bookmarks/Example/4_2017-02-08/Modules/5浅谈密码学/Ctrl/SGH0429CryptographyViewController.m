//
//  SGH0429CryptographyViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/4/29.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

//  注册的时候




#import "SGH0429CryptographyViewController.h"
#import "NSString+Hash.h"


/* 盐  要足够长   走狗复杂  足够咸 */
static NSString *salt = @"daifue90qryh3p12rbldksfhiao0923rupeu[[ops[dapdsfduhfiwekenrkefnd,h dkshfihkjkhkiya v";

@interface SGH0429CryptographyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *UserId;
@property (weak, nonatomic) IBOutlet UITextField *Pwd;

@end

@implementation SGH0429CryptographyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
- (IBAction)login:(id)sender {
    NSString *userID = self.UserId.text;
    NSString *pwd = self.Pwd.text;
    
    //加密处理
    // ------MD5直接加密 ---------  e10adc3949ba59abbe56e057f20f883e
//    pwd = pwd.md5String;
    //------ MD5 加盐 =====
    // 不足：盐是固定的！写死在程序里面的！   一旦盐泄露了，就不安全了
//    pwd = [pwd stringByAppendingString:salt].md5String;
    //3.  ----- HMAC 加密算法   -------- KEY: 秘钥，一般我们从服务器获取！
    //e9cdab82d48dcd37af7734b6617357e6
    //1.得到HMAC之后的密码
    pwd = [pwd hmacMD5StringWithKey:@"hank"];
    
    //问题：在一个手机登录，有这个ekey；再换一部手机登录，就没有key了。
    //2.将这个密码，再拼接字符串，然后MD5
    pwd = [pwd stringByAppendingString:@"201704291449"];
    
    NSLog(@"现在的密码是: %@",pwd);
    
    
    //模拟发送登录请求(验证)
    if ([self isSuccessWithUserId:userID Pwd:pwd]) {
        NSLog(@"登录成功");
        //微信：下次登录直接登录的！
        //1.记住密码
    }
    else {
        NSLog(@"登录失败");
    }
}

//验证
-(BOOL)isSuccessWithUserId:(NSString *)userId Pwd:(NSString *)pwd {
    if ([userId isEqualToString:@"hankv587"] && [pwd isEqualToString:@"e10adc3949ba59abbe56e057f20f883e"]) {
        return YES;
    }
    else {
        return NO;
    }
    return NO;
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
