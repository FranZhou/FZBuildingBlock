//
//  UIPinchGestureRecognizer+Closures.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/16.
//

import Foundation

extension UIPinchGestureRecognizer.fz {

    /// create UIPinchGestureRecognizer
    ///
    /// - Parameters:
    ///   - scale: scale relative to the touch points in screen coordinates
    ///   - closure: handler closure
    /// - Returns: UIPinchGestureRecognizer
    public static func pinchGesture(scale: CGFloat? = nil, closure: @escaping ((UIPinchGestureRecognizer) -> Void)) -> UIPinchGestureRecognizer {
        // create handler
        let handler = FZUIGestureRecognizerClosureHandler<UIPinchGestureRecognizer>(closure: closure)

        // create gestures
        let gesture = UIPinchGestureRecognizer(target: handler, action: #selector(handler.handle))
        if let scale = scale {
            gesture.scale = scale
        }

        // weak hold
        handler.sender = gesture

        // gestures hold handler，avoid release early
        gesture.fz.setGestureRecognizerHandler(handler: handler)

        // return gestures
        return gesture
    }

}
