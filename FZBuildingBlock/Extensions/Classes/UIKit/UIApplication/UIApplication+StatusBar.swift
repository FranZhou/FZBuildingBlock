//
//  UIApplication+StatusBar.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/5.
//

import Foundation

extension UIApplication{
    
    /// statusBarHeight
    public static let fz_statusBarHeight: CGFloat = {
        return UIApplication.shared.statusBarFrame.height
    }()
    
}
