//
//  FZBuildingBlockCompatible.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/28.
//

import Foundation

/// Represents an object type that is compatible with FZBuildingBlock. You can use `fz` property to get a
/// value in the namespace of FZBuildingBlock.
public protocol FZBuildingBlockCompatible: AnyObject {

}

extension FZBuildingBlockCompatible {
    /// Gets a namespace holder for FZBuildingBlock compatible types.
    public var fz: FZBuildingBlockWrapper<Self> {
        get { return FZBuildingBlockWrapper(self) }
        set { }
    }
}
