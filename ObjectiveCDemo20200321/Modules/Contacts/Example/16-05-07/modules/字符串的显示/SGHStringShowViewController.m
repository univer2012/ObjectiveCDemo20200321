//
//  SGHStringShowViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/4/8.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHStringShowViewController.h"
#import "Masonry.h"

typedef void(^stationInfoHandleComplier)(NSError *stationInfoError);

@interface SGHStringShowViewController ()

@end

@implementation SGHStringShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    
    UILabel *label1 = ({
        UILabel *label = [UILabel new];
        label.numberOfLines = 0;
        label.backgroundColor=[UIColor yellowColor];
        label.textColor = [UIColor grayColor];
        [self.view addSubview:label];
        label;
    });
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(64);
        make.left.equalTo(weakSelf.view);
//        make.bottom.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
    }];
    UILabel *label2 = ({
        UILabel *label = [UILabel new];
        label.numberOfLines = 0;
        label.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        label.textColor = [UIColor grayColor];
        [self.view addSubview:label];
        label;
    });
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom);
        make.left.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.equalTo(@(40));
    }];
    
    /*刚开始时，直接运行没有NSData数据返回，原因是iOS9以后，要在plist文件加上
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    NSString *string1 = @"http://zmall.hazq.com:8981/servlet/json?funcNo=200009&id=6008";
    
    NSURL *url1 = [NSURL URLWithString:string1];
#if 0
    NSData *data1 = [NSData dataWithContentsOfURL:url1];
    NSError *error1 = nil;
    NSDictionary *dictionary1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"dictionary : %@",dictionary1);
    NSArray *array1 = dictionary1[@"results"];
    NSDictionary *dict1 = array1[0];
    NSString *contentString1 = dict1[@"content"];
     NSAttributedString *muatbleAttrStr1=[[NSAttributedString alloc]initWithData:[contentString1  dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    label1.attributedText=muatbleAttrStr1;
//    label.text = contentString;
    
#elif 1
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    NSURLSession *session1 = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask1 = [session1 dataTaskWithURL:url1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if ([dictionary[@"error_no"] integerValue] == 0) {
                NSArray *array = dictionary[@"results"];
                NSDictionary *dict = array[0];
                NSString *contentString = dict[@"content"];
                NSLog(@"contentString : %@", contentString);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSAttributedString *muatbleAttrStr=[[NSAttributedString alloc]initWithData:[contentString  dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
                    label1.attributedText=muatbleAttrStr;
//                    [label setNeedsLayout];
//                    [label setNeedsDisplay];
                });
            }
        }
    }];
    //执行任务
    [dataTask1 resume];
#endif
    
    /*================================================================================================*/
    NSString *string2 = @"https://tianxia.cindasc.com:8082/xdmonitor/mytrade.jsp";
    label2.text = [self p_getStationInfoWithUrl:string2 stationInfoHandleComplier:^(NSError *stationInfoError) {
        if (stationInfoError == nil) {
            return ;
        }
    }];
    
    
    
    
}

-(NSString *)p_getStationInfoWithUrl:(NSString *)urlStr stationInfoHandleComplier:(stationInfoHandleComplier)stationInfoHandleComplier {
    NSURL *hqStationInfoURL=[NSURL URLWithString:urlStr];
    NSMutableURLRequest *hqStationInfoURLRequest=[NSMutableURLRequest requestWithURL:hqStationInfoURL];
    [hqStationInfoURLRequest setHTTPMethod:@"GET"];
    NSError *stationInfoError=nil;
    
    NSData *hqStationInfoData= [NSURLConnection sendSynchronousRequest:hqStationInfoURLRequest returningResponse:nil error:&stationInfoError];
    NSString *hqStationInfoString=[[NSString alloc]initWithData:hqStationInfoData encoding:NSASCIIStringEncoding];
    NSArray *hqStationInfoArray=[hqStationInfoString componentsSeparatedByString:@"<b>"];
    if (hqStationInfoArray.count >= 2) {
        hqStationInfoString= hqStationInfoArray[1];
    }
    
    hqStationInfoArray=[hqStationInfoString componentsSeparatedByString:@"</b>"];
    
    stationInfoHandleComplier(stationInfoError);
    return [@"  " stringByAppendingString:hqStationInfoArray[0]];
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
