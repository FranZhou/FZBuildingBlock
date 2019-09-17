//
//  FZGradientButton.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/9.
//

import Foundation

/// Displays a custom button of the gradient
open class FZGradientButton: UIButton {

    fileprivate typealias FZButtonStateGradient = (colors: [UIColor], locations: [NSNumber]?, startPoint: CGPoint, endPoint: CGPoint)

    fileprivate var stateColors: [UIControl.State.RawValue: FZButtonStateGradient] = [:]

    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }

}

extension FZGradientButton {

    open override func layoutSubviews() {
        super.layoutSubviews()

        let state = self.state

        if let stateGradient = stateColors[state.rawValue] {
            setStateGradient(with: stateGradient)
        }
    }

    fileprivate func setStateGradient(with stateGradient: FZButtonStateGradient) {

        let cgColors = stateGradient.colors.map { (color) -> CGColor in
            return color.cgColor
        }

        if let gradientLayer = self.layer as? CAGradientLayer {
            gradientLayer.colors = cgColors
            gradientLayer.locations = stateGradient.locations
            gradientLayer.startPoint = stateGradient.startPoint
            gradientLayer.endPoint = stateGradient.endPoint
        }

    }

}

extension FZGradientButton {

    /// update button with horizontally gradient colors for state
    ///
    /// - Parameters:
    ///   - colors: gradient colors
    ///   - state: UIControl State, default is UIControl.State.normal
    @objc public func setHorizontallyGradient(with colors: [UIColor], for state: UIControl.State = .normal) {
        setGradient(with: colors, locations: nil, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0), for: state)
    }

    /// update button with vertically gradient colors for state
    ///
    /// - Parameters:
    ///   - colors: gradient colors
    ///   - state: UIControl State, default is UIControl.State.normal
    @objc public func setVerticallyGradient(with colors: [UIColor], for state: UIControl.State = .normal) {
        setGradient(with: colors, locations: nil, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1), for: state)
    }

    /// update button with gradient colors locations startPoint endPoint for state
    ///
    /// - Parameters:
    ///   - colors: gradient colors
    ///   - locations: gradient locations
    ///   - startPoint: gradient startPoint
    ///   - endPoint: gradient endPoint
    ///   - state: UIControl State
    @objc public func setGradient(with colors: [UIColor], locations: [NSNumber]? = nil, startPoint: CGPoint, endPoint: CGPoint, for state: UIControl.State) {

        stateColors[state.rawValue] = FZButtonStateGradient(colors: colors, locations: locations, startPoint: startPoint, endPoint: endPoint)

    }
}
