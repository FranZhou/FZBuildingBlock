//
//  NSMutableAttributedString+ConvenienceInit.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/6.
//

import Foundation

extension NSMutableAttributedString.fz {

    /// 便利创建方式
    ///
    /// - Parameters:
    ///   - string: 字符串
    ///   - attribute: 枚举属性
    public static func mutableAttributedString(with string: String, attribute: FZAttribute) -> NSMutableAttributedString {
        return self.mutableAttributedString(with: string, attributes: [attribute])
    }

    ///便利创建方式
    ///
    /// - Parameters:
    ///   - string: 字符串
    ///   - attributes: 枚举属性数组
    public static func mutableAttributedString(with string: String, attributes: [FZAttribute]) -> NSMutableAttributedString {
        return NSMutableAttributedString.init(string: string, attributes: attributes.reduce([:], { $1.fill(in: $0 ) }))
    }

}
