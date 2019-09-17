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
    public static func getTopViewController(rootWindow: UIWindow?? = UIApplication.shared.delegate?.window) -> UIViewController? {
        guard let delegateWindow = rootWindow,
            let window = delegateWindow
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

        // presented
        if let presentedVC = base.presentedViewController {
            return presentedVC.fz.getTopViewController()
        }

        // navigation
        if base.isKind(of: UINavigationController.self) {
            if let topVC = (base as! UINavigationController).visibleViewController {
                return topVC.fz.getTopViewController()
            }
        }

        // tarbbar
        if base.isKind(of: UITabBarController.self) {
            if let selectVC = (base as! UITabBarController).selectedViewController {
                return selectVC.fz.getTopViewController()
            }
        }

        return base
    }

}
