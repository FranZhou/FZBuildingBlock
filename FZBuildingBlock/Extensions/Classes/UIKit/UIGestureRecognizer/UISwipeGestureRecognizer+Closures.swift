//
//  UISwipeGestureRecognizer+Closures.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/16.
//

import Foundation

extension UISwipeGestureRecognizer.fz {

    /// create UISwipeGestureRecognizer
    ///
    /// - Parameters:
    ///   - numberOfTouchesRequired: default is 1. the number of fingers that must swipe
    ///   - direction: default is UISwipeGestureRecognizerDirectionRight. the desired direction of the swipe. multiple directions may be specified if they will result in the same behavior (for example, UITableView swipe delete)
    ///   - closure: handler closure
    /// - Returns: UISwipeGestureRecognizer
    public static func swipeGesture(numberOfTouchesRequired: Int = 1, direction: UISwipeGestureRecognizer.Direction = .right, closure: @escaping ((UISwipeGestureRecognizer) -> Void)) -> UISwipeGestureRecognizer {
        // create handler
        let handler = FZUIGestureRecognizerClosureHandler<UISwipeGestureRecognizer>(closure: closure)

        // create gestures
        let gesture = UISwipeGestureRecognizer(target: handler, action: #selector(handler.handle))
        gesture.numberOfTouchesRequired = numberOfTouchesRequired
        gesture.direction = direction

        // weak hold
        handler.sender = gesture

        // gestures hold handler，avoid release early
        gesture.fz.setGestureRecognizerHandler(handler: handler)

        // return gestures
        return gesture
    }

}
