//
//  UIImage+Resize.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/19.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UIImage {

    /// 按比例缩放图片
    ///
    /// - Parameter scala: 缩放比例
    /// - Returns:
    public func resize(withScala scala: CGFloat) -> UIImage? {
        let newSize = CGSize(width: base.size.width*scala, height: base.size.height*scala)

        return self.fz_resize(withSize: newSize)
    }

    /// 修改图片尺寸
    ///
    /// - Parameter size: 修改尺寸
    /// - Returns: 
    public func fz_resize(withSize size: CGSize) -> UIImage? {
        // 尺寸没有发生变化
        guard base.size.equalTo(size) else {
            return copy()
        }

        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        base.draw(in: CGRect(origin: .zero, size: size))

        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return scaledImage
    }

}
