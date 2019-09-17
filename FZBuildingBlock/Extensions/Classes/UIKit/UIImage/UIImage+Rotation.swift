//
//  UIImage+Rotation.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/16.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UIImage {

    /// 旋转图片(size会发生变化)
    ///
    /// - Parameter rotation: 旋转角度(单位: 度)
    /// - Returns:
    public func rotate(withRotation rotation: CGFloat) -> UIImage? {
        if rotation.truncatingRemainder(dividingBy: 360) == 0 {
            return copy()
        }

        let imageRect = CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height)
        let radian = rotation/180*CGFloat.pi
        let rotatedTransform = CGAffineTransform(rotationAngle: radian)

        // 旋转后的rect
        var rotatedRect = imageRect.applying(rotatedTransform)
        rotatedRect.origin.x = 0
        rotatedRect.origin.y = 0

        UIGraphicsBeginImageContextWithOptions(rotatedRect.size, false, UIScreen.main.scale)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.saveGState()
        defer {
            context.restoreGState()
        }

        context.translateBy(x: rotatedRect.width/2, y: rotatedRect.height/2)
        context.rotate(by: radian)
        // 这里用imageRect
        context.translateBy(x: -imageRect.width/2, y: -imageRect.height/2)

        base.draw(at: .zero)
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return rotatedImage
    }

}
