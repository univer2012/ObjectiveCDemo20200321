//
//  SGH0510Runtime2ViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/10.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0510Runtime2ViewController.h"
#import "UIView+SGHTapGesture.h"


@interface SGH0510Runtime2ViewController ()

@end

@implementation SGH0510Runtime2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self p_testEncode];
    
    
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
