//
//  SGH0727CollectionViewController.h
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/7/27.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGH0727CollectionViewController : UIViewController

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, assign) NSInteger totalItemsCount;
@property (nonatomic, strong) UIControl *pageControl;

@end
