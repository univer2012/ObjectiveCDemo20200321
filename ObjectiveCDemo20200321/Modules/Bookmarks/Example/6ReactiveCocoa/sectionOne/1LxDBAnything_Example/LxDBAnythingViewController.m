//
//  LxDBAnythingViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/30.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "LxDBAnythingViewController.h"
#import "SGHAnythingTestModel.h"


@interface LxDBAnythingViewController ()

@end

@implementation LxDBAnythingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id obj = self.view;
    LxDBAnyVar(obj);
    
    CGPoint point = CGPointMake(12.34, 56.78);
    LxDBAnyVar(point);
    
    CGSize size = CGSizeMake(87.6, 5.43);
    LxDBAnyVar(size);
    
    CGRect rect = CGRectMake(2.3, 4.5, 5.6, 7.8);
    LxDBAnyVar(rect);
    
    NSRange range = NSMakeRange(3, 56);
    LxDBAnyVar(range);
    
    CGAffineTransform affineTransform = CGAffineTransformMake(1, 2, 3, 4, 5, 6);
    LxDBAnyVar(affineTransform);
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(3, 4, 5, 6);
    LxDBAnyVar(edgeInsets);
    
    SEL sel = @selector(viewDidLoad);
    LxDBAnyVar(sel);
    
    Class class = [UIBarButtonItem class];
    LxDBAnyVar(class);
    
    NSInteger i = 231;
    LxDBAnyVar(i);
    
    CGFloat f = M_E;
    LxDBAnyVar(f);
    
    BOOL b = YES;
    LxDBAnyVar(b);
    
    char c = 'S';
    LxDBAnyVar(c);
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    LxDBAnyVar(colorSpaceRef);
    
    //  ......
    
    LxPrintAnything(You can use macro LxPrintAnything() print any without quotation as you want!);
    
    LxPrintf(@"Print format string you customed: %@", LxBox(affineTransform));
    
    NSLog(@"Even use general NSLog function to print: %@", LxBox(edgeInsets));
    
    LxPrintf(@"The type of obj is %@", LxTypeStringOfVar(obj));
    LxPrintf(@"The type of point is %@", LxTypeStringOfVar(point));
    LxPrintf(@"The type of size is %@", LxTypeStringOfVar(size));
    LxPrintf(@"The type of rect is %@", LxTypeStringOfVar(rect));
    LxPrintf(@"The type of range is %@", LxTypeStringOfVar(range));
    LxPrintf(@"The type of affineTransform is %@", LxTypeStringOfVar(affineTransform));
    LxPrintf(@"The type of edgeInsets is %@", LxTypeStringOfVar(edgeInsets));
    LxPrintf(@"The type of class is %@", LxTypeStringOfVar(class));
    LxPrintf(@"The type of i is %@", LxTypeStringOfVar(i));
    LxPrintf(@"The type of f is %@", LxTypeStringOfVar(f));
    LxPrintf(@"The type of b is %@", LxTypeStringOfVar(b));
    LxPrintf(@"The type of c is %@", LxTypeStringOfVar(c));
    LxPrintf(@"The type of colorSpaceRef is %@", LxTypeStringOfVar(colorSpaceRef));
    
    //  ......
    
    SGHAnythingTestModel * testModel = [[SGHAnythingTestModel alloc]init];
    testModel.array = @[@1, @"fewfwe", @{@21423.654:@[@"fgewgweg", [UIView new]]}, @YES];
    testModel.dictionary = @{@YES:@[[UITableViewCell new], @"fgewgweg", @-543.64]};
    testModel.set = [NSSet setWithObjects:@NO, @4.325, @{@"fgewgweg":[UIView new]}, nil];
    testModel.orderSet = [NSOrderedSet orderedSetWithObjects:@{@21423.654:@[@"fgewgweg", [UIView new]]}, @1, @"fewfwe", @YES, nil];
    
    LxDBObjectAsJson(testModel);
    LxDBObjectAsXml(testModel);
    //LxDBViewHierarchy(self.view.window);
    LxDBViewHierarchy(self.view);//入参是UIView及其子类，否则会NSCAssert
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
