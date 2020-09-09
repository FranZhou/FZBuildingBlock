//
//  UIWindow+Theme.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/8.
//

import Foundation
import UIKit

extension UIWindow {

    @objc public func fz_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.fz_traitCollectionDidChange(previousTraitCollection)

        guard let previous = previousTraitCollection else {
            return
        }

        if #available(iOS 13.0, *) {
            let current = UITraitCollection.current
            if current.userInterfaceStyle != previous.userInterfaceStyle {
                if UIApplication.shared.applicationState == .background {
                    // 切换到后台去了，这里避免重复执行
                } else {
                    FZThemeManager.manager.switchCurrentSystemTheme(to: current.userInterfaceStyle)
                }
            }

        } else {
            // Fallback on earlier versions
        }

    }

}
