//
//  Array+SafeAccess.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/3/25.
//

import Foundation

extension Array {

    /// 安全的下标访问
    ///
    ///     let array = Array([1,2,3,4,5])
    ///     array[fz_safe: 100]    // nil
    ///
    /// - Parameter index: index
    public subscript(fz_safe index: Int) -> Element? {
        return index >= 0 && index < count ? self[index] : nil
    }
}
