//
//  UIImage+FileName.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/27.
//

import Foundation

extension UIImage {

    /// 加载指定名称的图片，如果为Retina屏幕且存在对应图片，则返回Retina图片，否则查找普通图片
    ///
    /// - Parameters:
    ///   - fileName: 图片名称
    ///   - `extension`: 图片名后缀，默认为 png
    ///   - bundle: 图片所属bundle
    /// - Returns: 查找到的图片
    public class func fz_loadImage(withFileName fileName: String, `extension`: String = "png", bundle: Bundle = Bundle.main) -> UIImage? {

        let scale = UIScreen.main.scale

        var imageName = fileName

        // 如果为Retina屏幕且存在对应图片，则返回Retina图片，否则查找普通图片

        if scale == 3 {
            imageName = fileName + "@3x"

            // 有3x的图片
            if let filePath = bundle.path(forResource: imageName, ofType: `extension`) {
                return UIImage(contentsOfFile: filePath)
            }
        }

        if scale == 2 {
            imageName = fileName + "@2x"

            // 有2x图片
            if let filePath = bundle.path(forResource: imageName, ofType: `extension`) {
                return UIImage(contentsOfFile: filePath)
            }
        }

        // 普通图片(不是 xx@2x.png 或者 xx@3x.png 这种类型的图片)
        imageName = fileName
        if let filePath = bundle.path(forResource: imageName, ofType: `extension`) {
            return UIImage(contentsOfFile: filePath)
        }

        return nil
    }

}
