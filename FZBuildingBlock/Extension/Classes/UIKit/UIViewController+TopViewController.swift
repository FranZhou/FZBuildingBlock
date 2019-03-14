//
//  UIViewController+TopViewController.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/28.
//

import Foundation


extension UIViewController {
    
    /// 得到当前正在显示的ViewController
    ///
    /// - Parameter rootWindow: default = UIApplication.shared.delegate?.window
    /// - Returns:
    public static func fz_getTopViewController(rootWindow: UIWindow?? = UIApplication.shared.delegate?.window) -> UIViewController?{
        guard let delegateWindow = rootWindow,
            let window = delegateWindow
            else {
                return nil
        }
        
        return window.rootViewController?.fz_getTopViewController()
    }
    
}

extension UIViewController {
    
    
    /// 从当前vc开始，查找当前正在显示的ViewController
    ///
    /// - Returns:
    public func fz_getTopViewController() -> UIViewController {
        
        // presented
        if let presentedVC = self.presentedViewController{
            return presentedVC.fz_getTopViewController()
        }
        
        // navigation
        if self.isKind(of: UINavigationController.self) {
            if let topVC = (self as! UINavigationController).visibleViewController {
                return topVC.fz_getTopViewController()
            }
        }
        
        // tarbbar
        if self.isKind(of: UITabBarController.self){
            if let selectVC = (self as! UITabBarController).selectedViewController {
                return selectVC.fz_getTopViewController()
            }
        }
        
        return self
    }
    
}
