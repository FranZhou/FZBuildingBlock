//
//  UIScreen+SafeArea.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/5.
//

import Foundation

extension UIApplication{
    
    /// safeArea会随着屏幕旋转而变化
    public static var fz_safeArea: UIEdgeInsets {
        if #available(iOS 11.0, *),
            let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets{
            return safeAreaInsets
        } else {
            return .zero
        }
    }
    
}
