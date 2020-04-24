//
//  SGH0424MapView.h
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/4/24.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//地图MapView协议
@protocol SGH0424MapView <NSObject>

//面向对象编程 （编程思想：抽象）
//规范 (父类的引用指向子类的实例对象 -- 多态)
-(UIView *)getView;


@end
