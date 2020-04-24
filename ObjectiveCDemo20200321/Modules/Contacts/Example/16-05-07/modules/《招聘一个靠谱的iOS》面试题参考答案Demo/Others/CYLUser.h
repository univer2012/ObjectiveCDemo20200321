//
//  CYLUser.h
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/12/11.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

//.h文件
//http://weibo.com/luohanchengyilong/
//https://github.com/ChenYilong
//
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, CYLSex) {
    CYLSexMan,
    CYLSexWoman
};

@interface CYLUser : NSObject<NSCopying,NSMutableCopying>
@property(nonatomic,copy,readonly)NSString *name;
@property(nonatomic,assign, readonly)NSUInteger age;
@property(nonatomic,assign, readonly)CYLSex sex;

- (instancetype)initWithName:(NSString *)name age:(int)age sex:(CYLSex)sex;
+ (instancetype)userWithName:(NSString *)name age:(int)age sex:(CYLSex)sex;
- (void)addFriend:(CYLUser *)user;
- (void)removeFriend:(CYLUser *)user;
@end
