//
//  CTMediator+A.swift
//  ObjectiveCDemo20200321
//
//  Created by blue on 2020/6/3.
//  Copyright © 2020 远平. All rights reserved.
//
/*
这个文件，是SGH_CTMediatorViewController 要去Avc。拿Avc的方法
*/
import CTMediator

public extension CTMediator {
    
    //Swift --> Swift
    //执行swift文件 `Target_A` 的 `Action_Extension_ViewController` 方法
    @objc func A_showSwift(callback:@escaping (String) -> Void) -> UIViewController? {
        // 1.动态获取命名空间
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"]as? String else {
            return nil
        }
        
        let params = [
            "callback":callback,
            kCTMediatorParamsKeySwiftTargetModuleName: nameSpace
            ] as [AnyHashable : Any]
        
        if let viewController = self.performTarget("A", action: "Extension_ViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
    
    //Swift --> Objective-C
    //执行OC文件 `Target_A` 的 `Action_Extension_ViewController` 方法
    @objc func A_showObjc(callback:@escaping (String) -> Void) -> UIViewController? {
        let callbackBlock = callback as @convention(block) (String) -> Void
        
        let callbackBlockObject = unsafeBitCast(callbackBlock, to: AnyObject.self)
        
        let params = ["callback":callbackBlockObject] as [AnyHashable:Any]
        
        if let viewController = self.performTarget("A", action: "Extension_ViewController", params: params, shouldCacheTarget: false) as? UIViewController {
            return viewController
        }
        return nil
    }
}
