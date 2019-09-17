//
//  UIView+CornerRadius.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/21.
//

import Foundation

extension FZBuildingBlockWrapper where Base: UIView {

    /// 传统方式给view添加圆角，内部会将masksToBounds设为true
    ///
    /// - Parameters:
    ///   - radius: 圆角半径
    ///   - borderColor: default = .clear, border color
    ///   - borderWidth: default = 0, border width
    public func addCornerRadius(withRadius radius: CGFloat, borderColor: UIColor = .clear, borderWidth: CGFloat = 0) {
        base.layer.masksToBounds = true
        base.layer.borderWidth = borderWidth
        base.layer.borderColor = borderColor.cgColor
        base.layer.cornerRadius = radius
    }

    /// 使用maskLayer给view添加圆角
    ///
    /// - Parameters:
    ///   - leftTop: 左上方圆角半径
    ///   - leftBottom: 左下方圆角半径
    ///   - rightBottom: 右下方圆角半径
    ///   - rightTop: 右上方圆角半径
    ///   - borderColor: default = .clear, border color
    ///   - borderWidth: default = 0, border width
    ///   - lineDashPattern: default = nil, 虚线中实线部分和间隔部分分别的长度，默认是实线的
    public func addMaskLayerCornerRadius(leftTop: CGFloat, leftBottom: CGFloat, rightBottom: CGFloat, rightTop: CGFloat, borderColor: UIColor = .clear, borderWidth: CGFloat = 0, lineDashPattern: [NSNumber]? = nil) {

        base.layoutIfNeeded()

        let bezier = UIBezierPath.init()
        bezier.lineWidth = borderWidth

        borderColor.setStroke()

        let width = base.frame.size.width
        let height = base.frame.size.height

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

        let maskLayer = CAShapeLayer()
        maskLayer.frame = base.bounds
        maskLayer.lineDashPattern = lineDashPattern

        maskLayer.path = bezier.cgPath
        base.layer.mask = maskLayer
    }

}
