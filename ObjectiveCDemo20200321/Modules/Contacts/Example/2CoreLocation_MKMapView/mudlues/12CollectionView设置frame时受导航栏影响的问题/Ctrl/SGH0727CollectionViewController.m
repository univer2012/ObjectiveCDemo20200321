//
//  SGH0727CollectionViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/7/27.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH0727CollectionViewController.h"

@interface SGH0727CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation SGH0727CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
     @property(nonatomic, assign) UIRectEdge edgesForExtendedLayout
     Description	The extended edges to use for the layout.
     描述             用于布局的扩展边缘
     Availability	iOS (7.0 and later)
     Declared In	UIViewController.h
     */
    //如果不设置这个属性，push到这个控制器时，初始化时对 _collectionView.frame.origin.y 的设置将不生效。
    self.edgesForExtendedLayout  = UIEventSubtypeNone;
    
    
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    
    [self initCollectionViewUI];
    
}

-(void)initCollectionViewUI{
    
    _flowLayout =[[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(200, 230);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
   
    _collectionView  = [[UICollectionView alloc] initWithFrame: CGRectMake(10, 60, 200, 230) collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = [UIColor blackColor];
    
    
    //
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    
    [self.view addSubview:_collectionView];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return  CGSizeMake(0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return  CGSizeMake(0, 0);
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake(200, 230);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}
//UICollectionView只能通过regist注册cell，不能手动创建
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row == 1)
    {
        cell.backgroundColor = [UIColor redColor];
        
    }else{
        cell.backgroundColor = [UIColor purpleColor];
        
    }
    return cell;
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
