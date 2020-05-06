//
//  SGH0510Runtime2ViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/10.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0510Runtime2ViewController.h"
#import "UIView+SGHTapGesture.h"

#import "SGH0510MyObject.h"

@interface SGH0510Runtime2ViewController ()

@end

@implementation SGH0510Runtime2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self p_testEncode];
    
    self.type = SHBaseTableTypeMethod;
    
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"1.类型编码(Type Encoding)",
        @"2.关联对象(Associated Object) \n动态地将一个Tap手势操作连接到任何`UIView`中，并且根据需要指定点击后的实际操作",
        @"3.通过 `property_getAttributes(property)`获取到attributes并打印出来之后的结果"
    ];
    NSArray *tempClassNameArray = @[
        @"p_testEncode",
        @"demo2",
        @"demo3",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@""];
    
    [self.tableView reloadData];
    
    
}
//MARK: 3.通过 `property_getAttributes(property)`获取到attributes并打印出来之后的结果
- (void)demo3 {
    
    NSMutableDictionary *map = [NSMutableDictionary dictionary];
    map[@"name1"] = @"name";
    map[@"status1"] = @"status";
    map[@"name2"] = @"name";
    map[@"status2"] = @"status";
    
    [[SGH0510MyObject alloc] initWithDict:map];
}


//MARK: 2.关联对象(Associated Object) \n动态地将一个Tap手势操作连接到任何`UIView`中，并且根据需要指定点击后的实际操作
- (void)demo2 {
    UIView *testView = ({
           UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
           view.backgroundColor = [UIColor blueColor];
           view.center = self.view.center;
           [self.view addSubview:view];
           view;
       });
       [testView setTapActionWithBlock:^{
           NSLog(@"setTapActionWithBlock");
       }];
}

//MARK: 1.类型编码(Type Encoding)
-(void)p_testEncode {
    float a[] = {1.0, 2.0, 3.0};
    NSLog(@"array encoding type: %s", @encode(typeof(a)));
    NSLog(@"a: %f", a);
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
