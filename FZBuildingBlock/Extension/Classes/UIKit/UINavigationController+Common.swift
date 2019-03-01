//
//  UINavigationController+Common.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/28.
//

import Foundation


extension UINavigationController {
    
    
    /// 导航栏控制器销毁指定level层控制器后进行push操作
    ///
    /// - Parameters:
    ///   - viewController: push viewController
    ///   - animated: animated
    ///   - destoryExtraLevel: default = 0, 小于0时，当0来处理
    public func fz_pushViewController(_ viewController: UIViewController, animated: Bool = true, destoryExtraLevel: Int = 0){
        let validateDestoryLevel = destoryExtraLevel >= 0 ? destoryExtraLevel : 0
        let vcs = self.viewControllers
        let maxIndex = vcs.count - 1
        var index = maxIndex - validateDestoryLevel
        if index < 0 {
            index = 0
        } else if index >= maxIndex{
            index = maxIndex
        }
        var newVCs: [UIViewController] = []
        
        // 应该不会与 vcs.count = 0 的情况，这里保证逻辑完整性
        if vcs.count != 0 {
            newVCs.append(contentsOf: vcs[0...index])
        }
        newVCs.append(viewController)
        self.setViewControllers(newVCs, animated: animated)
    }
    
    
    /// 导航栏控制器pop操作时，额外消除指定level的控制器
    ///
    /// - Parameters:
    ///   - animated: animated
    ///   - destoryExtraLevel: default = 0, 小于0时，当0来处理
    /// - Returns:
    @discardableResult
    public func fz_popViewController(animated: Bool = true, destoryExtraLevel: Int = 0) -> [UIViewController]?{
        let validateDestoryLevel = destoryExtraLevel >= 0 ? destoryExtraLevel : 0
        let vcs = self.viewControllers
        let maxIndex = vcs.count - 1
        var index = maxIndex - validateDestoryLevel - 1
        
        if index < 0 {
            index = 0
        } else if index >= maxIndex{
            index = maxIndex
        }
        
        // 应该不会与 vcs.count = 0 的情况，这里保证逻辑完整性
        if vcs.count > 0 {
            let toVC = vcs[index]
            return self.popToViewController(toVC, animated: animated)
        } else {
            return nil
        }
    }
    
}
