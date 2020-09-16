//
//  UIScreen+TabBar.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/5.
//

import Foundation

extension UIScreen.fz {

    public static var tabBarHeight: CGFloat {
        get {
            return 49
        }
    }

    public static var tabBarAndSafeAreaHeight: CGFloat {
        get {
            return UIApplication.shared.fz.safeArea.bottom + tabBarHeight
        }
    }

}
