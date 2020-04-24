//
//  SHSandboxReadWriteVC.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/15.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHSandboxReadWriteVC.h"

@interface SHSandboxReadWriteVC () {
    UITextField *displayLabel;
}

@end

@implementation SHSandboxReadWriteVC

- (void)viewDidLoad {
    [super viewDidLoad];
#if 0
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * namePath = [documentsDirectory stringByAppendingPathComponent:@"gift_info.plist"];
    
    NSMutableArray *myArr = [[NSMutableArray alloc] initWithContentsOfFile:namePath];
    NSMutableDictionary *info = [[NSMutableDictionary alloc]init];
    
    [info setObject:@"abcdefg" forKey:@"imageName"];
    [myArr addObject:info];
    [myArr writeToFile:namePath atomically:YES];
#endif
    [[NSUserDefaults standardUserDefaults] setObject:@"abcdefg" forKey:@"imageName"];
    
    displayLabel=[UITextField new];
    
    NSString *resultData;
    
    
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSLog(@"path = %@",path);
    NSString *filename=[path stringByAppendingPathComponent:@"test.plist"];
    //读文件
    NSArray *array=[NSArray arrayWithContentsOfFile:filename];
    NSLog(@"前array: %@",array);
    //创建
    NSFileManager *fm=[NSFileManager defaultManager];
    [fm createFileAtPath:filename contents:nil attributes:nil];
    //写入文件
    NSArray *dataArray=@[@"1",@"2",@"3",@"4",@"5",@"6",];
    [dataArray writeToFile:filename atomically:YES];
    //读文件
    NSMutableArray *array1=[NSMutableArray arrayWithContentsOfFile:filename];
    NSLog(@"后array: %@",array1);
    
    [array1 removeObject:@"2"];
    [array1 writeToFile:filename atomically:YES];
    
    
#if 0
    //读文件
    NSDictionary* dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];
    NSLog(@"前dic is:%@",dic2);
    //创建
    NSFileManager* fm = [NSFileManager defaultManager];
    [fm createFileAtPath:filename contents:nil attributes:nil];
    
    //创建一个dic，写到plist文件里
    NSDictionary* dic = @{@"imageName":@"inhoa",
                          @"title":@"你好",
                          @"sex":@"man"}; //写入数据
    [dic writeToFile:filename atomically:YES];
    
    //读文件
    NSDictionary* dic3 = [NSDictionary dictionaryWithContentsOfFile:filename];
    NSLog(@"后dic3 is:%@",dic3);
#endif
    
    
#if 0
    if(dic2 == nil)
    {
        //1. 创建一个plist文件
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:filename contents:nil attributes:nil];
    }
    else
    {
        resultData=[dic2 objectForKey:@"IP"];
        if([dic2 count] > 0)
        {
            displayLabel.text = resultData;
        }
        else
        {
            displayLabel.text = @" ";
        }
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]   //按钮的初始化及触发条件设置
                                              initWithTitle:@"保存"
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:@selector(triggerStorage)];
    [super viewDidLoad];
    
#endif
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)triggerStorage
{
    //    displayLabel.text = textInput.text;
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"test.plist"];   //获取路径
    
    NSDictionary* dic2 = [NSDictionary dictionaryWithContentsOfFile:filename];  //读取数据
    NSLog(@"dic2 is:%@",dic2);
    
    //创建一个dic，写到plist文件里
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:displayLabel.text,@"IP",nil]; //写入数据
    [dic writeToFile:filename atomically:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
