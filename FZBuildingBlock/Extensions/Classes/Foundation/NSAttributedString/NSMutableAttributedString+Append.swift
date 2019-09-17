//
//  NSMutableAttributedString+Append.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/28.
//

import Foundation

// MARK: - append
extension FZBuildingBlockWrapper where Base: NSMutableAttributedString {

    /// 添加属性字符串到尾部
    ///
    /// - Parameter attrString: attrString
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func append(attrString: NSAttributedString) -> Base {
        base.append(attrString)
        return base
    }

    /// 添加字符串到尾部，可以指定单个属性
    ///
    /// - Parameters:
    ///   - string: string
    ///   - attribute: attribute
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func append(string: String, attribute: FZAttribute) -> Base {
        return append(string: string, attributes: [attribute])
    }

    /// 添加字符串到尾部，可以指定多个属性
    ///
    /// - Parameters:
    ///   - string: string
    ///   - attributes: attributes
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func append(string: String, attributes: [FZAttribute] = []) -> Base {
        return append(attrString: NSMutableAttributedString.fz.mutableAttributedString(with: string, attributes: attributes))
    }
}
