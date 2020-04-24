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
- (void)memoryLeakBug
{
     CGPathRef shadowPath = CGPathCreateWithRect(self.inputView.bounds, NULL);
}

- (void)resoureLeakBug
{
    FILE *fp;
    fp=fopen("info.plist", "r");
}

-(void) parameterNotNullCheckedBlockBug:(void (^)())callback {
    callback();
}

-(NSArray*) npeInArrayLiteralBug {
    NSString *str = nil;
    return @[@"horse", str, @"dolphin"];
}

-(NSArray*) prematureNilTerminationArgumentBug {
    NSString *str = nil;
    return [NSArray arrayWithObjects: @"horse", str, @"dolphin", nil];
}

@end
