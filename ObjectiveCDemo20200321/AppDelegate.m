//
//  AppDelegate.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/21.
//  Copyright © 2020 远平. All rights reserved.
//

#import "AppDelegate.h"
#import "SGH161128TabBarViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

+ (id<UIApplicationDelegate>)sharedDelegate {
    return [UIApplication sharedApplication].delegate;
}

/** 后台下载任务完成后，程序被唤醒，该方法将被调用 */
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler {
    NSLog(@"Application Delegate: Background download task finished");
    
    // 设置回调的完成代码块
    self.backgroundURLSessionCompletionHandler = completionHandler;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"path: %@",path);
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    SGH161128TabBarViewController *tabBarController = [SGH161128TabBarViewController new];
    
    self.window.rootViewController = tabBarController;
    
    //[[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    NSLog(@"%s",__func__);
    
    
    if (@available(iOS 9.0, *)) {
        UIApplicationShortcutIcon *searchIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
        
        UIApplicationShortcutItem *search = [[UIApplicationShortcutItem alloc] initWithType:@"search" localizedTitle:@"搜索" localizedSubtitle:nil icon:searchIcon userInfo:nil];
        
        UIApplicationShortcutIcon *publicIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"upload"];
        
        UIApplicationShortcutItem *public = [[UIApplicationShortcutItem alloc] initWithType:@"public" localizedTitle:@"一键发布" localizedSubtitle:nil icon:publicIcon userInfo:nil];
        
        UIApplicationShortcutItem *list = [[UIApplicationShortcutItem alloc] initWithType:@"list" localizedTitle:@"榜单" localizedSubtitle:@"全区排行" icon:nil userInfo:nil];
        
        application.shortcutItems = @[list, public, search];
        
    }
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%s",__func__);
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"%s",__func__);
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%s",__func__);
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%s",__func__);
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"%s",__func__);
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    NSLog(@"%s",__func__);
}


- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    NSLog(@"%s", __FUNCTION__);
    
    if ([shortcutItem.type isEqualToString:@"search"]) {
        NSLog(@"用户从快捷方式“搜索”进来的");
    } else if ([shortcutItem.type isEqualToString:@"list"]) {
        NSLog(@"用户从快捷方式“榜单”进来的");
    } else if ([shortcutItem.type isEqualToString:@"public"]) {
        NSLog(@"用户从快捷方式“一键发布”进来的");
    }
    
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.thinkive.invest.CoreDataDemo_16_04_06" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Model.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
