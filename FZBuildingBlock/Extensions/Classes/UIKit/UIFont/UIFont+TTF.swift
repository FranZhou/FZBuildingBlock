//
//  UIFont+TTF.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/15.
//

import Foundation

extension UIFont.fz {

    /// 获取TTF字体（TTF OTF都可以使用）
    ///
    /// - Parameters:
    ///   - filePath: 字体文件路径
    ///   - size: 字体大小
    /// - Returns: 加载本地字体，无法加载时使用系统默认字体
    public static func ttfFont(withFilePath filePath: String, size: CGFloat) -> UIFont {
        guard let fontURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, filePath as CFString, CFURLPathStyle.cfurlposixPathStyle, false),
            let dataProvider = CGDataProvider.init(url: fontURL),
            let graphicsFont = CGFont.init(dataProvider)
            else {
                return UIFont.systemFont(ofSize: size)
        }

        let matrix: UnsafeMutablePointer = UnsafeMutablePointer<CGAffineTransform>.allocate(capacity: MemoryLayout<CGAffineTransform>.size)
        defer {
            matrix.deallocate()
        }

        let smallFont = CTFontCreateWithGraphicsFont(graphicsFont, size, matrix, nil)
        return smallFont as UIFont
    }

    /// 注册字体，并返回字体名
    ///
    /// - Parameter filePath: TTF OTF字体文件路径
    /// - Returns: 字体名称
    public static func registerTTFFont(withFilePath filePath: String) -> String? {
        guard let fontURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, filePath as CFString, CFURLPathStyle.cfurlposixPathStyle, false),
            let dataProvider = CGDataProvider.init(url: fontURL),
            let graphicsFont = CGFont.init(dataProvider)
            else {
                return nil
        }

        let fontError = UnsafeMutablePointer<Unmanaged<CFError>?>.allocate(capacity: MemoryLayout<Unmanaged<CFError>?>.size)
        defer {
            fontError.deallocate()
        }

        // 注册字体
        CTFontManagerRegisterGraphicsFont(graphicsFont, fontError)

        // 返回字体的 postScriptName
        return graphicsFont.postScriptName as String?
    }

}
