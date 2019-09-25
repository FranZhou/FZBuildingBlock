//
//  UIScreenEdgePanGestureRecognizer+Closures.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/16.
//

import Foundation

extension UIScreenEdgePanGestureRecognizer.fz {

    /// create UIScreenEdgePanGestureRecognizer
    ///
    /// - Parameters:
    ///   - edges: the edges on which this gesture recognizes, relative to the current interface orientation
    ///   - closure: handler closure
    /// - Returns: UIScreenEdgePanGestureRecognizer
    public static func screenEdgePanGesture(edges: UIRectEdge? = nil, closure: @escaping ((UIScreenEdgePanGestureRecognizer) -> Void)) -> UIScreenEdgePanGestureRecognizer {
        // create handler
        let handler = FZUIGestureRecognizerClosureHandler<UIScreenEdgePanGestureRecognizer>(closure: closure)

        // create gestures
        let gesture = UIScreenEdgePanGestureRecognizer(target: handler, action: #selector(handler.handle))
        if let edges = edges {
            gesture.edges = edges
        }

        // weak hold
        handler.sender = gesture

        // gestures hold handler，avoid release early
        gesture.fz.setGestureRecognizerHandler(handler: handler)

        // return gestures
        return gesture
    }

}
