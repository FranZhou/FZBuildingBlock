//
//  UIScreen+Navigation.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/5.
//

import Foundation

extension UIScreen{
    
    /// navigationBarHeight
    public static let fz_navigationBarHeight: CGFloat = {
        return 44
    }()
    
    /// navigationBarHeight && statusBarHeight
    public static let fz_navigationBarAndStatusBarHeight: CGFloat = {
        return UIApplication.fz_statusBarHeight + fz_navigationBarHeight
    }()
}
