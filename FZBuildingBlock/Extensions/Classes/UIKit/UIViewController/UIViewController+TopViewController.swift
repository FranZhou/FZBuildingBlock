//
//  UIViewController+TopViewController.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/28.
//

import Foundation

extension UIViewController.fz {

    /// 得到当前正在显示的ViewController
    ///
    /// - Parameter rootWindow: default = UIApplication.shared.delegate?.window
    /// - Returns:
    public static func getTopViewController(rootWindow: UIWindow? = UIApplication.shared.windows.first) -> UIViewController? {
        guard let window = rootWindow
            else {
                return nil
        }

        return window.rootViewController?.fz.getTopViewController()
    }

}

extension FZBuildingBlockWrapper where Base: UIViewController {

    /// 从当前vc开始，查找当前正在显示的ViewController
    ///
    /// - Returns:
    public func getTopViewController() -> UIViewController {

        if let presentedVC = base.presentedViewController {
            // presented
            return presentedVC.fz.getTopViewController()
        } else if let splitVC = base as? UISplitViewController {
            // splite
            if let lastVC = splitVC.viewControllers.last {
                return lastVC.fz.getTopViewController()
            }
        } else if let navigationVC = base as? UINavigationController {
            // navigation
            if let topVC = navigationVC.topViewController {
                return topVC.fz.getTopViewController()
            }
        } else if let tabbarVC = base as? UITabBarController {
            // tarbbar
            if let selectVC = tabbarVC.selectedViewController {
                return selectVC.fz.getTopViewController()
            }
        }

        return base
    }

}
