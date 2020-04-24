//
//  SHFetchFutureDateViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/15.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHFetchFutureDateViewController.h"
#import "TKUpdateHelperCache.h"

@interface SHFetchFutureDateViewController ()

@end

@implementation SHFetchFutureDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *currentDateStr=@"2015:12:24 15:40:00";
    
    NSString * currentTime = [currentDateStr substringToIndex:currentDateStr.length];
    
    NSDateFormatter * currentFormatter = [[NSDateFormatter alloc] init];
    [currentFormatter setDateFormat:@"yyyy:MM:dd HH:mm:ss"];
    
    NSDate * currentDate = [currentFormatter dateFromString:currentTime];
    
    NSDate *realCurrentDate=[NSDate dateWithTimeInterval:8*60*60 sinceDate:currentDate];
    NSLog(@"realCurrentDate : %@",realCurrentDate);
    
    //NSDate还提供了-laterDate、-earlierDate和compare方法来比较日期
    NSDate * now = [NSDate date];
    NSDate * anHourAgo = [now dateByAddingTimeInterval:- 60 * 60];
    
    NSDate * anHourLater = [now dateByAddingTimeInterval: 60 * 60];
    
    NSDate *agoLaterDate = [now laterDate: anHourAgo];
    NSDate * agoEarlierDate = [now earlierDate:anHourAgo];
    NSComparisonResult agoCompare = [now compare:anHourAgo];
    /*
     now                2016-03-26 05:17:21 +0000
     anHourAgo          2016-03-26 04:17:21 +0000
     agoLaterDate       2016-03-26 05:17:21 +0000
     agoEarlierDate     2016-03-26 04:17:21 +0000
     agoCompare         1
     */
    
    NSDate *laterLaterDate = [now laterDate: anHourLater];
    NSDate * laterEarlierDate = [now earlierDate:anHourLater];
    NSComparisonResult laterCompare = [now compare:anHourLater];
    /*
     now                    2016-03-26 05:17:21 +0000
     anHourLater            2016-03-26 06:17:21 +0000
     laterLaterDate         2016-03-26 06:14:39 +0000
     laterEarlierDate       2016-03-26 05:14:39 +0000
     laterCompare           -1
     */
    
    int result1 = [self compareDate:@"2016-03-26 13:24:30" withDate:@"2016-03-26 13:24:34"];
    int result2 =[self compareDate:@"2016-03-26 13:24:34" withDate:@"2016-03-26 13:24:30"];
    int result3 =[self compareDate:@"2016-03-26 13:24:34" withDate:@"2016-03-26 13:24:34"];
    NSLog(@"%d %d %d",result1,result2,result3);
    //-1 1 0
    
    
    NSDictionary * dic = @{@"content":@"测试",
                           @"id":@"3",
                           @"notice_type":@"system",
                           @"title":@"测试",
                           @"publishtime":@"2016-03-25 18:27:44",
                           @"show_type":@"1",
                           @"endtime":@"2016-03-26 18:53:32"};
    //2：每次弹出 :1：弹出一次:0：不弹出
    //只要管内容 结束时间、弹出类型
    if (dic && dic.count >= 7) {
        NSString *title = dic[@"title"];
        NSString *htmlContent = dic[@"content"];
        
        BOOL shouldAlert = NO;  //默认不显示
        NSDateFormatter *endTimeFormatter = [NSDateFormatter new];
        [endTimeFormatter setDateFormat:@"YYYY-MM-DD hh:mm:ss"];
        NSDate *endTimeDate = [endTimeFormatter dateFromString:dic[@"endtime"]];
        NSDate * nowDate = [NSDate date];  //现在的时间
        NSComparisonResult result = [endTimeDate compare:nowDate];
        if (result != NSOrderedAscending) { //nowDate 没有比 endTimeDate 大
            //可以显示
            NSArray *showTypeArray = [TKUpdateHelperCache readAllAccountWithPlistFileName:@"app_update_show_type.plist"];
            if ([dic[@"show_type"] isEqualToString:@"2"]) {
                //每次弹出
                shouldAlert = YES;
                [TKUpdateHelperCache deleteAccount:@"1" plistFileName:@"app_update_show_type.plist"];
                
            } else if ([dic[@"show_type"] isEqualToString:@"1"] && !showTypeArray) {
                //只弹一次
                [TKUpdateHelperCache saveAccount:dic[@"show_type"] plistFileName:@"app_update_show_type.plist"];
                shouldAlert=YES;
                
            } else if ([dic[@"show_type"] isEqualToString:@"0"]) {
                //不弹出
                shouldAlert=NO;
            }
        } else {
            shouldAlert=NO;
        }
        
        if (shouldAlert) {
            UIAlertView *_announAlert = [[UIAlertView alloc] initWithTitle:title message:htmlContent delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            [_announAlert show];
        }
        
        
    }
    
    
}

//ios 比较两个日期格式(NSString,NSDate)的大小/前后
-(int)compareDate:(NSString*)date01 withDate:(NSString*)date02{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    //typedef NS_ENUM(NSInteger, NSComparisonResult) {NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending};
    NSLog(@"%ld  %ld",NSOrderedAscending, NSOrderedDescending);
    NSLog(@"%ld",result);
    switch (result)
    {
            //date02比date01小
        case NSOrderedDescending: ci=1; break;
            //date02比date01大
        case NSOrderedAscending: ci=-1; break;
            //date02=date01
        case NSOrderedSame: ci=0; break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
    }
    return ci;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
