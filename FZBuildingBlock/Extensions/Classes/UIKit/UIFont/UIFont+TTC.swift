//
//  UIFont+TTC.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/15.
//

import Foundation

extension UIFont.fz {

    /// 加载TTC字体文件，获取对应的FontName集合，后续可以直接使用FontName来创建UIFont
    ///
    /// - Parameter filePath: TTC字体文件路径
    /// - Returns: 注册的FontName集合
    public static func registerTTCFont(withFilePath filePath: String) -> [String]? {

        let cPath = filePath.withCString { (path: UnsafePointer<Int8>) -> UnsafePointer<Int8> in
            return path
        }

        guard let fontPath = CFStringCreateWithCString(kCFAllocatorDefault, cPath, CFStringBuiltInEncodings.UTF8.rawValue),
            let fontURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, fontPath, CFURLPathStyle.cfurlposixPathStyle, false),
            let fontArray = CTFontManagerCreateFontDescriptorsFromURL(fontURL)
            else {
                return nil
        }

        let fontError = UnsafeMutablePointer<Unmanaged<CFError>?>.allocate(capacity: MemoryLayout<Unmanaged<CFError>?>.size)
        defer {
            fontError.deallocate()
        }

        CTFontManagerRegisterFontsForURL(fontURL, CTFontManagerScope.none, fontError)

        var fontNames: [String] = []

        for i in 0..<CFArrayGetCount(fontArray) {
            if let val = CFArrayGetValueAtIndex(fontArray, i) {
                let descriptor = unsafeBitCast(val, to: CTFontDescriptor.self)
                let fontRef = CTFontCreateWithFontDescriptor(descriptor, UIFont.systemFontSize, nil)
                if let fontName = CTFontCopyName(fontRef, kCTFontPostScriptNameKey) as String? {
                    fontNames.append(fontName)
                }
            }
        }

        return fontNames
    }
}
