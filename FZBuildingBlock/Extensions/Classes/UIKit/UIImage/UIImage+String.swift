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
    ///   - attributes: default = nil,文字相关属性
    /// - Returns:
    public class func fz_image(withString string: String, attributes: [NSAttributedString.Key: Any]? = nil) -> UIImage? {
        return UIImage.fz_image(withAttributedString: NSAttributedString(string: string, attributes: attributes))
    }

    /// 绘制指定size的文字图片
    ///
    /// - Parameters:
    ///   - string: 绘制的文字
    ///   - attributes: default = nil,文字相关属性
    ///   - size: 生成图片尺寸
    /// - Returns: 
    public class func fz_image(withString string: String, attributes: [NSAttributedString.Key: Any]? = nil, size: CGSize) -> UIImage? {
        return UIImage.fz_image(withAttributedString: NSAttributedString(string: string, attributes: attributes), size: size)
    }

    /// 文字图片,size根据文字来计算
    ///
    /// - Parameter attributedString: 需要变成图片显示的文字
    /// - Returns:
    public class func fz_image(withAttributedString attributedString: NSAttributedString) -> UIImage? {
        return UIImage.fz_image(withAttributedString: attributedString, size: attributedString.size())
    }

    /// 绘制文字图片
    ///
    /// - Parameters:
    ///   - attributedString: 文字信息
    ///   - size: 绘制size
    /// - Returns:
    public class func fz_image(withAttributedString attributedString: NSAttributedString, size: CGSize) -> UIImage? {
        if size.equalTo(.zero) {
            return UIImage()
        }

        // 获取绘制高度宽度
        let width = size.width
        let height = size.height

        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, UIScreen.main.scale)

        attributedString.draw(in: CGRect(x: 0, y: 0, width: width, height: height))

        let stringImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return stringImage
    }

}
