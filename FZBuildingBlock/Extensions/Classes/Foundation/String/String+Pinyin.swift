//
//  String+Pinyin.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/3/26.
//

import Foundation

extension FZBuildingBlockWrapper where Base == String {

    /// 中文转拼音，转拼音后每个汉字的拼音之间会加一个空格，调用方自行处理
    ///
    ///     let des = "我是一个iOS开发"
    ///     des.fz_pinyin()  // "wo shi yi ge iOS kai fa"
    ///     des.fz_pinyin(removeTones: false)  // "wǒ shì yī gè iOS kāi fā"
    ///
    /// - Parameter removeTones: 是否移除声调，默认移除
    /// - Returns:
    public func pinyin(removeTones: Bool = true) -> String {
        let ens = NSMutableString(string: base) as CFMutableString
        // 有声调
        CFStringTransform(ens, nil, kCFStringTransformMandarinLatin, false)

        // 去掉声调
        if removeTones {
            CFStringTransform(ens, nil, kCFStringTransformStripDiacritics, false)
        }
        return String(ens)
    }
}
