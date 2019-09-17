//
//  UITabBarController+TabBar.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/6.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UITabBarController {

    /// 竖屏情况下，tabBarHeight
    public var tabBarHeight: CGFloat {
        get {
            return base.tabBar.frame.size.height
        }
    }

    public var tabBarAndSafeAreaHeight: CGFloat {
        get {
            return tabBarHeight + UIApplication.shared.fz.safeArea.bottom
        }
    }
}
