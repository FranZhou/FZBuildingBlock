//
//  FZGradientView.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/6.
//

import Foundation

/// Displays a custom view of the gradient
open class FZGradientView: UIView {

    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }

    /// update view with horizontally gradient colors
    ///
    /// - Parameter colors: gradient colors
    @objc public func setHorizontallyGradient(with colors: [UIColor]) {
        setGradient(with: colors, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0))
    }

    /// update view with vertically gradient colors
    ///
    /// - Parameter colors: gradient colors
    @objc public func setVerticallyGradient(with colors: [UIColor]) {
        setGradient(with: colors, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
    }

    /// update view with gradient colors locations startPoint endPoint
    ///
    /// - Parameters:
    ///   - colors: gradient colors
    ///   - locations: gradient color segmentation point, default nil
    ///   - startPoint: gradient startPoint, [0,0] is the bottom-left corner of the layer, [1,1] is the top-right corner.
    ///   - endPoint: gradient endPoint, [0,0] is the bottom-left corner of the layer, [1,1] is the top-right corner.
    @objc public func setGradient(with colors: [UIColor], locations: [NSNumber]? = nil, startPoint: CGPoint, endPoint: CGPoint) {

        let cgColors = colors.map { (color) -> CGColor in
            return color.cgColor
        }

        if let gradientLayer = self.layer as? CAGradientLayer {
            gradientLayer.colors = cgColors
            gradientLayer.locations = locations
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
        }

    }

}
