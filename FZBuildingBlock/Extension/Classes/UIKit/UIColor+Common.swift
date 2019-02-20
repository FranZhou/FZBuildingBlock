//
//  UIColor+Common.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/3.
//

import Foundation
import UIKit

extension UIColor{
    
    
    /// RGBA 颜色
    ///
    /// - Parameters:
    ///   - red: [0, 255]
    ///   - green: [0, 255]
    ///   - blue: [0, 255]
    ///   - alpha: [0, 1] 默认 1
    /// - Returns:
    public class func fz_color(red:CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor{
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    
    /// 十六进制颜色
    ///
    /// - Parameters:
    ///   - rgbHex: [0x000000, 0xffffff]
    ///   - alpha: [0, 1] 默认 1
    /// - Returns:
    public class func fz_color(rgbHex: UInt32, alpha: CGFloat = 1.0) -> UIColor{
        let r = CGFloat((rgbHex & 0xff0000) >> (4 * 4))
        let g = CGFloat((rgbHex & 0x00ff00) >> (2 * 4))
        let b = CGFloat((rgbHex & 0x0000ff) >> (0 * 4))
        return fz_color(red: r, green: g, blue: b, alpha: alpha)
    }
    
    
    /// 十六进制字符串颜色
    ///
    /// - Parameters:
    ///   - rgbHexString: ["#000000", "#ffffff"]
    ///   - alpha: [0, 1] 默认 1
    /// - Returns:
    public class func fz_color(rgbHexString: String, alpha: CGFloat = 1.0) -> UIColor{
        let colorStr = rgbHexString.fz_trimAllWhiteSpace().fz_trimLeft(with: ["#"])
        if colorStr.count != 6{
            return UIColor.init()
        }
        var rgbValue: UInt32 = 0
        Scanner(string: colorStr).scanHexInt32(&rgbValue)
        return fz_color(rgbHex: rgbValue, alpha: alpha)
    }
    
    
    /// 生成随机色
    ///
    /// - Parameter alpha: [0, 1] 默认 1
    /// - Returns:
    public class func fz_randomColor(alpha: CGFloat = 1.0) -> UIColor{
        let r = CGFloat(arc4random() % 256)
        let g = CGFloat(arc4random() % 256)
        let b = CGFloat(arc4random() % 256)
        return fz_color(red: r, green: g, blue: b, alpha: alpha)
    }
}
