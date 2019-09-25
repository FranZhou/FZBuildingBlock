//
//  UIRotationGestureRecognizer+Closures.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/16.
//

import Foundation

extension UIRotationGestureRecognizer.fz {

    /// create UIRotationGestureRecognizer
    ///
    /// - Parameters:
    ///   - rotation: rotation in radians
    ///   - closure: handler closure
    /// - Returns: UIRotationGestureRecognizer
    public static func rotationGesture(rotation: CGFloat? = nil, closure: @escaping ((UIRotationGestureRecognizer) -> Void)) -> UIRotationGestureRecognizer {
        // create handler
        let handler = FZUIGestureRecognizerClosureHandler<UIRotationGestureRecognizer>(closure: closure)

        // create gestures
        let gesture = UIRotationGestureRecognizer(target: handler, action: #selector(handler.handle))
        if let rotation = rotation {
            gesture.rotation = rotation
        }

        // weak hold
        handler.sender = gesture

        // gestures hold handler，avoid release early
        gesture.fz.setGestureRecognizerHandler(handler: handler)

        // return gestures
        return gesture
    }

}
