//
//  Base1ViewController.m
//  UIDatePickerDemo
//
//  Created by huangaengoln on 16/2/25.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHDataPickerViewController.h"

@interface SGHDataPickerViewController (){
    UIDatePicker *_datePicker;
}

@end

@implementation SGHDataPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor grayColor];
    
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 80, CGRectGetWidth(self.view.frame), 300)];
    _datePicker.backgroundColor=[UIColor whiteColor];
    /*
     UIDatePickerModeTime,           // Displays hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. 6 | 53 | PM)
     UIDatePickerModeDate,           // Displays month, day, and year depending on the locale setting (e.g. November | 15 | 2007)
     UIDatePickerModeDateAndTime,    // Displays date, hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. Wed Nov 15 | 6 | 53 | PM)
     UIDatePickerModeCountDownTimer,
     */
    _datePicker.datePickerMode = UIDatePickerModeDate;//UIDatePickerModeDateAndTime;
    [self.view addSubview:_datePicker];
    [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    //设置指定日期
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.year = 2016;
    dateComponents.month = 2;
    dateComponents.day = 25;
    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date1= [calendar dateFromComponents:dateComponents];
    _datePicker.minimumDate =date1;
    _datePicker.date =date1;
    
    dateComponents.year = 2017;
    NSDate *date2 = [calendar dateFromComponents:dateComponents];
    _datePicker.maximumDate =date2;
    _datePicker.date =date2;
    
#if 0
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 40);
    button.center =CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetMaxY(_datePicker.frame)+10);
    [button setTitle:@"clickMe" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(clickDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
#endif
    
}

-(void)dateChanged:(UIDatePicker *)datePciker {
    if (datePciker.datePickerMode != UIDatePickerModeCountDownTimer) {
        NSDate * date= datePciker.date;
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        //        dateFormatter.timeStyle = kCFDateFormatterFullStyle;
        dateFormatter.dateStyle = kCFDateFormatterFullStyle;
        NSString *dateString = [dateFormatter stringFromDate:date];
        NSLog(@"%@",dateString);
        
        NSLog(@"星期:%@",[dateString substringFromIndex:dateString.length-3]);
        
    } else {
        
        NSTimeInterval timeInterval = datePciker.countDownDuration;
        NSDateComponentsFormatter *formatter = [NSDateComponentsFormatter new];
        formatter.allowedUnits = NSDateComponentsFormatterUnitsStyleAbbreviated;
        if ( [formatter stringFromTimeInterval:timeInterval]) {
            NSLog(@"%@",[formatter stringFromTimeInterval:timeInterval]);
        }
    }
}

-(void)clickDatePicker:(UIButton *)button {
    NSDate *select  = [_datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateAndTime = [dateFormatter stringFromDate:select];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" 时间提示" message: dateAndTime delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
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
