//
//  UIView+BorderLine.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/25.
//

import Foundation


/// 边框位置结构体，定位边框位置可以通过位移来确定
public struct FZViewBorderLineSideType: OptionSet {
    
    public typealias RawValue = Int
    
    public var rawValue: RawValue
    
    public init(rawValue: FZViewBorderLineSideType.RawValue) {
        self.rawValue = rawValue
    }
    
    public mutating func formUnion(_ other: FZViewBorderLineSideType) {
        self = FZViewBorderLineSideType(rawValue: self.rawValue | other.rawValue)
    }
    
    public mutating func formIntersection(_ other: FZViewBorderLineSideType) {
        self = FZViewBorderLineSideType(rawValue: self.rawValue & other.rawValue)
    }
    
    public mutating func formSymmetricDifference(_ other: FZViewBorderLineSideType) {
        self = FZViewBorderLineSideType(rawValue: self.rawValue ^ other.rawValue)
    }
    
    
    public static let top: FZViewBorderLineSideType = FZViewBorderLineSideType(rawValue: 1 << 0)
    public static let left: FZViewBorderLineSideType = FZViewBorderLineSideType(rawValue: 1 << 1)
    public static let bottom: FZViewBorderLineSideType = FZViewBorderLineSideType(rawValue: 1 << 2)
    public static let right: FZViewBorderLineSideType = FZViewBorderLineSideType(rawValue: 1 << 3)
    
}

extension UIView {
    
    
    /// top border line layer name
    fileprivate var fz_topBorderLineLayerName: String {
        get{
            return "fz_topBorderLineLayer"
        }
    }
    
    /// left border line layer name
    fileprivate var fz_leftBorderLineLayerName: String {
        get{
            return "fz_leftBorderLineLayer"
        }
    }
    
    /// bottom border line layer name
    fileprivate var fz_bottomBorderLineLayerName: String {
        get{
            return "fz_bottomBorderLineLayer"
        }
    }
    
    /// right border line layer name
    fileprivate var fz_rightBorderLineLayerName: String {
        get{
            return "fz_rightBorderLineLayer"
        }
    }
    
    
    /// 根据name获取layer
    ///
    /// - Parameter name: layer's name
    /// - Returns: layer
    fileprivate func fz_getLayer(byName name: String) -> CALayer? {
        return self.layer.sublayers?.filter({ (sublayer: CALayer) -> Bool in
            guard let sublayerName = sublayer.name else{
                return false
            }
            return sublayerName == name
        }).first
    }
    
    
    
    /// 获取 BorderLine的 CAShaperLayer绘制CGPath
    ///
    /// - Parameters:
    ///   - fromPoint: 起点
    ///   - toPoint: 终点
    /// - Returns:
    fileprivate func fz_getBorderLinePath(from fromPoint: CGPoint, to toPoint: CGPoint) -> CGPath {
        
        // 避免报错
        // [Unknown process name] CGContextDrawPath: invalid context 0x0. If you want to see the backtrace, please set CG_CONTEXT_SHOW_BACKTRACE environmental variable.
        
        // 因为绘图不在drawRect:方法中操作导致绘图时没有当前的图形上下文(context)可设置。所以应该在drawRect:中执行图形绘制。
        // 或者使用 UIGraphicsBeginImageContextWithOptions
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, UIScreen.main.scale)
        
        let bezier = UIBezierPath()
        
        bezier.move(to: fromPoint)
        bezier.addLine(to: toPoint)
        
        UIGraphicsEndImageContext()
        
        return bezier.cgPath
    }
    
    
    /// 拿到指定name的CAShapeLayer，根据指定的path进行绘制
    ///
    /// - Parameters:
    ///   - name: layer's name
    ///   - path: path
    ///   - lineWith: lineWith
    ///   - lineColor: lineColor, layer的fillColor和strokeColor
    ///   - lineDashPattern: default = nil, 虚线中实线部分和间隔部分分别的长度，默认是实线的
    public func fz_addBorderLineLayer(layerName name: String, path: CGPath, lineWith: CGFloat, lineColor: UIColor, lineDashPattern: [NSNumber]? = nil) {
        
        // 根据name能找到layer
        if let layer = self.fz_getLayer(byName: name) {
            // layer类型是CAShapeLayer
            if let shapeLayer = layer as? CAShapeLayer{
                shapeLayer.path = path
                shapeLayer.fillColor = lineColor.cgColor
                shapeLayer.strokeColor = lineColor.cgColor
                shapeLayer.lineWidth = lineWith
                shapeLayer.lineDashPattern = lineDashPattern

                return
            } else {
                // layer类型不是CAShapeLayer
                layer.removeFromSuperlayer()
            }
        }
        
        // 根据name找不到相应的layer
        // 或者根据name找到的layer不是CAShapeLayer类型都会走到这里
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = name
        shapeLayer.path = path
        shapeLayer.fillColor = lineColor.cgColor
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWith
        shapeLayer.lineDashPattern = lineDashPattern
        
        self.layer.addSublayer(shapeLayer)
    }
    
    
    /// 移除指定name的layer
    ///
    /// - Parameter name: layer's name
    public func fz_removeSublayer(byName name: String) {
        self.fz_getLayer(byName: name)?.removeFromSuperlayer()
    }
    
    
    /// 添加指定边框
    ///
    /// - Parameters:
    ///   - lineSides: 添加边框位置, like [.top, .left, .bottom, .right] or .top
    ///   - lineWidth: 边框宽度
    ///   - lineColor: 边框颜色
    ///   - lineDashPattern: default = nil, 虚线中实线部分和间隔部分分别的长度，默认是实线的
    public func fz_addBorderLine(lineSides: FZViewBorderLineSideType, lineWidth: CGFloat, lineColor: UIColor, lineDashPattern: [NSNumber]? = nil) {
        let rect = self.bounds
        
        // 要根据线的宽度计算线的起点终点位置
        // 假设线的宽度是10， 要（0，0）~（100，10）添加一条边框
        // 绘制的位置应该是  (0, 5) ~ (100, 5), 然后设置 CAShapLayer 的 lineWidth = 10
        let halfLine = lineWidth/2.0
        
        // add top border line
        if lineSides.contains(.top){
            let path = self.fz_getBorderLinePath(from: CGPoint(x: 0, y: halfLine), to: CGPoint(x: rect.size.width, y: halfLine))
            self.fz_addBorderLineLayer(layerName: self.fz_topBorderLineLayerName, path: path, lineWith: lineWidth, lineColor: lineColor, lineDashPattern: lineDashPattern)
        }
        
        // add left border line
        if lineSides.contains(.left){
            let path = self.fz_getBorderLinePath(from: CGPoint(x: halfLine, y: 0), to: CGPoint(x:halfLine, y: rect.size.height))
            self.fz_addBorderLineLayer(layerName: self.fz_leftBorderLineLayerName, path: path, lineWith: lineWidth, lineColor: lineColor, lineDashPattern: lineDashPattern)
        }
        
        // add bottom border line
        if lineSides.contains(.bottom){
            let path = self.fz_getBorderLinePath(from: CGPoint(x: 0, y: rect.size.height-halfLine), to: CGPoint(x: rect.size.width, y: rect.size.height-halfLine))
            self.fz_addBorderLineLayer(layerName: self.fz_bottomBorderLineLayerName, path: path, lineWith: lineWidth, lineColor: lineColor, lineDashPattern: lineDashPattern)
        }
        
        // add right border line
        if lineSides.contains(.right){
            let path = self.fz_getBorderLinePath(from: CGPoint(x: rect.size.width-halfLine, y: 0), to: CGPoint(x: rect.size.width-halfLine, y: rect.size.height))
            self.fz_addBorderLineLayer(layerName: self.fz_rightBorderLineLayerName, path: path, lineWith: lineWidth, lineColor: lineColor, lineDashPattern: lineDashPattern)
        }
        
    }
    
    
    /// 移除指定边框
    ///
    /// - Parameter lineSides: 移除边框位置， like [.top, .left, .bottom, .right] or .top
    public func fz_removeBorderLine(lineSides: FZViewBorderLineSideType) -> Void {
        
        // remove top border line
        if lineSides.contains(.top){
            self.fz_removeSublayer(byName: self.fz_topBorderLineLayerName)
        }
        
        // remove left border line
        if lineSides.contains(.left){
            self.fz_removeSublayer(byName: self.fz_leftBorderLineLayerName)
        }
        
        // remove bottom border line
        if lineSides.contains(.bottom){
            self.fz_removeSublayer(byName: self.fz_bottomBorderLineLayerName)
        }
        
        // remove right border line
        if lineSides.contains(.right){
            self.fz_removeSublayer(byName: self.fz_rightBorderLineLayerName)
        }
    }
    
    
}
