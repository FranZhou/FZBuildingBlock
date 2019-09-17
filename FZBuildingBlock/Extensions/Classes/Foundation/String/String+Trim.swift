//
//  String+Trim.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/1/25.
//

import Foundation

// MARK: - 移除指定字符
extension FZBuildingBlockWrapper where Base == String {

    /// 根据规则处理字符串
    ///
    /// - Parameters:
    ///   - filter: 过滤条件
    ///   - center: 过滤中间
    ///   - left: 过滤左边
    ///   - right: 过滤右边
    /// - Returns:
    public func trim(withFilter filter: [Character], trimCenter center: Bool, trimLeft left: Bool, trimRight right: Bool) -> String {
        var res = base
        if left {
            res = res.fz.trimLeft(withFilter: filter)
        }
        if right {
            res = res.fz.trimRight(withFilter: filter)
        }
        if center {
            res = res.fz.trimCenter(withFilter: filter)
        }
        return res
    }

    /// 移除左边指定字符
    ///
    /// - Parameter filter: 要移除的字符
    /// - Returns:
    public func trimLeft(withFilter filter: [Character]) -> String {
        var startIndex = base.startIndex
        let endIndex = base.index(before: base.endIndex)
        while startIndex <= endIndex {
            if !filter.contains(base[startIndex]) {
                break
            }
            startIndex = base.index(after: startIndex)
        }
        return String(base[startIndex...endIndex])
    }

    /// 移除右边指定字符
    ///
    /// - Parameter filter: 要移除的字符
    /// - Returns:
    public func trimRight(withFilter filter: [Character]) -> String {
        let startIndex = base.startIndex
        var endIndex = base.index(before: base.endIndex)
        while startIndex <= endIndex {
            if !filter.contains(base[endIndex]) {
                break
            }
            endIndex = base.index(before: endIndex)
        }
        return String(base[startIndex...endIndex])
    }

    /// 移除中间指定字符
    ///
    /// - Parameter filter: 要移除的字符
    /// - Returns:
    public func trimCenter(withFilter filter: [Character]) -> String {
        var startIndex = base.startIndex
        var endIndex = base.index(before: base.endIndex)

        while startIndex <= endIndex {
            if !filter.contains(base[startIndex]) {
                break
            }
            startIndex = base.index(after: startIndex)
        }

        while startIndex <= endIndex {
            if !filter.contains(base[endIndex]) {
                break
            }
            endIndex = base.index(before: endIndex)
        }

        let leftStr = String(base[base.startIndex..<startIndex])
        let rightStr = String(base[base.index(after: endIndex)..<base.endIndex])
        var centerStr = String(base[startIndex...endIndex])
        filter.forEach { (ch: Character) in
            centerStr = centerStr.replacingOccurrences(of: String(ch), with: "")
        }
        return "\(leftStr)\(centerStr)\(rightStr)"
    }

    /// 移除前后指定内容
    ///
    /// - Parameter trimString: 需要移除的CharacterSet
    /// - Returns:
    public func trimLeftAndRight(withTrimString trimString: String) -> String {
        return base.trimmingCharacters(in: CharacterSet(charactersIn: trimString))
    }

    /// 移除前后的空格和换行符
    ///
    /// - Returns:
    public func trimSpaceAndNewLine() -> String {
        return base.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

}

// MARK: - 移除空格
extension FZBuildingBlockWrapper where Base == String {

    /// 移除全部空格
    ///
    /// - Returns:
    public func trimAllWhiteSpace() -> String {
        return base.replacingOccurrences(of: " ", with: "")
    }

    /// 移除前后空格
    ///
    /// - Returns:
    public func trimLeftAndRightWhiteSpace() -> String {
        return base.trimmingCharacters(in: CharacterSet.whitespaces)
    }

    /// 移除左边空格
    ///
    /// - Returns:
    public func trimLeftWhiteSpace() -> String {
        return trimLeft(withFilter: [" "])
    }

    /// 移除右边空格
    ///
    /// - Returns:
    public func trimRightWhiteSpace() -> String {
        return trimRight(withFilter: [" "])
    }

    /// 移除中间空格
    ///
    /// - Returns:
    public func trimCenterWhiteSpace() -> String {
        return trimCenter(withFilter: [" "])
    }

}

// MARK: - 移除换行符
extension FZBuildingBlockWrapper where Base == String {

    /// 移除全部换行符
    ///
    /// - Returns:
    public func trimAllNewLine() -> String {
        return base.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: "\r\n", with: "")
    }

    /// 移除前后换行符
    ///
    /// - Returns:
    public func trimLeftAndRightNewLine() -> String {
        return base.trimmingCharacters(in: CharacterSet.newlines)
    }

    /// 移除左边换行
    /// 换行控制符有3中  \n \r \r\n
    ///
    /// - Returns:
    public func trimLeftNewLine() -> String {
        var startIndex = base.startIndex
        let endIndex = base.endIndex
        while startIndex != endIndex {
            let ch = base[startIndex]
            if !ch.unicodeScalars.elementsEqual("\n".unicodeScalars) && !ch.unicodeScalars.elementsEqual("\r".unicodeScalars) && !ch.unicodeScalars.elementsEqual("\r\n".unicodeScalars) {
                break
            }
            startIndex = base.index(after: startIndex)
        }
        return String(base[startIndex..<endIndex])
    }

    /// 移除右边换行
    /// 换行控制符有3中  \n \r \r\n
    ///
    /// - Returns:
    public func trimRightNewLine() -> String {
        let startIndex = base.startIndex
        var endIndex = base.index(before: base.endIndex)
        while startIndex != endIndex {
            let ch = base[endIndex]
            if !ch.unicodeScalars.elementsEqual("\n".unicodeScalars) && !ch.unicodeScalars.elementsEqual("\r".unicodeScalars) && !ch.unicodeScalars.elementsEqual("\r\n".unicodeScalars) {
                break
            }
            endIndex = base.index(before: endIndex)
        }
        return String(base.unicodeScalars[startIndex...endIndex])
    }

    /// 移除中间指定字符
    ///
    /// - Parameter filter: 要移除的字符
    /// - Returns:
    public func trimCenterNewLine() -> String {
        var startIndex = base.startIndex
        var endIndex = base.index(before: base.endIndex)

        while startIndex <= endIndex {
            let ch = base[startIndex]
            if !ch.unicodeScalars.elementsEqual("\n".unicodeScalars) && !ch.unicodeScalars.elementsEqual("\r".unicodeScalars) && !ch.unicodeScalars.elementsEqual("\r\n".unicodeScalars) {
                break
            }
            startIndex = base.index(after: startIndex)
        }

        while startIndex <= endIndex {
            let ch = base[endIndex]
            if !ch.unicodeScalars.elementsEqual("\n".unicodeScalars) && !ch.unicodeScalars.elementsEqual("\r".unicodeScalars) && !ch.unicodeScalars.elementsEqual("\r\n".unicodeScalars) {
                break
            }
            endIndex = base.index(before: endIndex)
        }

        let leftStr = String(base[base.startIndex..<startIndex])
        let rightStr = String(base[base.index(after: endIndex)..<base.endIndex])
        let centerStr = String(base[startIndex...endIndex]).fz.trimAllNewLine()

        return "\(leftStr)\(centerStr)\(rightStr)"
    }
}
