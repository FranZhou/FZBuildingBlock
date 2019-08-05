//
//  String+Emoji.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/3/27.
//

import Foundation


extension String{
    
    /// string中是否包含emoji表情
    public var fz_containsEmoji: Bool{
        for scalar in unicodeScalars {
            switch scalar.value {
            case
            0x00A0...0x00AF,
            0x2030...0x204F,
            0x2120...0x213F,
            0x2190...0x21AF,
            0x2310...0x329F,
            0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }
    
    /// 字符串中的所有emoji位置
    public var fz_emojisRanges: [Range<String.Index>]{
        var emojisRanges: [Range<String.Index>] = []
        self.enumerateSubstrings(in: self.startIndex..<self.endIndex, options: .byComposedCharacterSequences) { (substring: String?, substringRange: Range<String.Index>, _, _) in
            if let substring = substring,
                substring.fz_containsEmoji{
                emojisRanges.append(substringRange)
            }
        }
        return emojisRanges
    }
    
    /// 字符串中的所有emoji数组
    public var fz_emojisArray: [String]{
        return self.fz_emojisRanges.map { (range: Range<String.Index>) -> String in
            return String(self[range])
        }
    }
    
    /// 字符串中的所有emoji
    public var fz_emojisString: String {
        return self.fz_emojisArray.joined(separator: "")
    }
    
    /// 去除掉emoji后的字符串数组
    public var fz_stringArrayWithoutEmojis: [String]{
        let charset = CharacterSet(charactersIn: self.fz_emojisArray.joined(separator: ""))
        return self.components(separatedBy: charset).filter({ !$0.isEmpty })
    }
    
    
    /// 去除掉emoji后的字符串
    public var fz_stringWithoutEmojis: String {
        return self.fz_stringArrayWithoutEmojis.joined(separator: "")
    }
    
    /// emoji数量
    public var fz_emojiCount: Int {
        return self.fz_emojisArray.count
    }
}


