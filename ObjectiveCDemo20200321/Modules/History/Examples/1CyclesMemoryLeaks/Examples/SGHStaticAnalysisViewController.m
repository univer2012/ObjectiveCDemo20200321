//
//  SGHStaticAnalysisViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/24.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHStaticAnalysisViewController.h"

@interface SGHStaticAnalysisViewController ()

@end

@implementation SGHStaticAnalysisViewController

#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self memoryLeakBug];
    [self resoureLeakBug];
    [self parameterNotNullCheckedBlockBug:nil];
    [self npeInArrayLiteralBug];
    [self prematureNilTerminationArgumentBug];
}

#pragma mark - Test methods from facebook infer iOS Hello examples
//CG C语言的方法，需要手动管理内存
- (void)memoryLeakBug
{
     CGPathRef shadowPath = CGPathCreateWithRect(self.inputView.bounds, NULL);
}

//2. 文件的操作
- (void)resoureLeakBug
{
    FILE *fp;
    fp=fopen("info.plist", "r");
}

//3. block在调用前要判空，否则会崩溃
-(void) parameterNotNullCheckedBlockBug:(void (^)())callback {
    callback();
}

//4. 在NSArray插入了nil的字符串，
-(NSArray*) npeInArrayLiteralBug {
    NSString *str = nil;
    return @[@"horse", str, @"dolphin"];
}

-(NSArray*) prematureNilTerminationArgumentBug {
    NSString *str = nil;
    return [NSArray arrayWithObjects: @"horse", str, @"dolphin", nil];
}

@end
