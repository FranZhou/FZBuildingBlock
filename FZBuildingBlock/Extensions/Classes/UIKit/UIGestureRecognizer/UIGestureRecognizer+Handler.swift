//
//  UIGestureRecognizer+Handler.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/16.
//

import Foundation

private struct FZUIGestureRecognizerHandlerAssociatedKey {
    static var associatedKeys: UnsafeRawPointer = UnsafeRawPointer(bitPattern: "FZUIGestureRecognizerHandlerAssociatedKey_associatedKeys".hashValue)!
}

extension FZBuildingBlockWrapper where Base: UIGestureRecognizer {

    internal func setGestureRecognizerHandler<T: UIGestureRecognizer>(handler: FZUIGestureRecognizerClosureHandler<T>) {
        objc_setAssociatedObject(base, FZUIGestureRecognizerHandlerAssociatedKey.associatedKeys, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    internal func gestureRecognizerHandler<T>() -> FZUIGestureRecognizerClosureHandler<T>? {
        return objc_getAssociatedObject(base, FZUIGestureRecognizerHandlerAssociatedKey.associatedKeys) as? FZUIGestureRecognizerClosureHandler
    }

}
