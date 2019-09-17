//
//  String+Base64.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/3/28.
//

import Foundation

extension FZBuildingBlockWrapper where Base == String {

    /// base64加密
    ///
    /// - Returns:
    public func base64Encode() -> String? {
        if let data = base.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }

    /// base64解密
    ///
    /// - Returns:
    public func base64Decode() -> String? {
        if let data = self.base64Data() {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }

    /// string --> base64 Data
    ///
    /// - Returns: Data
    public func base64Data() -> Data? {
        return Data(base64Encoded: base, options: Data.Base64DecodingOptions.init(rawValue: 0))
    }

}
