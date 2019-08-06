//
//  UITabBarController+TabBar.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/6.
//

import Foundation

extension UITabBarController{
    
    
    /// 竖屏情况下，tabBarHeight
    public var fz_tabBarHeight: CGFloat {
        get{
            return tabBar.frame.size.height
        }
    }
    
    
    public var fz_tabBarAndSafeAreaHeight: CGFloat{
        get{
            return fz_tabBarHeight + UIApplication.shared.fz_safeArea.bottom
        }
    }
}
