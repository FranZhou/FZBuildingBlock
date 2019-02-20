//
//  UIImage+String.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/18.
//

import Foundation


// MARK: - 文字转图片
extension UIImage {
    
    
    /// 文字图片,size根据文字来计算
    ///
    /// - Parameters:
    ///   - string: 需要变成图片显示的文字
    ///   - attributes: 文字相关属性
    /// - Returns:
    public class func fz_image(with string: String, attributes:  [NSAttributedString.Key : Any]? = nil) -> UIImage? {
        return UIImage.fz_image(with: NSAttributedString(string: string, attributes: attributes))
    }
    
    
    /// 文字图片,size根据文字来计算
    ///
    /// - Parameter attributedString: 需要变成图片显示的文字
    /// - Returns:
    public class func fz_image(with attributedString: NSAttributedString) -> UIImage? {
        if attributedString.size().equalTo(.zero){
            return nil
        }
        
        // 获取文字高度宽度
        let width = attributedString.size().width
        let height = attributedString.size().height
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, UIScreen.main.scale)
        
        attributedString.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        let stringImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return stringImage
    }
    
    
}
