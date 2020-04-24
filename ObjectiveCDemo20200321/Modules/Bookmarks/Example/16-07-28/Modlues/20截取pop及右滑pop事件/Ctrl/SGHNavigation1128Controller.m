//
//  SGHNavigation1128Controller.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2016/11/28.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHNavigation1128Controller.h"

@interface UINavigationController (NeedsShouldPopItem)
-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(nonnull UINavigationItem *)item;

@end
#pragma clang diagnostic push
#pragma clang diagnostic ignored"Wincomplete-implementation"
@implementation UINavigationController (NeedsShouldPopItem)
@end
#pragma clang diagnostic pop


@interface SGHNavigation1128Controller ()<UINavigationBarDelegate>

@end

@implementation SGHNavigation1128Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    UIViewController *viewController = self.topViewController;
    //都会调用这个方法，如果连续两个页面都有这种处理， 我们要怎么办？
    if (item != viewController.navigationItem) {
        return [super navigationBar:navigationBar shouldPopItem:item];
    }
    
    if ([viewController conformsToProtocol:@protocol(SGHNavigationControllerShouldPopProtocol)]) {
//        if ([(id<SGHNavigationControllerShouldPopProtocol>)viewController sg_navigationControllershouldPopWhenSystemBackButtonSelected:self]) {
//            return [super navigationBar:navigationBar shouldPopItem:item];
//        }
//        else {
//            return NO;
//        }
    }
    else {
        return [super navigationBar:navigationBar shouldPopItem:item];
    }
    return NO;
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
