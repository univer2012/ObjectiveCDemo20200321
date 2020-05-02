//
//  UIView+NeastPublic.swift
//  ObjectiveCDemo
//
//  Created by Mac on 2020/4/30.
//  Copyright © 2020 远平. All rights reserved.
//

import Foundation


extension UIView {
   @objc func commonSuperview_2(of view: UIView) -> UIView? {
        return superview.flatMap {
           view.isDescendant(of: $0) ?
             $0 : $0.commonSuperview_2(of: view)
        }
        
        //Descendant [dɪˈsendənt] n. 后裔，子孙；
    }
    
    /// without flatMap
    @objc func commonSuperview_1(of view: UIView) -> UIView? {
        if let s = superview {
            
           if view.isDescendant(of: s) {
                return s
            } else {
                return s.commonSuperview_1(of: view)
            }
        }
        return nil
    }
    
}

