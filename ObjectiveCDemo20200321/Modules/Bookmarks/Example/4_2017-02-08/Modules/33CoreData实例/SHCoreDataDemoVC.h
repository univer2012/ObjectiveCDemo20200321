//
//  SHCoreDataDemoVC.h
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/15.
//  Copyright © 2019 huangaengoln. All rights reserved.
//


/*把这个Demo移到这里时，出现了一个问题：添加`Model.xcdatamodeld`，一切准备就绪后，运行，报错
 `SWIFT_VERSION cannot be empty.(in target 'XXXX')` 意思是Swift版本是空的，没有设置。但是Build Settings中一直找不到Swift的字段。
 
 后来百度，找到了这篇文章：
 [使用CoreData报错 error: Value for SWIFT_VERSION cannot be empty.](https://www.jianshu.com/p/c9c02534ae61)
 
 原来是创建`Model.xcdatamodeld`时默认的是Swift语言，只需要在右边的`Inspectors` --> `Show the File inspector` --> `Language` 设置为`Objective-C`即可
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHCoreDataDemoVC : UIViewController

@end

NS_ASSUME_NONNULL_END
