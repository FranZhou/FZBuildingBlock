//
//  String+Size.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/6.
//

import Foundation

extension FZBuildingBlockWrapper where Base == String {

    /// 计算字符串size
    ///
    /// - Parameters:
    ///   - size: limit size
    ///   - font: font
    ///   - lines: lines, 为0时表示无限制
    ///   - lineSpacing: 行间距
    /// - Returns: size
    public func size(withLimit size: CGSize, font: UIFont, lines: Int = 0, lineSpacing: CGFloat? = nil) -> CGSize {
        guard lines >= 0 else {
            return .zero
        }

        let attributedString = NSMutableAttributedString.fz.mutableAttributedString(with: base, attributes: [.font(font)])

        if let lineSpacing = lineSpacing {
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineSpacing = lineSpacing
            attributedString.fz.add(attribute: .paragraphStyle(paragraph))
        }

        return attributedString.fz.size(withLimit: size, font: font, lines: lines, lineSpacing: lineSpacing)
    }

}
