//
//  UIApplication+StatusBar.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/5.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UIApplication {

    /// statusBarHeight
    public var statusBarHeight: CGFloat {
        get {
            return base.statusBarFrame.height
        }
    }

    /// 状态栏旋转菊花是否展示
    ///
    /// - Parameter visible: visible
    public func networkActivity(visible: Bool) {
        base.isNetworkActivityIndicatorVisible = visible
    }

}
