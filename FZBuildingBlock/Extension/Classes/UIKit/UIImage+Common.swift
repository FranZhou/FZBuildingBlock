//
//  UIImage+Common.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/14.
//

import Foundation

extension UIImage{
    
    
    /// 图片拷贝(深拷贝)
    ///
    /// - Returns: 
    public func fz_copy() -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        self.draw(in: CGRect(origin: .zero, size: self.size))
        let copyImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return copyImage
    }
    
}
