//
//  UIImage+Rotation.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/16.
//

import Foundation


extension UIImage {
    
    
    /// 旋转图片(size会发生变化)
    ///
    /// - Parameter rotation: 旋转角度(单位: 度)
    /// - Returns:
    public func fz_rotate(with rotation: Double) -> UIImage? {
        if rotation.truncatingRemainder(dividingBy: 360) == 0 {
            return self
        }
        
        let imageRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        let radian = CGFloat(rotation/180*Double.pi)
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
        
        self.draw(at: .zero)
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return rotatedImage
    }
    
}
