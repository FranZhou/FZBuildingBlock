//
//  UINavigationController+Root.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/5.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UINavigationController {

    /// 获取rootViewController
    ///
    /// - Returns: rootViewController
    public func rootViewController() -> UIViewController? {
        return base.viewControllers.first
    }

    /// 判断是否只有rootViewController
    ///
    /// - Returns: 是否只有rootViewController
    public func isOnlyContainRootViewController() -> Bool {
        return base.viewControllers.count == 1
    }

    /// 判断viewController是否是rootViewController
    ///
    /// - Parameter viewController: viewController
    /// - Returns: 是否是rootViewController
    public func isRootViewController(_ viewController: UIViewController) -> Bool {
        if let rootViewController = rootViewController() {
            return rootViewController == viewController
        }
        return false
    }
}
