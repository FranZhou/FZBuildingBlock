//
//  UIImage+CornerRadius.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/16.
//

import Foundation

extension UIImage {
    
    
    /// 图片圆角截取
    ///
    /// - Parameters:
    ///   - leftTop: 左上方圆角半径
    ///   - leftBottom: 左下方圆角半径
    ///   - rightBottom: 右下方圆角半径
    ///   - rightTop: 右上方圆角半径
    public func fz_cornerRadius(leftTop: CGFloat, leftBottom: CGFloat, rightBottom: CGFloat, rightTop: CGFloat) -> UIImage? {
        if leftTop == 0 && leftBottom == 0 && rightBottom == 0 && rightTop == 0{
            return self.fz_copy()
        }
        
        if self.size.equalTo(.zero) {
            return self.fz_copy()
        }
        
        let width = self.size.width
        let height = self.size.height
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        
        let bezier = UIBezierPath.init()
        bezier.lineWidth = 0
        
        // 左上方圆角
        bezier.move(to: CGPoint(x: leftTop, y: 0))
        bezier.addArc(withCenter: CGPoint(x: leftTop, y: leftTop), radius: leftTop, startAngle: -CGFloat.pi/2.0, endAngle: -CGFloat.pi, clockwise: false)
        
        bezier.addLine(to: CGPoint(x: 0, y: height-leftBottom))
        
        // 左下方圆角
        bezier.addArc(withCenter: CGPoint(x: leftBottom, y: height-leftBottom), radius: leftBottom, startAngle: -CGFloat.pi, endAngle: -CGFloat.pi*1.5, clockwise: false)
        
        bezier.addLine(to: CGPoint(x: width-rightBottom, y: height))
        
        // 右下方圆角
        bezier.addArc(withCenter: CGPoint(x: width-rightBottom, y: height-rightBottom), radius: rightBottom, startAngle: -CGFloat.pi*0.5, endAngle: 0, clockwise: false)
        
        bezier.addLine(to: CGPoint(x: width, y: rightTop))
        
        // 右上方圆角
        bezier.addArc(withCenter: CGPoint(x: width-rightTop, y: rightTop), radius: rightTop, startAngle: 0, endAngle: -CGFloat.pi*0.5, clockwise: false)
        
        bezier.addLine(to: CGPoint(x: leftTop, y: 0))
        
        // 封闭未形成闭环的路径
        bezier.close()
        
        // 路径绘制
        bezier.stroke()
        
        // 在这以后的图形绘制超出当前路径范围则不可见
        bezier.addClip()
        
        self.draw(in: CGRect(origin: .zero, size: self.size))
        let cornerRadiusImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return cornerRadiusImage
    }
    
    
    /// 图片圆角
    ///
    /// - Parameter radius: 圆角的半径
    public func fz_cornerRadius(withRadius radius: CGFloat) -> UIImage?{
        return self.fz_cornerRadius(leftTop: radius, leftBottom: radius, rightBottom: radius, rightTop: radius)
    }
    
}
