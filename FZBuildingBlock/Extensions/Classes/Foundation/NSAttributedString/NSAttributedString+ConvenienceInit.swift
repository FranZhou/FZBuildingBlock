//
//  NSAttributedString+ConvenienceInit.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/28.
//

import Foundation

extension NSAttributedString.fz {

    /// 便利创建方式
    ///
    /// - Parameters:
    ///   - string: 字符串
    ///   - attribute: 枚举属性
    public static func attributedString(with string: String, attribute: FZAttribute) -> NSAttributedString {
        return self.attributedString(with: string, attributes: [attribute])
    }

    ///便利创建方式
    ///
    /// - Parameters:
    ///   - string: 字符串
    ///   - attributes: 枚举属性数组
    public static func attributedString(with string: String, attributes: [FZAttribute]) -> NSAttributedString {
        return NSAttributedString.init(string: string, attributes: attributes.reduce([:], { $1.fill(in: $0 ) }))
    }

}
