//
//  String+SafeAccess.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/1/25.
//

import Foundation

extension String {

    /// 安全的下标访问
    /// 控制上下限在 [0, self.count)之内
    ///
    ///     let subscriptString = "FranZhou"
    ///     subscriptString[fz_safe: 1..<4]       // "ran"
    ///     subscriptString[fz_safe: -10..<(-1)]  // nil
    ///     subscriptString[fz_safe: -1..<9]      // "FranZhou"
    ///     subscriptString[fz_safe: 10..<12]     // nil
    ///
    /// - Parameter range:
    public subscript(fz_safe range: Range<Int>) -> String? {
        get {
            let start = range.lowerBound < 0 ? 0 : range.lowerBound
            let end = range.upperBound > self.count ? self.count : range.upperBound

            guard start < end,
                let startIndex = self.index(self.startIndex, offsetBy: start, limitedBy: self.endIndex),
                let endIndex = self.index(self.startIndex, offsetBy: end, limitedBy: self.endIndex)
                else {
                    return nil
            }

            return String(self[startIndex ..< endIndex])
        }
    }

    /// 安全的下标访问
    /// 控制上下限在 [0, self.count-1]之内
    ///
    ///     let subscriptString = "FranZhou"
    ///     subscriptString[fz_safe: 1...4]       // "ranZ"
    ///     subscriptString[fz_safe: -10...(-1)]  // nil
    ///     subscriptString[fz_safe: -1...9]      // "FranZhou"
    ///     subscriptString[fz_safe: 10...12]     // nil
    ///
    /// - Parameter range:
    public subscript(fz_safe range: CountableClosedRange<Int>) -> String? {
        get {
            let start = range.lowerBound < 0 ? 0 : range.lowerBound
            let end = range.upperBound > self.count - 1 ? self.count - 1 : range.upperBound

            guard start <= end,
                let startIndex = self.index(self.startIndex, offsetBy: start, limitedBy: self.endIndex),
                let endIndex = self.index(self.startIndex, offsetBy: end, limitedBy: self.endIndex)
                else {
                    return nil
            }

            return String(self[startIndex ... endIndex])
        }
    }

    /// 安全的下标访问
    ///
    ///     let subscriptString = "FranZhou"
    ///     subscriptString[fz_safe: 1]    // "r"
    ///     subscriptString[fz_safe: -1]   // nil
    ///     subscriptString[fz_safe: 9]    // nil
    ///
    /// - Parameter index:
    public subscript(fz_safe index: Int) -> String? {
        get {
            return self[fz_safe: Range(uncheckedBounds: (lower: index, upper: index + 1))]
        }
    }

}
