//
//  SGHSwitchDelegateViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/30.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHSwitchDelegateViewController.h"

@interface SGHSwitchDelegateViewController ()<UITableViewDataSource>

@end

@implementation SGHSwitchDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //RAC可以替换代理，但是 替换代理是有局限的，它只能替换一部分代理方法。哪一部分？ 没有返回值的代理方法
    
    //RAC不可以取代  那些 有返回值代理方法的作用
 
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"RAC" message:@"ReactiveCocoa" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ensure", nil];
#if 1
    //第一种写法
    [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple * tuple) {
        
        LxDBAnyVar(tuple);
        
        LxDBAnyVar(tuple.first);
        LxDBAnyVar(tuple.second);
        LxDBAnyVar(tuple.third);
    }];
    [alertView show];
#elif 0
    //第二种写法
    [[alertView rac_buttonClickedSignal]
    subscribeNext:^(NSNumber * x) {
        LxDBAnyVar(x);  //x 就是返回不button的序号。它实际类型是NSNumber类型
    }];
    [alertView show];
    
#endif
}

//举个例子：下面这个方法是不能用RAC替换的，它有返回值
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
//像下面这种，没有返回值的代理，可以替换
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
