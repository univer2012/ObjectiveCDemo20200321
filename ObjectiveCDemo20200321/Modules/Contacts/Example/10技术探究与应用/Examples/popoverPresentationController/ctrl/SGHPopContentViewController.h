//
//  SGHPopContentViewController.h
//  ObjectiveCDemo
//
//  Created by huangaengoln on 16/3/12.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^didSelectRowAtIndexPathBlock)(NSInteger index);

@interface SGHPopContentViewController : UIViewController
@property(nonatomic,strong)didSelectRowAtIndexPathBlock selectedBlock;
@property(nonatomic,strong)NSDictionary *paramDictionary;

@end
