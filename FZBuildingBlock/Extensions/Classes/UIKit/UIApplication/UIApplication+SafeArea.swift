//
//  UIScreen+SafeArea.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/5.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UIApplication {

    /// safeArea会随着屏幕旋转而变化
    public var safeArea: UIEdgeInsets {
        get {
            if #available(iOS 11.0, *),
                let safeAreaInsets = base.keyWindow?.safeAreaInsets {
                return safeAreaInsets
            } else {
                return .zero
            }
        }
    }

}
