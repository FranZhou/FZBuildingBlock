//
//  UIImage+Resize.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/19.
//

import Foundation

extension UIImage {
    
    
    /// 按比例缩放图片
    ///
    /// - Parameter scala: 缩放比例
    /// - Returns:
    public func fz_resize(withScala scala: CGFloat) -> UIImage?{
        let newSize = CGSize(width: self.size.width*scala, height: self.size.height*scala)
        
        return self.fz_resize(withSize: newSize)
    }
    
    
    /// 修改图片尺寸
    ///
    /// - Parameter size: 修改尺寸
    /// - Returns: 
    public func fz_resize(withSize size: CGSize) -> UIImage? {
        // 尺寸没有发生变化
        guard self.size.equalTo(size) else {
            return self.fz_copy()
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
}
