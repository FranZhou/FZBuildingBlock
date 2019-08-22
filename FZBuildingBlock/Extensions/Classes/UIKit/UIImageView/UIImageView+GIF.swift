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
        imageView.animationImages = gif.giImages
        imageView.animationDuration = gif.gifDuration
        return imageView
    }
    
    
    public class func fz_loadGif(withData data: Data) -> UIImageView?{
        guard let gif = UIImage.fz_loadGIF(withData: data) else {
            return nil
        }
        
        let imageView = UIImageView()
        imageView.animationImages = gif.giImages
        imageView.animationDuration = gif.gifDuration
        return imageView
    }
}

extension UIImageView{
    public func fz_loadGIF(withFilePath filePath: String){
        guard let gif = UIImage.fz_loadGIF(withFilePath: filePath) else {
            return
        }
        
        self.animationImages = gif.giImages
        self.animationDuration = gif.gifDuration
    }
    
    public func fz_loadGif(withData data: Data){
        guard let gif = UIImage.fz_loadGIF(withData: data) else {
            return
        }
        
        self.animationImages = gif.giImages
        self.animationDuration = gif.gifDuration
    }
}
