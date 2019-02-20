//
//  UIImage+Resize.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/19.
//

import Foundation

extension UIImage {
    
    public func fz_scala(with scala: CGFloat) -> UIImage?{
        let newSize = CGSize(width: self.size.width*scala, height: self.size.height*scala)
        
        return self.fz_resize(with: newSize)
    }
    
    public func fz_resize(with size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
}
