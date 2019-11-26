//
//  FZLargeImageView.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/19.
//

import UIKit
import CoreGraphics

open class FZLargeImageView: UIView {

    // MARK: - override
    override open class var layerClass: AnyClass {
        return CATiledLayer.classForCoder()
    }

    // MARK: - private
    private var originImage: UIImage? {
        didSet {

            // 设置 imageWidthScale
            if let imageRect = self.imageRect,
                imageRect.size.width > 0,
                self.fz.width > 0 {
                self.imageWidthScale = self.fz.width / imageRect.size.width
            } else {
                self.imageWidthScale = nil
            }

            // 设置 imageHeightScale
            if let imageRect = self.imageRect,
                imageRect.size.height > 0,
                self.fz.height > 0 {
                self.imageHeightScale = self.fz.height / imageRect.size.height
            } else {
                self.imageHeightScale = nil
            }

        }
    }

    private var imageRect: CGRect? {
        if let cgImage = self.originImage?.cgImage {
            return CGRect(x: 0, y: 0, width: cgImage.width, height: cgImage.height)
        }
        return nil
    }

    private var imageWidthScale: CGFloat?

    private var imageHeightScale: CGFloat?

}

extension FZLargeImageView {

    /// 超大图显示
    ///
    /// - Parameters:
    ///   - image: image
    ///   - tileSize: layer划分视图区域最大尺寸，默认(256, 256)
    @objc public func setImage(_ image: UIImage, tileSize: CGSize = CGSize(width: 256, height: 256)) {

        self.originImage = image

        guard let imageWidthScale = self.imageWidthScale,
            let imageHeightScale = self.imageHeightScale,
            let tiledLayer = self.layer as? CATiledLayer
            else {
                return
        }

        let scale = max(1.0/imageWidthScale, 1.0/imageHeightScale)
        let lev = Int(ceil(scale))

        tiledLayer.levelsOfDetail = 1
        tiledLayer.levelsOfDetailBias = lev

        tiledLayer.tileSize = tileSize
    }
}

extension FZLargeImageView {

    override open func draw(_ rect: CGRect) {
        guard let cgImage = self.originImage?.cgImage,
            let imageWidthScale = self.imageWidthScale,
            let imageHeightScale = self.imageHeightScale
            else {
                return
        }

        let imageCutRect = CGRect(x: rect.origin.x / imageWidthScale, y: rect.origin.y / imageHeightScale, width: rect.size.width / imageWidthScale, height: rect.size.height / imageHeightScale)

        guard let imageRef = cgImage.cropping(to: imageCutRect) else {
            return
        }

        let tileImage = UIImage(cgImage: imageRef)

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        UIGraphicsPushContext(context)
        tileImage.draw(in: rect)
        UIGraphicsPopContext()
    }

}
