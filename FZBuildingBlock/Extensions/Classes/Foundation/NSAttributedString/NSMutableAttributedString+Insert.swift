//
//  NSMutableAttributedString+Insert.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/28.
//

import Foundation

// MARK: - insert
extension FZBuildingBlockWrapper where Base: NSMutableAttributedString {

    /// 在指定位置插入
    ///
    /// - Parameters:
    ///   - attrString: attrString
    ///   - loc: loc
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func insert(attrString: NSAttributedString, at loc: Int) -> Base {
        base.insert(attrString, at: loc)
        return base
    }

    /// 在指定位置插入
    ///
    /// - Parameters:
    ///   - string: string
    ///   - attribute: attribute
    ///   - loc: loc
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func insert(string: String, attribute: FZAttribute, at loc: Int) -> Base {
        return insert(string: string, attributes: [attribute], at: loc)
    }

    /// 在指定位置插入
    ///
    /// - Parameters:
    ///   - string: string
    ///   - attributes: attributes
    ///   - loc: loc
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func insert(string: String, attributes: [FZAttribute] = [], at loc: Int) -> Base {
        return insert(attrString: NSMutableAttributedString.fz.mutableAttributedString(with: string, attributes: attributes), at: loc)
    }

}
