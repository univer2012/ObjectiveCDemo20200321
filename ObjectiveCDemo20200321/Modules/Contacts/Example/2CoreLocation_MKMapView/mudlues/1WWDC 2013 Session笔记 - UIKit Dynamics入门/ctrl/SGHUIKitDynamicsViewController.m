//
//  SGHUIKitDynamicsViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/5/19.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHUIKitDynamicsViewController.h"

@interface SGHUIKitDynamicsViewController ()<UICollisionBehaviorDelegate>
@property(nonatomic,strong)UIDynamicAnimator *animator;

@property(nonatomic,strong)UIView *square1;
@property(nonatomic,strong)UIAttachmentBehavior* attachmentBehavior;

@end

@implementation SGHUIKitDynamicsViewController


-(void)viewDidLoad {
    [super viewDidLoad];
    
#if 1
    
    // ==== three
    
    _square1 = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 100, 100)];
    _square1.backgroundColor = [UIColor lightGrayColor];
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleAttachmentGesture:)];
    [_square1 addGestureRecognizer:pan];
    [self.view addSubview:_square1];
    
    UIDynamicAnimator* animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.square1]];
    
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [animator addBehavior:collisionBehavior];
    
    UIGravityBehavior *g = [[UIGravityBehavior alloc] initWithItems:@[self.square1]];
    [animator addBehavior:g];
    
    self.animator = animator;
    
#elif 0
    // ==== two
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 100, 100)];
    aView.backgroundColor = [UIColor lightGrayColor];
    //加个角度
    aView.transform = CGAffineTransformRotate(aView.transform, 45);
    [self.view addSubview:aView];
    
    UIDynamicAnimator* animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    //Gravity
    UIGravityBehavior* gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[aView]];
    [animator addBehavior:gravityBeahvior];
    
    //Collision
    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[aView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [animator addBehavior:collisionBehavior];
    collisionBehavior.collisionDelegate = self;
    
    self.animator = animator;
    
    
    
#elif 0
    /// ==== one
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 100, 100)];
    aView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:aView];
    
    UIDynamicAnimator* animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UIGravityBehavior* gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[aView]];
    [animator addBehavior:gravityBeahvior];
    self.animator = animator;
    
#endif
    
}

-(void)handleAttachmentGesture:(UIPanGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan){
        
        CGPoint location = [gesture locationInView:self.view];
        CGPoint boxLocation = [gesture locationInView:self.square1];
        UIOffset centerOffset = UIOffsetMake(boxLocation.x - CGRectGetMidX(self.square1.bounds), boxLocation.y - CGRectGetMidY(self.square1.bounds));
        
        UIAttachmentBehavior* attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.square1 offsetFromCenter:centerOffset attachedToAnchor:location];
        attachmentBehavior.damping = 0.5;
        attachmentBehavior.frequency = 0.8;
        
        self.attachmentBehavior = attachmentBehavior;
        [self.animator addBehavior:attachmentBehavior];
        
//        UIActivityViewController
//        UIActivityTypePostToWeibo
        
        
        
#if 0
        CGPoint squareCenterPoint = CGPointMake(self.square1.center.x, self.square1.center.y - 100.0);
        CGPoint attachmentPoint = CGPointMake(-25.0, -25.0);
        UIOffset offset = UIOffsetMake(0, 0);
        
        UIAttachmentBehavior* attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.square1 point:attachmentPoint attachedToAnchor:squareCenterPoint];
        
        self.attachmentBehavior = attachmentBehavior;
        [self.animator addBehavior:attachmentBehavior];
#endif
        
        
    } else if ( gesture.state == UIGestureRecognizerStateChanged) {
        
        [self.attachmentBehavior setAnchorPoint:[gesture locationInView:self.view]];
        
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        [self.animator removeBehavior:self.attachmentBehavior];
    }

}

@end
