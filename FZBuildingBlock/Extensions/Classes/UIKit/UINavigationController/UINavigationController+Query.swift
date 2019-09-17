//
//  UINavigationController+Query.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/6.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UINavigationController {

    /// 寻找Navigation中的某个类型的对象
    ///
    /// - Parameter clz: viewcontroler的类型
    /// - Returns: array of touple (index: Int, viewController: UIViewController)
    public func findViewController(withFilter clz: AnyClass) -> [(index: Int, viewController: UIViewController)] {
        var queryResult: [(index: Int, viewController: UIViewController)] = []
        for (index, viewController) in base.viewControllers.enumerated() {
            if viewController.isKind(of: clz) {
                queryResult.append((index, viewController))
            }
        }
        return queryResult
    }

    /// 寻找Navigation中的某个viewController的位置
    ///
    /// - Parameter viewController: viewcontroler对象
    /// - Returns: viewcontroler的位置
    public func findViewController(viewController: UIViewController) -> Int? {
        return base.viewControllers.firstIndex(of: viewController)
    }

}
