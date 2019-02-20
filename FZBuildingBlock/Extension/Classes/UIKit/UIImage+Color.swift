//
//  UIImage+Color.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/3.
//

import Foundation
import UIKit

extension UIImage{
    
    
    /// 获取纯色的image
    ///
    /// - Parameters:
    ///   - color: 图片颜色
    ///   - size: 图片size
    /// - Returns:
    public class func fz_image(with color: UIColor, size: CGSize) -> UIImage?{
        if size.equalTo(.zero){
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return colorImage
    }
    
}
