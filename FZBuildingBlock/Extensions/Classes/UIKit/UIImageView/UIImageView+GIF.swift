//
//  UIImageView+GIF.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/19.
//

import Foundation

extension UIImageView {
    
    public class func fz_loadGIF(withFilePath filePath: String) -> UIImageView?{
        guard let gif = UIImage.fz_loadGIF(withFilePath: filePath) else {
            return nil
        }
        
        let imageView = UIImageView()
        imageView.fz_loadGIFFrames(gifFrames: gif)
        return imageView
    }
    
    
    public class func fz_loadGif(withData data: Data) -> UIImageView?{
        guard let gif = UIImage.fz_loadGIF(withData: data) else {
            return nil
        }
        
        let imageView = UIImageView()
        imageView.fz_loadGIFFrames(gifFrames: gif)
        return imageView
    }
}

extension UIImageView{
    
    fileprivate func fz_loadGIFFrames(gifFrames: [UIImage.FZGIFFrameInfo]?){
        var gifImages: [UIImage]? = nil
        var gifDuration: Double = 0
        
        if let gif = gifFrames {
            gifImages = gif.map { (gifFrameInfo: UIImage.FZGIFFrameInfo) -> UIImage in
                return gifFrameInfo.image
            }
            
            gifDuration = gif.reduce(0.0) { (result: Double, gifFrameInfo: UIImage.FZGIFFrameInfo) -> Double in
                return result + gifFrameInfo.duration
            }
        }
        
        self.animationImages = gifImages
        self.animationDuration = gifDuration
    }
    
    public func fz_loadGIF(withFilePath filePath: String){
        guard let gif = UIImage.fz_loadGIF(withFilePath: filePath) else {
            return
        }
        fz_loadGIFFrames(gifFrames: gif)
    }
    
    public func fz_loadGif(withData data: Data){
        guard let gif = UIImage.fz_loadGIF(withData: data) else {
            return
        }
        fz_loadGIFFrames(gifFrames: gif)
    }
}
