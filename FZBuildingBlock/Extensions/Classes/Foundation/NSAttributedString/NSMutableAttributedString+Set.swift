//
//  NSMutableAttributedString+Set.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/28.
//

import Foundation

// MARK: - set
extension FZBuildingBlockWrapper where Base: NSMutableAttributedString {

    /// 设置指定位置的属性
    ///
    /// - Parameters:
    ///   - attribute: attribute
    ///   - range: range
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func set(attribute: FZAttribute, range: NSRange? = nil) -> Base {
        base.addAttributes(attribute.value, range: range ?? self.range)
        return base
    }

    /// 设置指定位置的属性
    ///
    /// - Parameters:
    ///   - attributes: attributes
    ///   - range: range
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func set(attributes: [FZAttribute], range: NSRange? = nil) -> Base {
        base.addAttributes(attributes.reduce([:], { $1.fill(in: $0) }), range: range ?? self.range)
        return base
    }

}
