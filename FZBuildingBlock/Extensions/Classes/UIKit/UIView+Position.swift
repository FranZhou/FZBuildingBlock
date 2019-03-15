//
//  UIView+Position.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/3.
//

import Foundation

extension UIView{
    
    
    public var fz_size: CGSize {
        get{
            return self.frame.size
        }
        set{
            self.frame.size = newValue
        }
    }
    
    public var fz_origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.frame.origin = newValue
        }
    }
    
    public var fz_width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            self.frame.size.width = newValue
        }
    }
    
    public var fz_height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            self.frame.size.height = newValue
        }
    }
    
    public var fz_x: CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            self.frame.origin.x = newValue
        }
    }
    
    public var fz_y: CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            self.frame.origin.y = newValue
        }
    }
    
    
    ///  外部中心点，根据frame计算
    ///  例如: frame为 （50, 50, 100, 100）. outerCenter 为 (100, 100), 即(x + width/2.0, y + height/2.0)
    ///  这里CenterX CenterY变化并不会影响width和height的变化
    public var fz_outerCenter: CGPoint{
        set{
            self.center = newValue
        }
        get{
            return self.center
        }
    }
    
    public var fz_outerCenterX: CGFloat{
        set{
            self.center.x = newValue
        }
        get{
            return self.center.x
        }
    }
    
    public var fz_outerCenterY: CGFloat{
        set{
            self.center.y = newValue
        }
        get{
            return self.center.y
        }
    }
    
    ///  内部中心点，根据bounds计算
    ///  例如: frame为 （50, 50, 100, 100）. innerCenter 为 (50, 50), 即(width/2.0, height/2.0)
    ///  CenterX CenterY变化直接影响到width和height的值
    public var fz_innerCenter: CGPoint{
        set{
            self.fz_width = newValue.x * 2
            self.fz_height = newValue.y * 2
        }
        get{
            return CGPoint(x: self.fz_width / 2.0, y: self.fz_height / 2.0)
        }
    }
    
    // 变动时，默认origin.x位置不变
    public var fz_innerCenterX: CGFloat{
        set{
            self.fz_width = newValue * 2.0
        }
        get{
            return self.fz_width / 2.0
        }
    }
    
    public var fz_innerCenterY: CGFloat{
        set{
            self.fz_height = newValue * 2.0
        }
        get{
            return self.fz_height / 2.0
        }
    }
    
    
}
