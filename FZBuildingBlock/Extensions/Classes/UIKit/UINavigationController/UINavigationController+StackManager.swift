//
//  UINavigationController+Common.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/28.
//

import Foundation

// MARK: -
extension FZBuildingBlockWrapper where Base: UINavigationController {

    /// 导航栏控制器销毁指定level层控制器后进行push操作
    ///
    /// - Parameters:
    ///   - viewController: push viewController
    ///   - animated: animated
    ///   - destoryExtraLevel: default = 0, 小于0时，当0来处理
    public func pushViewController(_ viewController: UIViewController, animated: Bool = true, destoryExtraLevel: Int = 0) {
        let validateDestoryLevel = destoryExtraLevel >= 0 ? destoryExtraLevel : 0
        let vcs = base.viewControllers
        let maxIndex = vcs.count - 1

        // destory后的index
        var index = maxIndex - validateDestoryLevel
        if index < 0 {
            index = 0
        } else if index >= maxIndex {
            index = maxIndex
        }
        var newVCs: [UIViewController] = []

        // 应该不会有 vcs.count = 0 的情况，这里保证逻辑完整性
        if vcs.count != 0, index > 0 {
            newVCs.append(contentsOf: vcs[0...index])
        }

        // destory后，再添加需要push的viewController
        newVCs.append(viewController)
        base.setViewControllers(newVCs, animated: animated)
    }

    /// 导航栏控制器pop操作时，额外消除指定level的控制器，导航栏会至少保证根控制器不被pop
    ///
    /// - Parameters:
    ///   - animated: animated
    ///   - destoryExtraLevel: default = 0, 小于0时，当0来处理
    /// - Returns:
    @discardableResult
    public func popViewController(animated: Bool = true, destoryExtraLevel: Int = 0) -> [UIViewController]? {
        let validateDestoryLevel = destoryExtraLevel >= 0 ? destoryExtraLevel : 0
        let vcs = base.viewControllers
        let maxIndex = vcs.count - 1

        // pop后的index
        var index = maxIndex - validateDestoryLevel - 1

        // 边界判断
        if index < 0 {
            index = 0
        } else if index >= maxIndex {
            index = maxIndex
        }

        if vcs.count > index {
            let toVC = vcs[index]
            return base.popToViewController(toVC, animated: animated)
        } else {
            return nil
        }
    }

}
