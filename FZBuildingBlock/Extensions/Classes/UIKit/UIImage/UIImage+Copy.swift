//
//  UIImage+Copy.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/14.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UIImage {

    /// 图片拷贝(深拷贝)
    ///
    /// - Returns: 
    public func copy() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(base.size, false, UIScreen.main.scale)
        base.draw(in: CGRect(origin: .zero, size: base.size))
        let copyImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return copyImage
    }

}
