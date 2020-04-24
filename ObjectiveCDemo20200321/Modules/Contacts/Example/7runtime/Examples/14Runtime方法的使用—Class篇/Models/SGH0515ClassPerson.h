//
//  SGH0515ClassPerson.h
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/15.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RuntimeBaseProtocol <NSObject>

@property(nonatomic, strong)NSString *protocolString;

@optional
-(void)doBaseAction;

@end

//------------------------------------------------
@protocol RuntimeProtocol <NSObject, RuntimeBaseProtocol>

@optional
-(void)doOptionalAction;

@end

//------------------------------------------------
@interface SGH0515ClassPerson : NSObject<RuntimeProtocol>

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *gender;
@property(nonatomic,strong)NSString *age;
@property(nonatomic,strong)NSString *city;

-(void)runtimeTestAction1;
-(void)runtimeTestAction2;
-(void)runtimeTestAction3;

@end
