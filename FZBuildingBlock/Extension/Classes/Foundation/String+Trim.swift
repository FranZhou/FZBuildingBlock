//
//  String+Trim.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/1/25.
//

import Foundation


// MARK: - 移除指定字符
extension String{
    
    /// 根据规则处理字符串
    ///
    /// - Parameters:
    ///   - filter: 过滤条件
    ///   - center: 过滤中间
    ///   - left: 过滤左边
    ///   - right: 过滤右边
    /// - Returns:
    public func fz_trim(with filter: [Character], trimCenter center: Bool, trimLeft left: Bool, trimRight right: Bool) -> String{
        var res = self
        if left {
            res = res.fz_trimLeft(with: filter)
        }
        if right {
            res = res.fz_trimRight(with: filter)
        }
        if center {
            res = res.fz_trimCenter(with: filter)
        }
        return res
    }
    
    
    /// 移除左边指定字符
    ///
    /// - Parameter filter: 要移除的字符
    /// - Returns:
    public func fz_trimLeft(with filter: [Character]) -> String{
        var startIndex = self.startIndex
        let endIndex = self.index(before: self.endIndex)
        while startIndex <= endIndex{
            if !filter.contains(self[startIndex]){
                break
            }
            startIndex = self.index(after: startIndex)
        }
        return String(self[startIndex...endIndex])
    }
    
    
    /// 移除右边指定字符
    ///
    /// - Parameter filter: 要移除的字符
    /// - Returns:
    public func fz_trimRight(with filter: [Character]) -> String{
        let startIndex = self.startIndex
        var endIndex = self.index(before: self.endIndex)
        while startIndex <= endIndex{
            if !filter.contains(self[endIndex]){
                break
            }
            endIndex = self.index(before: endIndex)
        }
        return String(self[startIndex...endIndex])
    }
    
    
    /// 移除中间指定字符
    ///
    /// - Parameter filter: 要移除的字符
    /// - Returns:
    public func fz_trimCenter(with filter: [Character]) -> String{
        var startIndex = self.startIndex
        var endIndex = self.index(before: self.endIndex)
        
        while startIndex <= endIndex{
            if !filter.contains(self[startIndex]){
                break
            }
            startIndex = self.index(after: startIndex)
        }
        
        
        while startIndex <= endIndex{
            if !filter.contains(self[endIndex]){
                break
            }
            endIndex = self.index(before: endIndex)
        }
        
        let leftStr = String(self[self.startIndex..<startIndex])
        let rightStr = String(self[self.index(after: endIndex)..<self.endIndex])
        var centerStr = String(self[startIndex...endIndex])
        filter.forEach { (ch: Character) in
            centerStr = centerStr.replacingOccurrences(of: String(ch), with: "")
        }
        return "\(leftStr)\(centerStr)\(rightStr)"
    }
    
    
    /// 移除前后指定内容
    ///
    /// - Parameter trimString: 需要移除的CharacterSet
    /// - Returns:
    public func fz_trimString(with trimString: String) -> String{
        return self.trimmingCharacters(in: CharacterSet(charactersIn: trimString))
    }
    
    
    /// 移除前后的空格和换行符
    ///
    /// - Returns:
    public func fz_trimSpaceAndNewLine() -> String{
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    

}



// MARK: - 移除空格
extension String{
    
    /// 移除全部空格
    ///
    /// - Returns:
    public func fz_trimAllWhiteSpace() -> String{
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    
    /// 移除前后空格
    ///
    /// - Returns:
    public func fz_trimLeftAndRightWhiteSpace() -> String{
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    /// 移除左边空格
    ///
    /// - Returns:
    public func fz_trimLeftWhiteSpace() -> String{
        return self.fz_trimLeft(with: [" "])
    }
    
    
    /// 移除右边空格
    ///
    /// - Returns:
    public func fz_trimRightWhiteSpace() -> String{
        return self.fz_trimRight(with: [" "])
    }
    
    
    /// 移除中间空格
    ///
    /// - Returns:
    public func fz_trimCenterWhiteSpace() -> String{
        return fz_trimCenter(with: [" "])
    }
    

}


// MARK: - 移除换行符
extension String{
    
    /// 移除全部换行符
    ///
    /// - Returns:
    public func fz_trimAllNewLine() -> String{
        return self.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: "\r\n", with: "")
    }
    
    /// 移除前后换行符
    ///
    /// - Returns:
    public func fz_trimLeftAndRightNewLine() -> String{
        return self.trimmingCharacters(in: CharacterSet.newlines)
    }
    
    /// 移除左边换行
    /// 换行控制符有3中  \n \r \r\n
    ///
    /// - Returns:
    public func fz_trimLeftNewLine() -> String{
        var startIndex = self.startIndex
        let endIndex = self.endIndex
        while startIndex != endIndex{
            let ch = self[startIndex]
            if !ch.unicodeScalars.elementsEqual("\n".unicodeScalars) && !ch.unicodeScalars.elementsEqual("\r".unicodeScalars) && !ch.unicodeScalars.elementsEqual("\r\n".unicodeScalars){
                break
            }
            startIndex = self.index(after: startIndex)
        }
        return String(self[startIndex..<endIndex])
    }
    
    
    /// 移除右边换行
    /// 换行控制符有3中  \n \r \r\n
    ///
    /// - Returns:
    public func fz_trimRightNewLine() -> String{
        let startIndex = self.startIndex
        var endIndex = self.index(before: self.endIndex)
        while startIndex != endIndex{
            let ch = self[endIndex]
            if !ch.unicodeScalars.elementsEqual("\n".unicodeScalars) && !ch.unicodeScalars.elementsEqual("\r".unicodeScalars) && !ch.unicodeScalars.elementsEqual("\r\n".unicodeScalars){
                break
            }
            endIndex = self.index(before: endIndex)
        }
        return String(self.unicodeScalars[startIndex...endIndex])
    }
    
    /// 移除中间指定字符
    ///
    /// - Parameter filter: 要移除的字符
    /// - Returns:
    public func fz_trimCenterNewLine() -> String{
        var startIndex = self.startIndex
        var endIndex = self.index(before: self.endIndex)
        
        while startIndex <= endIndex{
            let ch = self[startIndex]
            if !ch.unicodeScalars.elementsEqual("\n".unicodeScalars) && !ch.unicodeScalars.elementsEqual("\r".unicodeScalars) && !ch.unicodeScalars.elementsEqual("\r\n".unicodeScalars){
                break
            }
            startIndex = self.index(after: startIndex)
        }
        
        
        while startIndex <= endIndex{
            let ch = self[endIndex]
            if !ch.unicodeScalars.elementsEqual("\n".unicodeScalars) && !ch.unicodeScalars.elementsEqual("\r".unicodeScalars) && !ch.unicodeScalars.elementsEqual("\r\n".unicodeScalars){
                break
            }
            endIndex = self.index(before: endIndex)
        }
        
        let leftStr = String(self[self.startIndex..<startIndex])
        let rightStr = String(self[self.index(after: endIndex)..<self.endIndex])
        let centerStr = String(self[startIndex...endIndex]).fz_trimAllNewLine()
        
        return "\(leftStr)\(centerStr)\(rightStr)"
    }
}
