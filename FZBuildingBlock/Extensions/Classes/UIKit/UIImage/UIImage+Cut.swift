//
//  UIImage+Cut.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/16.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UIImage {

    /// 图片截取
    ///
    /// - Parameter rect: 截取位置
    /// - Returns:
    public func cut(withRect rect: CGRect) -> UIImage? {
        if rect.size.equalTo(.zero) {
            return UIImage()
        }
        let scale = UIScreen.main.scale
        let newRect = CGRect(x: rect.origin.x*scale, y: rect.origin.y*scale, width: rect.size.width*scale, height: rect.size.height*scale)

        guard let cgImage = base.cgImage, let cutCGImage = cgImage.cropping(to: newRect) else {
            return nil
        }
        let cutImage = UIImage(cgImage: cutCGImage, scale: scale, orientation: .up)
        return cutImage
    }

}
