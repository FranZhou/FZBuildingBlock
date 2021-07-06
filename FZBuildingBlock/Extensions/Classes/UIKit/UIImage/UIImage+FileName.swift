//
//  UIImage+FileName.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/27.
//

import Foundation

extension UIImage.fz {

    /// 加载指定名称的图片，如果为Retina屏幕且存在对应图片，则返回Retina图片，否则查找其他缩放比例图片
    ///
    /// - Parameters:
    ///   - fileName: 图片名称
    ///   - type: 图片名后缀，默认为 png
    ///   - bundle: 图片所属bundle，默认为Bundle.main
    ///   - limitScale: 最大缩放比，默认为 3
    ///   - lookup: 优先向上查找，默认为true
    /// - Returns: 查找到的图片
    public static func loadImage(with fileName: String, type: String = "png", bundle: Bundle = Bundle.main, limitScale: CGFloat = 3, lookup: Bool = true) -> UIImage? {

        // 根据lookup方向查找图片
        if let image = loadImage(with: fileName, type: type, bundle: bundle, currentScale: UIScreen.main.scale, limitScale: limitScale, lookup: lookup) {
            return image

            // lookup方向查找不到，反向再进行查找
        } else if let image = loadImage(with: fileName, type: type, bundle: bundle, currentScale: UIScreen.main.scale, limitScale: limitScale, lookup: !lookup) {
            return image
        }

        // 无法查找到图片，返回nil
        return nil
    }

    /// 查找指定缩放比图片。
    /// 如果currentScale = 2 limitScale = 3，
    /// 当lookup = true时，x@2x.png 找不到会去寻找 x@3x.png；当lookup = false时，x@2x.png 找不到会去寻找 x.png。
    /// 最终如果查找不到资源，则返回nil
    ///
    /// - Parameters:
    ///   - fileName: 图片名称
    ///   - type: 图片名后缀
    ///   - bundle: 图片所属bundle
    ///   - currentScale: 当前缩放比
    ///   - limitScale: 最大缩放比
    ///   - lookup: 是否向上查找
    /// - Returns: bundle中的资源图片
    public static func loadImage(with fileName: String, type: String, bundle: Bundle, currentScale: CGFloat, limitScale: CGFloat, lookup: Bool) -> UIImage? {
        // 越界，返回nil
        guard currentScale >= 1 && currentScale <= limitScale else {
            return nil
        }

        // 拼接图片名称
        var imageName = fileName
        if currentScale > 1 {
            imageName = fileName + "@\(Int(currentScale))x"
        }

        // 查找图片路径
        if let filePath = bundle.path(forResource: imageName, ofType: type) {
            // 找到图片，返回
            return UIImage(contentsOfFile: filePath)
        } else {
            // 没有找到，继续查找
            let nextCurrentScale = lookup ? currentScale + 1 : currentScale - 1
            return loadImage(with: fileName, type: type, bundle: bundle, currentScale: nextCurrentScale, limitScale: limitScale, lookup: lookup)
        }
    }
}
