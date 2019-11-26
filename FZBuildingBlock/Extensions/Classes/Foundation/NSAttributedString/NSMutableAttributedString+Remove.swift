//
//  NSMutableAttributedString+Remove.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/28.
//

import Foundation

// MARK: - remove
extension FZBuildingBlockWrapper where Base: NSMutableAttributedString {

    /// 移除指定属性
    ///
    /// - Parameters:
    ///   - attributeName: attributeName
    ///   - range: range
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func remove(attributeName: NSAttributedString.Key, range: NSRange? = nil) -> Base {
        base.removeAttribute(attributeName, range: range ?? self.range)
        return base
    }

    /// 移除指定属性
    ///
    /// - Parameters:
    ///   - attributeNames: attributeNames
    ///   - range: range
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func remove(attributeNames: [NSAttributedString.Key], range: NSRange? = nil) -> Base {
        if attributeNames.count > 1 {
            if let firstAttributeName = attributeNames.first {
                return
                    remove(attributeName: firstAttributeName, range: range)
                        .fz.remove(attributeNames: Array(attributeNames.dropFirst()), range: range)
            }
        } else {
            if let firstAttributeName = attributeNames.first {
                return remove(attributeName: firstAttributeName, range: range)
            }
        }
        return base
    }

}
