//
//  SGH170119CrashRankViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/1/19.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH170119CrashRankViewController.h"
//crash 日志1-1
#import "NSDictionary+NilSafe.h"

@interface SGH170119CrashRankViewController ()

@end

@implementation SGH170119CrashRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self p_NumberOneLogOne];
    [self p_NumberOneLogTwo];
}
//MARK: 杀手 NO.1 NSInvalidArgumentException 异常
/*crash 日志1-1
 *** -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[1]
*/
-(void)p_NumberOneLogOne {
    NSString *password = nil;
    NSDictionary *dict = @{@"userName": @"bruce",
                           @"password": password};
    NSLog(@"dict is : %@",dict);
}
    
/*crash 日志1-2
 data parameter is nil
 */
-(void)p_NumberOneLogTwo {
    NSData *data = nil;
    NSError *error;
    NSDictionary *orginDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"originDict is : %@", orginDict);
    //这个问题比较好解决，在序列化的时候，统一加入判断，判断data是不是nil即可。
}
    
/*crash 日志1-3
 unrecognized selector sent to instance 0x15d23910
 */
    



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
