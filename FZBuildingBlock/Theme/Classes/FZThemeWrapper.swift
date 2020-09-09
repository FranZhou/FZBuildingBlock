//
//  FZThemeWrapper.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/8.
//

import Foundation

public struct FZThemeWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}
