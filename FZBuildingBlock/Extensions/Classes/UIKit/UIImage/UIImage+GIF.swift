//
//  UIImage+GIF.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/19.
//

import Foundation
import MobileCoreServices

extension UIImage.fz {

    /// GIF每一帧的数据类型(帧图片，帧动画时间)
    public typealias FZGIFFrameInfo = (image: UIImage, duration: Double)

    /// 加载GIF图片
    ///
    /// - Parameter filePath: gif图片本地路径
    /// - Returns: gif帧图片和animation时间
    public static func loadGIF(withFilePath filePath: String) -> [FZGIFFrameInfo]? {
        let url = URL(fileURLWithPath: filePath)
        var gifData: Data?

        do {
            gifData = try Data(contentsOf: url)
        } catch _ {

        }

        if let _ = gifData {
            return loadGIF(withData: gifData!)
        } else {
            return nil
        }
    }

    /// 加载GIF图片
    ///
    /// - Parameter data: gif data
    /// - Returns: gif帧图片和animation时间
    public static func loadGIF(withData data: Data) -> [FZGIFFrameInfo]? {

        // 是否是GIF图片的data
        guard data.fz.isGIF else {
            return nil
        }

        // kCGImageSourceShouldCache : 表示是否在存储的时候就解码
        // kCGImageSourceTypeIdentifierHint : 指明source type
        //这里的info是为了显示优化。提前解码，指定类型。
        let options: [CFString: Any] = [kCGImageSourceShouldCache: true, kCGImageSourceTypeIdentifierHint: kUTTypeGIF]

        guard let imageSource = CGImageSourceCreateWithData(data as CFData, options as CFDictionary) else {
            return nil
        }

        //获取gif的帧数
        let frameCount = CGImageSourceGetCount(imageSource)
        var frameImageAndDuration = [(image: UIImage, duration: Double)]()

        for i in 0..<frameCount {
            //取出索引对应的图片
            guard let imageRef = CGImageSourceCreateImageAtIndex(imageSource, i, options as CFDictionary) else {
                print("取出对应的图片失败")
                return nil
            }

            if frameCount == 1 {
                // 单帧
                //infinity 解释: https://swifter.tips/math-number/
                let gifFrameDuration: Double = .infinity
                // 图片
                let frameImage = UIImage(cgImage: imageRef, scale: 1.0, orientation: .up)

                frameImageAndDuration.append((image: frameImage, duration: gifFrameDuration))
            } else {
                //1.获取gif没帧的时间间隔

                //获取到该帧图片的属性字典
                guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) as? [String: Any] else {
                    print("获取帧图片属性字典失败")
                    return nil
                }

                //获取该帧图片中的GIF相关的属性字典
                guard let gifInfo = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any] else {
                    print("获取GIF相关属性失败")
                    return nil
                }

                let defaultFrameDuration = 0.1
                //获取该帧图片的播放时间
                let unclampedDelayTime = gifInfo[kCGImagePropertyGIFUnclampedDelayTime as String] as? NSNumber
                //如果通过kCGImagePropertyGIFUnclampedDelayTime没有获取到播放时长，就通过kCGImagePropertyGIFDelayTime来获取，两者的含义是相同的；
                let delayTime = gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber
                let duration = unclampedDelayTime ?? delayTime
                guard let frameDuration = duration else {
                    print("获取帧时间间隔失败")
                    return nil
                }
                // 对于播放时间低于0.011s的,重新指定时长为0.100s；
                let gifFrameDuration = frameDuration.doubleValue > 0.011 ? frameDuration.doubleValue : defaultFrameDuration

                // 图片
                let frameImage = UIImage(cgImage: imageRef, scale: 1.0, orientation: .up)

                // 记录每一帧的图片和动画时间
                frameImageAndDuration.append((image: frameImage, duration: gifFrameDuration))
            }
        }

        return frameImageAndDuration
    }

}
