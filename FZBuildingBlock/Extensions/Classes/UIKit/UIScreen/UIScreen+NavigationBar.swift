//
//  UIScreen+NavigationBar.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/16.
//

import Foundation

extension UIScreen.fz {

    public static var navigationBarHeight: CGFloat {
        get {
            return 44
        }
    }

    public static var navigationBarAndStatusBarHeight: CGFloat {
        get {
            return UIApplication.shared.fz.statusBarHeight + navigationBarHeight
        }
    }

}
