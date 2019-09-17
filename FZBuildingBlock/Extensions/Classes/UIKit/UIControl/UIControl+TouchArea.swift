//
//  UIControl+TouchArea.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/7.
//

import Foundation

private struct FZUIControlTouchAreaInsetsAssociatedKey {
    static var associatedKeys: UnsafeRawPointer = UnsafeRawPointer(bitPattern: "FZUIControlTouchAreaInsetsAssociatedKey_associatedKeys".hashValue)!
}

extension FZBuildingBlockWrapper where Base: UIControl {

    /// 设置额外热区，可以扩大或者缩小响应范围
    public var touchAreaEdge: UIEdgeInsets {
        get {
            if let areaEdge = objc_getAssociatedObject(base, FZUIControlTouchAreaInsetsAssociatedKey.associatedKeys) as? UIEdgeInsets {
                return areaEdge
            }
            return .zero
        }
        set {
            objc_setAssociatedObject(base, FZUIControlTouchAreaInsetsAssociatedKey.associatedKeys, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

}

extension UIControl {
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let areaEdge = self.fz.touchAreaEdge
        let touchAreaRect = CGRect(
            x: bounds.origin.x - areaEdge.left,
            y: bounds.origin.y - areaEdge.top,
            width: bounds.size.width + areaEdge.left + areaEdge.right,
            height: bounds.size.height + areaEdge.top + areaEdge.bottom
        )
        return touchAreaRect.contains(point)
    }
}
