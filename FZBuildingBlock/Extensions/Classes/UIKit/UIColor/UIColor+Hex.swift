//
//  UIColor+RGBHex.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/5.
//

import Foundation

extension UIColor{
    
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
        let colorStr = rgbHexString.fz_trimAllWhiteSpace().fz_trimLeft(withFilter: ["#"])
        if colorStr.count != 6{
            return UIColor.init()
        }
        var rgbValue: UInt32 = 0
        Scanner(string: colorStr).scanHexInt32(&rgbValue)
        return fz_color(rgbHex: rgbValue, alpha: alpha)
    }
    
}

extension UIColor{
    
    
    /// 颜色拆分，获取颜色的rgba
    ///
    /// - Returns: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) default = (0, 0, 0, 1)
    public func fz_disassembleColor() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat){
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
        
        guard getRed(red, green: green, blue: blue, alpha: alpha) else{
            return (0, 0, 0, 1)
        }
        
        return (red.pointee, green.pointee, blue.pointee, alpha.pointee)
    }
    
    
    /// UIColor -> rgbHexString
    ///
    /// - Parameter prefix: rgbHexString前缀,default = "#"
    /// - Returns: (rgbHexString: String, alpha: CGFloat)
    public func fz_rgbHexString(withPrefix prefix: String = "#") -> (rgbHexString: String, alpha: CGFloat){
        let (red, green, blue, alpha) = fz_disassembleColor()
        let multiplier: CGFloat = 255.0
        
        return (String(
            format: "%@%02X%02X%02X",
            prefix,
            Int(red * multiplier),
            Int(green * multiplier),
            Int(blue * multiplier)
        ), alpha)
    }
    
    /// UIColor -> rgbHex十进制value
    ///
    /// - Returns: (rgbHex: UInt32 ,alpha: CGFloat)
    public func fz_rgbHex() -> (rgbHex: UInt32 ,alpha: CGFloat){
        let rgbHexStringTouple = fz_rgbHexString(withPrefix: "")
        let rgbHexString = rgbHexStringTouple.rgbHexString
        let alpha = rgbHexStringTouple.alpha
        
        var rgbHex: UInt32 = 0
        Scanner(string: rgbHexString).scanHexInt32(&rgbHex)
        
        return (rgbHex, alpha)
    }
    
}
