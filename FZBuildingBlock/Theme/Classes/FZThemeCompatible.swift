//
//  FZThemeCompatible.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/8.
//

import Foundation

public protocol FZThemeCompatible: AnyObject {

}

extension FZThemeCompatible {
    /// Gets a namespace holder for FZTheme compatible types.
    public var fz_theme: FZThemeWrapper<Self> {
        get { return FZThemeWrapper(self) }
        set { }
    }
}
