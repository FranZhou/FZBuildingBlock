//
//  UIImage+Cut.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/16.
//

import Foundation


extension UIImage {
    
    
    /// 图片截取
    ///
    /// - Parameter rect: 截取位置
    /// - Returns:
    public func fz_cut(withRect rect: CGRect) -> UIImage?{
        if rect.size.equalTo(.zero){
            return UIImage()
        }
        let scala = UIScreen.main.scale
        let newRect = CGRect(x: rect.origin.x*scale, y: rect.origin.y*scale, width: rect.size.width*scale, height: rect.size.height*scale)
        
        guard let cgImage = self.cgImage, let cutCGImage = cgImage.cropping(to: newRect) else {
            return nil
        }
        let cutImage = UIImage(cgImage: cutCGImage, scale: scala, orientation: .up)
        return cutImage
    }
    
}
