//
//  URLString.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/1/25.
//

import Foundation

// MARK: - url string 处理
extension FZBuildingBlockWrapper where Base == String {

    /// url编码
    ///
    /// - Returns: 编码后的字符串
    public func urlEncode() -> String? {
        return base.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]"))
    }

    /// url解码
    ///
    /// - Returns: 解码后的结果
    public func urlDecode() -> String? {
        return base.removingPercentEncoding
    }
}
