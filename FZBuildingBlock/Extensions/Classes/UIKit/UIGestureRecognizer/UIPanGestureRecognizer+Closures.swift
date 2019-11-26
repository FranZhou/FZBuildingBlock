//
//  UIPanGestureRecognizer+Closures.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/16.
//

import Foundation

extension UIPanGestureRecognizer.fz {

    /// create UIPanGestureRecognizer
    ///
    /// - Parameters:
    ///   - minimumNumberOfTouches: default is 1. the minimum number of touches required to match
    ///   - maximumNumberOfTouches: default is INT_MAX. the maximum number of touches that can be down
    ///   - closure: handler closure
    /// - Returns: UIPanGestureRecognizer
    public static func panGesture(minimumNumberOfTouches: Int = 1, maximumNumberOfTouches: Int = Int.max, closure: @escaping ((UIPanGestureRecognizer) -> Void)) -> UIPanGestureRecognizer {
        // create handler
        let handler = FZUIGestureRecognizerClosureHandler<UIPanGestureRecognizer>(closure: closure)

        // create gestures
        let gesture = UIPanGestureRecognizer(target: handler, action: #selector(handler.handle))
        gesture.minimumNumberOfTouches = minimumNumberOfTouches
        gesture.maximumNumberOfTouches = maximumNumberOfTouches

        // weak hold
        handler.sender = gesture

        // gestures hold handler，avoid release early
        gesture.fz.setGestureRecognizerHandler(handler: handler)

        // return gestures
        return gesture
    }

}
