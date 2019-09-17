//
//  NSMutableAttributedString+Add.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/28.
//

import Foundation

// MARK: - add
extension FZBuildingBlockWrapper where Base: NSMutableAttributedString {

    /// 添加指定范围的字符串属性
    ///
    /// - Parameters:
    ///   - attribute: 枚举属性
    ///   - range: 范围
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func add(attribute: FZAttribute, range: NSRange? = nil) -> Base {
        base.addAttributes(attribute.value, range: range ?? self.range)
        return base
    }

    /// 添加指定范围的多个属性
    ///
    /// - Parameters:
    ///   - attributes: 枚举属性数组
    ///   - range: 范围
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func add(attributes: [FZAttribute], range: NSRange? = nil) -> Base {
        base.addAttributes(attributes.reduce([:], { $1.fill(in: $0) }), range: range ?? self.range)
        return base
    }
}
