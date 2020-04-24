//
//  SGHBanner3DTransitionView.h
//  BannerTransitionType
//
//  Created by huangaengoln on 16/1/27.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import <UIKit/UIKit.h>


#define MainScreenH [UIScreen mainScreen].bounds.size.height
#define MainScreenW [UIScreen mainScreen].bounds.size.width

@protocol SGHBanner3DTransitionViewImageDelegate

-(void)ClickImage:(int)index;

@end

@interface SGHBanner3DTransitionView : UIView

@property (nonatomic, assign)int currentIndex;//当前图片的下标

@property (nonatomic, strong)UIImageView *imageView;//图片

@property (nonatomic, strong)NSArray *imageArr;//图片数组

@property (assign, nonatomic) id <SGHBanner3DTransitionViewImageDelegate> delegate;

- (void)show3DBannerView;

@end
