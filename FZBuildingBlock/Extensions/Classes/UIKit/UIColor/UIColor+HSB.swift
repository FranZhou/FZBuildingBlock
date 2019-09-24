//
//  UIColor+HSB.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/19.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UIColor {

    /// 返回当前颜色对应的 HSB 值
    /// - H（hue）代表色相：色相指色彩的种类和名称。如红、橙、黄.... 取值范围 0°~360°，每个角度可以代表一种颜色。
    /// - S（saturation）表示饱和度：它用 0% 至 100% 的值描述了相同色相、明度下色彩纯度的变化。数值越大，颜色中的灰色越少，颜色越鲜艳，呈现一种从灰度到纯色的变化。
    /// - B（brightness）表示亮度：其作用是控制色彩的明暗变化。它同样使用了 0% 至 100% 的取值范围。数值越小，色彩越暗，越接近于黑色；数值越大，色彩越亮，越接近于白色。
    ///
    /// - Returns: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) default (0, 0, 0, 1)
    public func hsba() -> (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {

        let hue = UnsafeMutablePointer<CGFloat>.allocate(capacity: MemoryLayout<CGFloat>.size)
        defer {
            hue.deallocate()
        }

        let saturation = UnsafeMutablePointer<CGFloat>.allocate(capacity: MemoryLayout<CGFloat>.size)
        defer {
            saturation.deallocate()
        }

        let brightness = UnsafeMutablePointer<CGFloat>.allocate(capacity: MemoryLayout<CGFloat>.size)
        defer {
            brightness.deallocate()
        }

        let alpha = UnsafeMutablePointer<CGFloat>.allocate(capacity: MemoryLayout<CGFloat>.size)
        defer {
            alpha.deallocate()
        }

        guard base.getHue(hue, saturation: saturation, brightness: brightness, alpha: alpha) else {
            return (0, 0, 0, 1)
        }

        return (hue: hue.pointee * 360, saturation: saturation.pointee, brightness: brightness.pointee, alpha: alpha.pointee)
    }

}
