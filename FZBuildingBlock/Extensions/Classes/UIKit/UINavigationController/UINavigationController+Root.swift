//
//  UINavigationController+Root.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/5.
//

import Foundation

extension UINavigationController{
    
    
    /// 获取rootViewController
    ///
    /// - Returns: rootViewController
    public func fz_rootViewController() -> UIViewController?{
        return viewControllers.first
    }
    
    
    /// 判断是否只有rootViewController
    ///
    /// - Returns: 是否只有rootViewController
    public func fz_isOnlyContainRootViewController() -> Bool{
        return viewControllers.count == 1
    }
    
    
    /// 判断viewController是否是rootViewController
    ///
    /// - Parameter viewController: viewController
    /// - Returns: 是否是rootViewController
    public func fz_isRootViewController(_ viewController: UIViewController) -> Bool{
        if let rootViewController = fz_rootViewController() {
            return rootViewController == viewController
        }
        return false
    }
}
