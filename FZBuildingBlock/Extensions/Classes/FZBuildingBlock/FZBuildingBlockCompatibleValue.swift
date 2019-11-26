//
//  FZBuildingBlockCompatibleValue.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/28.
//

import Foundation

/// Represents a value type that is compatible with FZBuildingBlock. You can use `fz` property to get a
/// value in the namespace of FZBuildingBlock.
public protocol FZBuildingBlockCompatibleValue {

}

extension FZBuildingBlockCompatibleValue {
    /// Gets a namespace holder for FZBuildingBlock compatible value types.
    public var fz: FZBuildingBlockWrapper<Self> {
        get { return FZBuildingBlockWrapper(self) }
        set { }
    }
}
