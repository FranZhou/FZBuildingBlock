//
//  NSMutableAttributedString+Common.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/3/25.
//

import Foundation


// MARK: - fz_set
extension NSMutableAttributedString{
    
    
    /// 设置指定位置的属性
    ///
    /// - Parameters:
    ///   - attribute: attribute
    ///   - range: range
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func fz_set(attribute: FZAttribute, range: NSRange? = nil) -> Self {
        addAttributes(attribute.value, range: range ?? self.range)
        return self
    }
    
    
    /// 设置指定位置的属性
    ///
    /// - Parameters:
    ///   - attributes: attributes
    ///   - range: range
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func fz_set(attributes: [FZAttribute], range: NSRange? = nil) -> Self {
        addAttributes(attributes.reduce([:], { $1.fill(in: $0) }), range: range ?? self.range)
        return self
    }
    
}



// MARK: - fz_addAttribute
extension NSMutableAttributedString{
    
    /// 添加指定范围的字符串属性
    ///
    /// - Parameters:
    ///   - attribute: 枚举属性
    ///   - range: 范围
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func fz_addAttribute(attribute: FZAttribute, range: NSRange? = nil) -> Self {
        addAttributes(attribute.value, range: range ?? self.range)
        return self
    }
    
    /// 添加指定范围的多个属性
    ///
    /// - Parameters:
    ///   - attributes: 枚举属性数组
    ///   - range: 范围
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func fz_addAttributes(attributes: [FZAttribute], range: NSRange? = nil) -> Self {
        addAttributes(attributes.reduce([:], { $1.fill(in: $0) }), range: range ?? self.range)
        return self
    }
}


// MARK: - fz_append
extension NSMutableAttributedString{
    
    /// 添加属性字符串到尾部
    ///
    /// - Parameter attrString: attrString
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func fz_append(attrString: NSAttributedString) -> Self {
        append(attrString)
        return self
    }
    
    /// 添加字符串到尾部，可以指定单个属性
    ///
    /// - Parameters:
    ///   - string: string
    ///   - attribute: attribute
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func fz_append(string: String, attribute: FZAttribute) -> Self {
        return fz_append(string: string, attributes: [attribute])
    }
    
    /// 添加字符串到尾部，可以指定多个属性
    ///
    /// - Parameters:
    ///   - string: string
    ///   - attributes: attributes
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func fz_append(string: String, attributes: [FZAttribute] = []) -> Self {
        return self.fz_append(attrString: NSMutableAttributedString(string: string, attributes: attributes))
    }
}


// MARK: - fz_insert
extension NSMutableAttributedString{
    
    
    /// 在指定位置插入
    ///
    /// - Parameters:
    ///   - attrString: attrString
    ///   - loc: loc
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func fz_insert(attrString: NSAttributedString, at loc: Int) -> Self{
        insert(attrString, at: loc)
        return self
    }
    
    
    /// 在指定位置插入
    ///
    /// - Parameters:
    ///   - string: string
    ///   - attribute: attribute
    ///   - loc: loc
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func fz_insert(string: String, attribute: FZAttribute, at loc: Int) -> Self{
        return self.fz_insert(string: string, attributes: [attribute], at: loc)
    }
    
    
    /// 在指定位置插入
    ///
    /// - Parameters:
    ///   - string: string
    ///   - attributes: attributes
    ///   - loc: loc
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func fz_insert(string: String, attributes: [FZAttribute] = [], at loc: Int) -> Self{
        return self.fz_insert(attrString: NSMutableAttributedString(string: string, attributes: attributes), at: loc)
    }
    
}



// MARK: - fz_removeAttribute
extension NSMutableAttributedString{
    
    
    /// 移除指定属性
    ///
    /// - Parameters:
    ///   - attributeName: attributeName
    ///   - range: range
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func fz_removeAttribute(attributeName: NSAttributedString.Key, range: NSRange? = nil) -> Self{
        removeAttribute(attributeName, range: range ?? self.range)
        return self
    }
    
    
    
    /// 移除指定属性
    ///
    /// - Parameters:
    ///   - attributeNames: attributeNames
    ///   - range: range
    /// - Returns: 对象本身，用于链式语法
    @discardableResult
    public func fz_removeAttributes(attributeNames: [NSAttributedString.Key], range: NSRange? = nil) -> Self{
        if attributeNames.count > 1{
            if let firstAttributeName = attributeNames.first{
                return fz_removeAttribute(attributeName: firstAttributeName, range: range).fz_removeAttributes(attributeNames: Array(attributeNames.dropFirst()), range: range)
            }
        } else {
            if let firstAttributeName = attributeNames.first{
                return fz_removeAttribute(attributeName: firstAttributeName, range: range)
            }
        }
        return self
    }
    
}
