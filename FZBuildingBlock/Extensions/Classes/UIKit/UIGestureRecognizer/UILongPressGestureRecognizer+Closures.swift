//
//  UILongPressGestureRecognizer+Closures.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/16.
//

import Foundation

extension UILongPressGestureRecognizer.fz {

    /// create UILongPressGestureRecognizer
    ///
    /// - Parameters:
    ///   - numberOfTapsRequired: Default is 0. The number of full taps required before the press for gesture to be recognized
    ///   - numberOfTouchesRequired: Default is 1. Number of fingers that must be held down for the gesture to be recognized
    ///   - minimumPressDuration: Default is 0.5. Time in seconds the fingers must be held down for the gesture to be recognized
    ///   - allowableMovement: Default is 10. Maximum movement in pixels allowed before the gesture fails. Once recognized (after minimumPressDuration) there is no limit on finger movement for the remainder of the touch tracking
    ///   - closure: handler closure
    /// - Returns: UILongPressGestureRecognizer 
    public static func longPressGesture(numberOfTapsRequired: Int = 0, numberOfTouchesRequired: Int = 1, minimumPressDuration: TimeInterval = 0.5, allowableMovement: CGFloat = 10, closure: @escaping ((UILongPressGestureRecognizer) -> Void)) -> UILongPressGestureRecognizer {
        // create handler
        let handler = FZUIGestureRecognizerClosureHandler<UILongPressGestureRecognizer>(closure: closure)

        // create gestures
        let gesture = UILongPressGestureRecognizer(target: handler, action: #selector(handler.handle))
        gesture.numberOfTapsRequired = numberOfTapsRequired
        gesture.numberOfTouchesRequired = numberOfTouchesRequired
        gesture.minimumPressDuration = minimumPressDuration
        gesture.allowableMovement = allowableMovement

        // weak hold
        handler.sender = gesture

        // gestures hold handler，avoid release early
        gesture.fz.setGestureRecognizerHandler(handler: handler)

        // return gestures
        return gesture
    }

}
