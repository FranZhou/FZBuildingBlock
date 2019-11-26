//
//  UITapGestureRecognizer+Closures.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/16.
//

import Foundation

extension UITapGestureRecognizer.fz {

    /// create UITapGestureRecognizer
    ///
    /// - Parameters:
    ///   - numberOfTapsRequired: Default is 1. The number of taps required to match
    ///   - numberOfTouchesRequired: Default is 1. The number of fingers required to match
    ///   - closure: handler closure
    /// - Returns: UITapGestureRecognizer
    public static func tapGesture(numberOfTapsRequired: Int = 1, numberOfTouchesRequired: Int = 1, closure: @escaping ((UITapGestureRecognizer) -> Void)) -> UITapGestureRecognizer {
        // create handler
        let handler = FZUIGestureRecognizerClosureHandler<UITapGestureRecognizer>(closure: closure)

        // create gestures
        let gesture = UITapGestureRecognizer(target: handler, action: #selector(handler.handle))
        gesture.numberOfTapsRequired = numberOfTapsRequired
        gesture.numberOfTouchesRequired = numberOfTouchesRequired

        // weak hold
        handler.sender = gesture

        // gestures hold handler，avoid release early
        gesture.fz.setGestureRecognizerHandler(handler: handler)

        // return gestures
        return gesture
    }

}
