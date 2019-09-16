//
//  UIGestureRecognizer+Handler.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/16.
//

import Foundation

fileprivate struct FZUIGestureRecognizerHandlerAssociatedKey{
    static var associatedKeys: UnsafeRawPointer = UnsafeRawPointer(bitPattern: "FZUIGestureRecognizerHandlerAssociatedKey_associatedKeys".hashValue)!
}

extension FZBuildingBlockWrapper where Base: UIGestureRecognizer{
    
    internal func setHandler<T: UIGestureRecognizer>(handler: FZUIGestureRecognizerClosureHandler<T>) {
        objc_setAssociatedObject(base, FZUIGestureRecognizerHandlerAssociatedKey.associatedKeys, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    internal func handler<T>() -> FZUIGestureRecognizerClosureHandler<T>? {
        return objc_getAssociatedObject(base, FZUIGestureRecognizerHandlerAssociatedKey.associatedKeys) as? FZUIGestureRecognizerClosureHandler
    }
    
}
