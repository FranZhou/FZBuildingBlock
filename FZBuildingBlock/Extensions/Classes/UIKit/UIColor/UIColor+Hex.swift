//
//  UIColor+RGBHex.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/5.
//

import Foundation

extension UIColor.fz {

    /// 十六进制颜色
    ///
    /// - Parameters:
    ///   - rgbHex: [0x000000, 0xffffff]
    ///   - alpha: [0, 1] 默认 1
    /// - Returns:
    public static func color(rgbHex: UInt32, alpha: CGFloat = 1.0) -> UIColor {
        let r = CGFloat((rgbHex & 0xff0000) >> (4 * 4))
        let g = CGFloat((rgbHex & 0x00ff00) >> (2 * 4))
        let b = CGFloat((rgbHex & 0x0000ff) >> (0 * 4))
        return UIColor.fz.color(red: r, green: g, blue: b, alpha: alpha)
    }

    /// 十六进制字符串颜色
    ///
    /// - Parameters:
    ///   - rgbHexString: ["#000000", "#ffffff"]
    ///   - alpha: [0, 1] 默认 1
    /// - Returns:
    public static func color(rgbHexString: String, alpha: CGFloat = 1.0) -> UIColor {
        let colorStr = rgbHexString.fz.trimAllWhiteSpace().fz.trimLeft(withFilter: ["#"])
        if colorStr.count != 6 {
            return UIColor.init()
        }
        var rgbValue: UInt32 = 0
        Scanner(string: colorStr).scanHexInt32(&rgbValue)
        return UIColor.fz.color(rgbHex: rgbValue, alpha: alpha)
    }

}

extension FZBuildingBlockWrapper where Base: UIColor {

    /// 颜色拆分，获取颜色的rgba, 这里rgba的范围在[0,1]之间
    ///
    /// - Returns: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) default = (0, 0, 0, 1)
    public func disassembleColor() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let red = UnsafeMutablePointer<CGFloat>.allocate(capacity: MemoryLayout<CGFloat>.size)
        defer {
            red.deallocate()
        }

        let green = UnsafeMutablePointer<CGFloat>.allocate(capacity: MemoryLayout<CGFloat>.size)
        defer {
            green.deallocate()
        }

        let blue = UnsafeMutablePointer<CGFloat>.allocate(capacity: MemoryLayout<CGFloat>.size)
        defer {
            blue.deallocate()
        }

        let alpha = UnsafeMutablePointer<CGFloat>.allocate(capacity: MemoryLayout<CGFloat>.size)
        defer {
            alpha.deallocate()
        }

        guard base.getRed(red, green: green, blue: blue, alpha: alpha) else {
            return (0, 0, 0, 1)
        }

        return (red.pointee, green.pointee, blue.pointee, alpha.pointee)
    }

    /// 颜色拆分，获取颜色的rgba, 这里rgb的范围在[0,255]之间，A[0,1]
    ///
    /// - Returns: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    public func disassembleColorRGB255() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let (red, green, blue, alpha) = disassembleColor()
        let multiplier: CGFloat = 255.0

        return (ceil(red * multiplier), ceil(green * multiplier), ceil(blue * multiplier), alpha)
    }

    /// UIColor -> rgbHexString
    ///
    /// - Parameter prefix: rgbHexString前缀,default = "#"
    /// - Returns: (rgbHexString: String, alpha: CGFloat)
    public func rgbHexString(withPrefix prefix: String = "#") -> (rgbHexString: String, alpha: CGFloat) {
        let (red, green, blue, alpha) = disassembleColorRGB255()

        return (String(
            format: "%@%02X%02X%02X",
            prefix,
            Int(red),
            Int(green),
            Int(blue)
        ), alpha)
    }

    /// UIColor -> rgbHex十进制value
    ///
    /// - Returns: (rgbHex: UInt32 ,alpha: CGFloat)
    public func rgbHex() -> (rgbHex: UInt32, alpha: CGFloat) {
        let rgbHexStringTouple = rgbHexString(withPrefix: "")
        let rgbHexString = rgbHexStringTouple.rgbHexString
        let alpha = rgbHexStringTouple.alpha

        var rgbHex: UInt32 = 0
        Scanner(string: rgbHexString).scanHexInt32(&rgbHex)

        return (rgbHex, alpha)
    }

}
