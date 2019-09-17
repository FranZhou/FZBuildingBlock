//
//  UIImage+CornerRadius.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/16.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UIImage {

    /// 图片圆角截取
    ///
    /// - Parameters:
    ///   - leftTop: 左上方圆角半径
    ///   - leftBottom: 左下方圆角半径
    ///   - rightBottom: 右下方圆角半径
    ///   - rightTop: 右上方圆角半径
    public func cornerRadius(leftTop: CGFloat, leftBottom: CGFloat, rightBottom: CGFloat, rightTop: CGFloat) -> UIImage? {
        if leftTop == 0 && leftBottom == 0 && rightBottom == 0 && rightTop == 0 {
            return copy()
        }

        if base.size.equalTo(.zero) {
            return copy()
        }

        let width = base.size.width
        let height = base.size.height

        UIGraphicsBeginImageContextWithOptions(base.size, false, UIScreen.main.scale)

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

        base.draw(in: CGRect(origin: .zero, size: base.size))
        let cornerRadiusImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return cornerRadiusImage
    }

    /// 图片圆角
    ///
    /// - Parameter radius: 圆角的半径
    public func cornerRadius(withRadius radius: CGFloat) -> UIImage? {
        return cornerRadius(leftTop: radius, leftBottom: radius, rightBottom: radius, rightTop: radius)
    }

}
