//
//  FKUser.h
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/11/22.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKUser : NSObject<NSCopying>
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *pass;
-(id)initWithName:(NSString *)aName pass:(NSString *)aPass;
-(void)say:(NSString *)content;
@end
