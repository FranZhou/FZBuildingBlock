//
//  NSAttributedString+ConvenienceInit.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/28.
//

import Foundation

extension NSAttributedString {
    
    /// 便利构造函数
    ///
    /// - Parameters:
    ///   - string: 字符串
    ///   - attribute: 枚举属性
    public convenience init(string: String, attribute: FZAttribute) {
        self.init(string: string, attributes: [attribute])
    }
    
    /// 便利构造函数
    ///
    /// - Parameters:
    ///   - string: 字符串
    ///   - attributes: 枚举属性数组
    public convenience init(string: String, attributes: [FZAttribute]) {
        self.init(string: string, attributes: attributes.reduce([:], { $1.fill(in: $0 ) }))
    }
    
}

