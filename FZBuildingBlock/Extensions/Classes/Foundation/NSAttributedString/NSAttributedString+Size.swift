//
//  NSAttributedString+Size.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/6.
//

import Foundation

extension FZBuildingBlockWrapper where Base: NSAttributedString {

    /// 属性字符串显示size计算
    ///
    /// - Parameters:
    ///   - size: limit size
    ///   - font: font
    ///   - lines: lines, 为0时表示无限制
    ///   - lineSpacing: 行间距
    /// - Returns: size
    public func size(withLimit size: CGSize, font: UIFont, lines: Int = 0, lineSpacing: CGFloat? = nil) -> CGSize {
        let rect = base.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)

        if lines < 0 {
            return .zero
        } else if lines == 0 {
            return rect.size
        } else {
            // 字体高度，可以认为是单行高度
            let fontHeight = font.lineHeight
            // 行间距
            let currentLineSpacing = lineSpacing ?? font.lineHeight - font.pointSize
            // 计算限制显示的行高
            let lineHeight = fontHeight * CGFloat(lines) + currentLineSpacing * CGFloat(lines - 1)

            if lineHeight > rect.size.height {
                return rect.size
            } else {
                return CGSize(width: rect.size.width, height: lineHeight)
            }
        }
    }

}
