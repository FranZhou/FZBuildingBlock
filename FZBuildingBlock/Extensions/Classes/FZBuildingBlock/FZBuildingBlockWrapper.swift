//
//  FZBuildingBlockWrapper.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/28.
//

import Foundation

/**
 Wrapper for FZBuildingBlock compatible types. This type provides an extension point for connivence methods in FZBuildingBlock.
 */
public struct FZBuildingBlockWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}
