//
//  UIView+Position.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/3.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UIView {

    public var size: CGSize {
        get {
            return base.frame.size
        }
        set {
            base.frame.size = newValue
        }
    }

    public var origin: CGPoint {
        get {
            return base.frame.origin
        }
        set {
            base.frame.origin = newValue
        }
    }

    public var width: CGFloat {
        get {
            return base.frame.size.width
        }
        set {
            base.frame.size.width = newValue
        }
    }

    public var height: CGFloat {
        get {
            return base.frame.size.height
        }
        set {
            base.frame.size.height = newValue
        }
    }

    public var x: CGFloat {
        get {
            return base.frame.origin.x
        }
        set {
            base.frame.origin.x = newValue
        }
    }

    public var y: CGFloat {
        get {
            return base.frame.origin.y
        }
        set {
            base.frame.origin.y = newValue
        }
    }

    ///  外部中心点，根据frame计算,相对于superView的中心点
    ///  例如: frame为 （50, 50, 100, 100）. outerCenter 为 (100, 100), 即(x + width/2.0, y + height/2.0)
    ///  这里CenterX CenterY变化并不会影响width和height的变化
    public var outerCenter: CGPoint {
        set {
            base.center = newValue
        }
        get {
            return base.center
        }
    }

    public var outerCenterX: CGFloat {
        set {
            base.center.x = newValue
        }
        get {
            return base.center.x
        }
    }

    public var outerCenterY: CGFloat {
        set {
            base.center.y = newValue
        }
        get {
            return base.center.y
        }
    }

    ///  内部中心点，根据bounds计算，自己的中心点
    ///  例如: frame为 （50, 50, 100, 100）. innerCenter 为 (50, 50), 即(width/2.0, height/2.0)
    ///  CenterX CenterY变化直接影响到width和height的值
    public var innerCenter: CGPoint {
        set {
            width = newValue.x * 2
            height = newValue.y * 2
        }
        get {
            return CGPoint(x: width / 2.0, y: height / 2.0)
        }
    }

    // 变动时，默认origin.x位置不变
    public var innerCenterX: CGFloat {
        set {
            width = newValue * 2.0
        }
        get {
            return width / 2.0
        }
    }

    public var innerCenterY: CGFloat {
        set {
            height = newValue * 2.0
        }
        get {
            return height / 2.0
        }
    }

}
