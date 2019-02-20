//
//  UIImage+CornerRadius.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/16.
//

import Foundation

extension UIImage {
    
    
    /// 图片圆角截取
    ///
    /// - Parameters:
    ///   - leftTop: 左上角半径
    ///   - leftBottom: 左下角半径
    ///   - rightBottom: 右下角半径
    ///   - rightTop: 右上角半径
    public func fz_cornerRadius(leftTop: CGFloat, leftBottom: CGFloat, rightBottom: CGFloat, rightTop: CGFloat) -> UIImage {
        if leftTop == 0 && leftBottom == 0 && rightBottom == 0 && rightTop == 0{
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        
        return self
    }
    
    
    /// 图片圆角
    ///
    /// - Parameter radius: 圆角的半径
    public func fz_cornerRadius(with radius: CGFloat) -> UIImage{
        return self.fz_cornerRadius(leftTop: radius, leftBottom: radius, rightBottom: radius, rightTop: radius)
    }
    
}
