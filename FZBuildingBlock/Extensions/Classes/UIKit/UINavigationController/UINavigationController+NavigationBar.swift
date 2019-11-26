//
//  UINavigationController+NavigationBar.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/6.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UINavigationController {

    public var navigationBarHeight: CGFloat {
        get {
            return base.navigationBar.frame.size.height
        }
    }

    public var navigationBarAndStatusBarHeight: CGFloat {
        get {
            return UIApplication.shared.fz.statusBarHeight + navigationBarHeight
        }
    }

}
