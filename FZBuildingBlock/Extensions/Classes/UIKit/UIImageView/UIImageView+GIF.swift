//
//  UIImageView+GIF.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/19.
//

import Foundation

extension UIImageView.fz {

    public static func loadGIF(withFilePath filePath: String) -> UIImageView? {
        guard let gif = UIImage.fz.loadGIF(withFilePath: filePath) else {
            return nil
        }

        let imageView = UIImageView()
        imageView.fz.loadGIFFrames(gifFrames: gif)
        return imageView
    }

    public static func loadGif(withData data: Data) -> UIImageView? {
        guard let gif = UIImage.fz.loadGIF(withData: data) else {
            return nil
        }

        let imageView = UIImageView()
        imageView.fz.loadGIFFrames(gifFrames: gif)
        return imageView
    }
}

extension FZBuildingBlockWrapper where Base: UIImageView {

    fileprivate func loadGIFFrames(gifFrames: [UIImage.fz.FZGIFFrameInfo]?) {
        var gifImages: [UIImage]?
        var gifDuration: Double = 0

        if let gif = gifFrames {
            gifImages = gif.map { (gifFrameInfo: UIImage.fz.FZGIFFrameInfo) -> UIImage in
                return gifFrameInfo.image
            }

            gifDuration = gif.reduce(0.0) { (result: Double, gifFrameInfo: UIImage.fz.FZGIFFrameInfo) -> Double in
                return result + gifFrameInfo.duration
            }
        }

        base.animationImages = gifImages
        base.animationDuration = gifDuration
    }

    public func loadGIF(withFilePath filePath: String) {
        guard let gif = UIImage.fz.loadGIF(withFilePath: filePath) else {
            return
        }
        loadGIFFrames(gifFrames: gif)
    }

    public func fz_loadGif(withData data: Data) {
        guard let gif = UIImage.fz.loadGIF(withData: data) else {
            return
        }
        loadGIFFrames(gifFrames: gif)
    }
}
