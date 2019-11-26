//
//  UIBarButtonItem+Handler.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/18.
//

import Foundation

private struct FZUIBarButtonItemHandlerAssociatedKey {
    static var associatedKeys: UnsafeRawPointer = UnsafeRawPointer(bitPattern: "FZUIBarButtonItemHandlerAssociatedKey_associatedKeys".hashValue)!
}

extension FZBuildingBlockWrapper where Base: UIBarButtonItem {

    internal var barButtonItemHandler: FZUIBarButtonItemClosureHandler? {
        get {
            return objc_getAssociatedObject(base, FZUIBarButtonItemHandlerAssociatedKey.associatedKeys) as? FZUIBarButtonItemClosureHandler
        }
        set {
            objc_setAssociatedObject(base, FZUIBarButtonItemHandlerAssociatedKey.associatedKeys, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

}
