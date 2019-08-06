//
//  UIApplication+StatusBar.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/5.
//

import Foundation

extension UIApplication{
    
    /// statusBarHeight
    public var fz_statusBarHeight: CGFloat {
        get{
            return statusBarFrame.height
        }
    }
    
    
    /// 状态栏旋转菊花是否展示
    ///
    /// - Parameter visible: visible
    public func fz_networkActivity(visible: Bool) {
        isNetworkActivityIndicatorVisible = visible
    }
    
}
