//
//  UIColor+RGB255.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/3.
//

import Foundation
import UIKit

extension UIColor.fz {

    /// RGBA 颜色
    ///
    /// - Parameters:
    ///   - red: [0, 255]
    ///   - green: [0, 255]
    ///   - blue: [0, 255]
    ///   - alpha: [0, 1] 默认 1
    /// - Returns:
    public static func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}
