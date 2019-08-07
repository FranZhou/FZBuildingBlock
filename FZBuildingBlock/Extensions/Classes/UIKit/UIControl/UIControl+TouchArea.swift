//
//  UIControl+TouchArea.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/7.
//

import Foundation

extension UIControl{
    
    fileprivate struct FZUIControlTouchAreaInsetsAssociatedKey{
        static var associatedKeys: UnsafeRawPointer = UnsafeRawPointer(bitPattern: "FZUIControlTouchAreaInsetsAssociatedKey_associatedKeys".hashValue)!
    }
    
    
    /// 扩展判断范围
    public var fz_touchAreaEdge: UIEdgeInsets{
        get{
            if let areaEdge = objc_getAssociatedObject(self, FZUIControlTouchAreaInsetsAssociatedKey.associatedKeys) as? UIEdgeInsets{
                return areaEdge
            }
            return .zero
        }
        set{
            objc_setAssociatedObject(self, FZUIControlTouchAreaInsetsAssociatedKey.associatedKeys, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let areaEdge = fz_touchAreaEdge
        let touchAreaRect = CGRect(
            x: bounds.origin.x - areaEdge.left,
            y: bounds.origin.y - areaEdge.top,
            width: bounds.size.width + areaEdge.left + areaEdge.right,
            height: bounds.size.height + areaEdge.top + areaEdge.bottom
        )
        return touchAreaRect.contains(point)
    }
    
}
