//
//  UIImage+Color.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/3.
//

import Foundation
import UIKit
import CoreGraphics

extension UIImage.fz {

    /// 获取纯色的image
    ///
    /// - Parameters:
    ///   - color: 图片颜色
    ///   - size: 图片size
    /// - Returns:
    public static func image(withColor color: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return colorImage
    }

}

extension FZBuildingBlockWrapper where Base: UIImage {

    /// 获取图片上某一点的颜色
    ///
    /// - Parameter point: 某一点
    /// - Returns: color at point
    public func colorRGBA(atPoint point: CGPoint) -> UIColor? {
        guard let cgImage = base.cgImage else {
            return nil
        }

        let width = cgImage.width
        let height = cgImage.height

        if !CGRect(x: 0, y: 0, width: width, height: height).contains(point) {
            return nil
        }

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        // 一个像素 4 个字节
        let bytesPerPixel = 4
        // 一行共 bytesPerPixel * width 个字节
        let bytesPerRow = bytesPerPixel * width
        // 每个像素元素位数为 8 bit，即 rgba 每位各 1 个字节
        let bitsPerComponent = 8

        let bitmapInfo = cgImage.bitmapInfo.rawValue

        let rawData = malloc(width * height * bytesPerPixel)
        defer {
            rawData?.deallocate()
        }

        guard let context = CGContext(data: rawData,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: bitsPerComponent,
                                      bytesPerRow: bytesPerRow,
                                      space: colorSpace,
                                      bitmapInfo: bitmapInfo)
            else {
                                        return nil
        }

        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        guard let pixelData = rawData else { return nil }

        let byteIndex = bytesPerRow * Int(point.y) + bytesPerPixel * Int(point.x)

        // 图片数据显示显示顺序argb  数据存储顺序 bgra  高低位切换
        let blue = CGFloat(pixelData.load(fromByteOffset: byteIndex, as: UInt8.self))
        let green = CGFloat(pixelData.load(fromByteOffset: byteIndex + 1, as: UInt8.self))
        let red = CGFloat(pixelData.load(fromByteOffset: byteIndex + 2, as: UInt8.self))
        let alpha = CGFloat(pixelData.load(fromByteOffset: byteIndex + 3, as: UInt8.self)) / 255.0

        return UIColor.fz.color(red: red, green: green, blue: blue, alpha: alpha)
    }
}
