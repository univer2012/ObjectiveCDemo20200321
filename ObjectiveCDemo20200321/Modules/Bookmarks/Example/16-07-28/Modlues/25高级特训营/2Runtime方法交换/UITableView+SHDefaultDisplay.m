//
//  UITableView+SHDefaultDisplay.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/2/27.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "UITableView+SHDefaultDisplay.h"

#import <objc/runtime.h>
#import <objc/message.h>

const char *LGDefaultView;

@implementation UITableView (SHDefaultDisplay)

+ (void)load {
    Method originMethod = class_getInstanceMethod(self,@selector(reloadData));
    Method currentMethod = class_getInstanceMethod(self,@selector(lg_reloadData));
    
    method_exchangeImplementations(originMethod, currentMethod);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //Method originMethod = class_getInstanceMethod(self,@selecror(reloadData));
    });
    
}
- (void)lg_reloadData {
    [self lg_reloadData];
    [self fillDefaultView];
}
- (void)fillDefaultView {
    id<UITableViewDataSource> dataSource = self.dataSource;
    NSInteger section = ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)] ? [dataSource numberOfSectionsInTableView:self] : 1);
    
    NSInteger rows = 0;
    for (NSInteger i = 0; i < section; i++) {
        rows = [dataSource tableView:self numberOfRowsInSection:i];
    }
    if (!rows) {
//        self.lgDefaultView.hidden = NO;
        self.lgDefaultView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.lgDefaultView.backgroundColor = [UIColor redColor];
        [self addSubview:self.lgDefaultView];
    } else {
        self.lgDefaultView.hidden = YES;
    }
}

#pragma mark - Getter and setter
- (void)setLgDefaultView:(UIView *)lgDefaultView {
    objc_setAssociatedObject(self, &LGDefaultView, lgDefaultView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)lgDefaultView {
    return objc_getAssociatedObject(self, &LGDefaultView);
}

@end
