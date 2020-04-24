//
//  VarArgs.m
//  程序猿群141607754
//
//  Created by huangaengoln on 2017/10/12.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "VarArgs.h"

@implementation VarArgs
-(void)test:(NSString *)name, ... {
    //使用va_list定义一个argList指针变量，该指针指向可变参数列表
    va_list argList;
    //如果第一个name参数存在，才需要处理后面的参数
    if (name) {
        //由于参数并不在可变参数列表中，因此先处理name参数
        NSLog(@"%@",name);
        //让argList指向第一个科比那参数里诶博爱的第一个参数，喀什提取可变参数列表的参数
        va_start(argList, name);
        //va_arg用于提取argList指针当前指向的参数，并将指针移动到指向下一个参数
        //arg变量用于保存当前获取到的参数，如果改参数不为nil，进入循环体
        NSString *arg = va_arg(argList, id);
        while (arg) {
            //打印出每一个参数
            NSLog(@"%@",arg);
            //再次提取下一个参数，并将指针移动到指向下一个参数
            arg = va_arg(argList, id);
        }
        //释放argList指针，借宿提取
        va_end(argList);
    }
}
@end
