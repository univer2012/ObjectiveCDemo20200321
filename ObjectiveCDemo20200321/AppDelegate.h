//
//  AppDelegate.h
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/21.
//  Copyright © 2020 远平. All rights reserved.
//


#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

+ (id<UIApplicationDelegate>)sharedDelegate;

/* 用于保存后台下载任务完成后的回调代码块 */
@property (copy) void (^backgroundURLSessionCompletionHandler)(void);

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

