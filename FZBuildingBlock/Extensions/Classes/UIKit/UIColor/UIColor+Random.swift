//
//  UIColor+Random.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/5.
//

import Foundation

extension UIColor.fz {

    /// 生成随机色
    ///
    /// - Parameter alpha: [0, 1] 默认 1
    /// - Returns:
    public static func randomColor(alpha: CGFloat = 1.0) -> UIColor {
        let r = CGFloat(arc4random() % 256)
        let g = CGFloat(arc4random() % 256)
        let b = CGFloat(arc4random() % 256)
        return UIColor.fz.color(red: r, green: g, blue: b, alpha: alpha)
    }
}
