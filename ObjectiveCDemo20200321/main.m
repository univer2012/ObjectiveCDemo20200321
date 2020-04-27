//
//  main.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/21.
//  Copyright © 2020 远平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//#import <FBRetainCycleDetector/FBAssociationManager.h>

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        //[FBAssociationManager hook];
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
