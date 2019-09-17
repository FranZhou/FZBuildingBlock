//
//  UIView+Color.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/27.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UIView {

    /// 获取View上某一点的颜色
    ///
    /// - Parameter point: 某一点
    /// - Returns: color at point
    public func colorRGBA(atPoint point: CGPoint) -> UIColor? {

        guard base.bounds.contains(point) else {
            return nil
        }

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let width = 1
        let height = 1

        // 一个像素 4 个字节
        let bytesPerPixel = 4
        // 一行共 bytesPerPixel * width 个字节
        let bytesPerRow = bytesPerPixel * width
        // 每个像素元素位数为 8 bit，即 rgba 每位各 1 个字节
        let bitsPerComponent = 8

        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue

        let rawData = malloc(4)
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

        context.translateBy(x: -point.x, y: -point.y)

        base.layer.render(in: context)

        guard let pixelData = rawData else { return nil }

        // Warning: 和图片不同 这里 rgba是按顺序来的
        let red = CGFloat(pixelData.load(fromByteOffset: 0, as: UInt8.self))
        let green = CGFloat(pixelData.load(fromByteOffset: 1, as: UInt8.self))
        let blue = CGFloat(pixelData.load(fromByteOffset: 2, as: UInt8.self))
        let alpha = CGFloat(pixelData.load(fromByteOffset: 3, as: UInt8.self)) / 255.0

        return UIColor.fz.color(red: red, green: green, blue: blue, alpha: alpha)
    }

}
