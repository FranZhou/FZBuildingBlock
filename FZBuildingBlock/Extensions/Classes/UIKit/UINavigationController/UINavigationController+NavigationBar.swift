//
//  UINavigationController+NavigationBar.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/6.
//

import Foundation

extension UINavigationController{
    
    public var fz_navigationBarHeight: CGFloat {
        get{
            return navigationBar.frame.size.height
        }
    }
    
    public var fz_navigationBarAndStatusBarHeight: CGFloat {
        get{
            return UIApplication.shared.fz_statusBarHeight + fz_navigationBarHeight
        }
    }
    
}
