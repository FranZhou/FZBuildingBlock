//
//  UIView+Gesture.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/12.
//

import Foundation

// MARK: - Tap Gesture
extension FZBuildingBlockWrapper where Base: UIView {

    /// add UITapGestureRecognizer
    ///
    /// - Parameters:
    ///   - numberOfTapsRequired: Default is 1. The number of taps required to match
    ///   - numberOfTouchesRequired: Default is 1. The number of fingers required to match
    ///   - closure: handler closure
    /// - Returns: UITapGestureRecognizer
    @discardableResult
    public func onTap(numberOfTapsRequired: Int = 1, numberOfTouchesRequired: Int = 1, closure: @escaping (UITapGestureRecognizer) -> Void) -> UITapGestureRecognizer {

        let gesture = UITapGestureRecognizer.fz.tapGesture(numberOfTapsRequired: numberOfTapsRequired, numberOfTouchesRequired: numberOfTouchesRequired, closure: closure)

        base.addGestureRecognizer(gesture)

        return gesture
    }

    /// remove all UITapGestureRecognizer
    public func removeAllTapGesture() {
        if let gestureRecognizers = base.gestureRecognizers {
            let gestures = gestureRecognizers.filter { (gesture: UIGestureRecognizer) -> Bool in
                return gesture is UITapGestureRecognizer
            }

            for gesture in gestures {
                if let gesture = gesture as? UITapGestureRecognizer {
                    removeTapGesture(gesture)
                }
            }
        }
    }

    /// remove UITapGestureRecognizer
    ///
    /// - Parameter gesture: UITapGestureRecognizer to remove
    public func removeTapGesture(_ gesture: UITapGestureRecognizer) {
        base.removeGestureRecognizer(gesture)
    }

}

// MARK: - LongPress Gesture
extension FZBuildingBlockWrapper where Base: UIView {

    /// add UILongPressGestureRecognizer
    ///
    /// - Parameters:
    ///   - numberOfTapsRequired: Default is 0. The number of full taps required before the press for gesture to be recognized
    ///   - numberOfTouchesRequired: Default is 1. Number of fingers that must be held down for the gesture to be recognized
    ///   - minimumPressDuration: Default is 0.5. Time in seconds the fingers must be held down for the gesture to be recognized
    ///   - allowableMovement: Default is 10. Maximum movement in pixels allowed before the gesture fails. Once recognized (after minimumPressDuration) there is no limit on finger movement for the remainder of the touch tracking
    ///   - closure: handler closure
    /// - Returns: UILongPressGestureRecognizer
    @discardableResult
    public func onLongPress(numberOfTapsRequired: Int = 0, numberOfTouchesRequired: Int = 1, minimumPressDuration: TimeInterval = 0.5, allowableMovement: CGFloat = 10, closure: @escaping (UILongPressGestureRecognizer) -> Void) -> UILongPressGestureRecognizer {

        let gesture = UILongPressGestureRecognizer.fz.longPressGesture(numberOfTapsRequired: numberOfTapsRequired, numberOfTouchesRequired: numberOfTouchesRequired, minimumPressDuration: minimumPressDuration, allowableMovement: allowableMovement, closure: closure)

        base.addGestureRecognizer(gesture)

        return gesture
    }

    /// remove all UILongPressGestureRecognizer
    public func removeAllLongPressGesture() {
        if let gestureRecognizers = base.gestureRecognizers {
            let gestures = gestureRecognizers.filter { (gesture: UIGestureRecognizer) -> Bool in
                return gesture is UILongPressGestureRecognizer
            }

            for gesture in gestures {
                if let gesture = gesture as? UILongPressGestureRecognizer {
                    removeLongPressGesture(gesture)
                }
            }
        }
    }

    /// remove UILongPressGestureRecognizer
    ///
    /// - Parameter gesture: UILongPressGestureRecognizer to remove
    public func removeLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        base.removeGestureRecognizer(gesture)
    }

}

// MARK: - Swipe Gesture
extension FZBuildingBlockWrapper where Base: UIView {

    /// add UISwipeGestureRecognizer
    ///
    /// - Parameters:
    ///   - numberOfTouchesRequired: default is 1. the number of fingers that must swipe
    ///   - direction: default is UISwipeGestureRecognizerDirectionRight. the desired direction of the swipe. multiple directions may be specified if they will result in the same behavior (for example, UITableView swipe delete)
    ///   - closure: handler closure
    /// - Returns: UISwipeGestureRecognizer
    @discardableResult
    public func onSwipe(numberOfTouchesRequired: Int = 1, direction: UISwipeGestureRecognizer.Direction = .right, closure: @escaping (UISwipeGestureRecognizer) -> Void) -> UISwipeGestureRecognizer {

        let gesture = UISwipeGestureRecognizer.fz.swipeGesture(numberOfTouchesRequired: numberOfTouchesRequired, direction: direction, closure: closure)

        base.addGestureRecognizer(gesture)

        return gesture
    }

    /// remove all UISwipeGestureRecognizer
    public func removeAllSwipeGesture() {
        if let gestureRecognizers = base.gestureRecognizers {
            let gestures = gestureRecognizers.filter { (gesture: UIGestureRecognizer) -> Bool in
                return gesture is UISwipeGestureRecognizer
            }

            for gesture in gestures {
                if let gesture = gesture as? UISwipeGestureRecognizer {
                    removeSwipeGesture(gesture)
                }
            }
        }
    }

    /// remove UISwipeGestureRecognizer
    ///
    /// - Parameter gesture: UISwipeGestureRecognizer to remove
    public func removeSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        base.removeGestureRecognizer(gesture)
    }
}

// MARK: - Pan Gesture
extension FZBuildingBlockWrapper where Base: UIView {

    /// add UIPanGestureRecognizer
    ///
    /// - Parameters:
    ///   - minimumNumberOfTouches: default is 1. the minimum number of touches required to match
    ///   - maximumNumberOfTouches: default is INT_MAX. the maximum number of touches that can be down
    ///   - closure: handler closure
    /// - Returns: UIPanGestureRecognizer
    @discardableResult
    public func panGesture(minimumNumberOfTouches: Int = 1, maximumNumberOfTouches: Int = Int.max, closure: @escaping (UIPanGestureRecognizer) -> Void) -> UIPanGestureRecognizer {

        let gesture = UIPanGestureRecognizer.fz.panGesture(minimumNumberOfTouches: minimumNumberOfTouches, maximumNumberOfTouches: maximumNumberOfTouches, closure: closure)

        base.addGestureRecognizer(gesture)

        return gesture
    }

    /// remove all UIPanGestureRecognizer
    public func removeAllPanGesture() {
        if let gestureRecognizers = base.gestureRecognizers {
            let gestures = gestureRecognizers.filter { (gesture: UIGestureRecognizer) -> Bool in
                return gesture is UIPanGestureRecognizer
            }

            for gesture in gestures {
                if let gesture = gesture as? UIPanGestureRecognizer {
                    removePanGesture(gesture)
                }
            }
        }
    }

    /// remove UIPanGestureRecognizer
    ///
    /// - Parameter gesture: UIPanGestureRecognizer to remove
    public func removePanGesture(_ gesture: UIPanGestureRecognizer) {
        base.removeGestureRecognizer(gesture)
    }
}

// MARK: - Pinch Gesture
extension FZBuildingBlockWrapper where Base: UIView {

    /// add UIPinchGestureRecognizer
    ///
    /// - Parameters:
    ///   - scale: scale relative to the touch points in screen coordinates
    ///   - closure: handler closure
    /// - Returns: UIPinchGestureRecognizer
    @discardableResult
    public func pinchGesture(scale: CGFloat? = nil, closure: @escaping (UIPinchGestureRecognizer) -> Void) -> UIPinchGestureRecognizer {

        let gesture = UIPinchGestureRecognizer.fz.pinchGesture(scale: scale, closure: closure)

        base.addGestureRecognizer(gesture)

        return gesture
    }

    /// remove all UIPinchGestureRecognizer
    public func removeAllPinchGesture() {
        if let gestureRecognizers = base.gestureRecognizers {
            let gestures = gestureRecognizers.filter { (gesture: UIGestureRecognizer) -> Bool in
                return gesture is UIPinchGestureRecognizer
            }

            for gesture in gestures {
                if let gesture = gesture as? UIPinchGestureRecognizer {
                    removePinchGesture(gesture)
                }
            }
        }
    }

    /// remove UIPinchGestureRecognizer
    ///
    /// - Parameter gesture: UIPinchGestureRecognizer to remove
    public func removePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        base.removeGestureRecognizer(gesture)
    }
}

// MARK: - Rotation Gesture
extension FZBuildingBlockWrapper where Base: UIView {

    /// add UIRotationGestureRecognizer
    ///
    /// - Parameters:
    ///   - rotation: rotation in radians
    ///   - closure: handler closure
    /// - Returns: UIRotationGestureRecognizer
    @discardableResult
    public func rotationGesture(rotation: CGFloat? = nil, closure: @escaping (UIRotationGestureRecognizer) -> Void) -> UIRotationGestureRecognizer {

        let gesture = UIRotationGestureRecognizer.fz.rotationGesture(rotation: rotation, closure: closure)

        base.addGestureRecognizer(gesture)

        return gesture
    }

    /// remove all UIRotationGestureRecognizer
    public func removeAllRotationGesture() {
        if let gestureRecognizers = base.gestureRecognizers {
            let gestures = gestureRecognizers.filter { (gesture: UIGestureRecognizer) -> Bool in
                return gesture is UIRotationGestureRecognizer
            }

            for gesture in gestures {
                if let gesture = gesture as? UIRotationGestureRecognizer {
                    removeRotationGesture(gesture)
                }
            }
        }
    }

    /// remove UIRotationGestureRecognizer
    ///
    /// - Parameter gesture: UIRotationGestureRecognizer to remove
    public func removeRotationGesture(_ gesture: UIRotationGestureRecognizer) {
        base.removeGestureRecognizer(gesture)
    }
}

// MARK: - ScreenEdgePan Gesture
extension FZBuildingBlockWrapper where Base: UIView {

    /// add UIScreenEdgePanGestureRecognizer
    ///
    /// - Parameters:
    ///   - edges: the edges on which this gesture recognizes, relative to the current interface orientation
    ///   - closure: handler closure
    /// - Returns: UIScreenEdgePanGestureRecognizer
    @discardableResult
    public func screenEdgePanGesture(edges: UIRectEdge? = nil, closure: @escaping (UIScreenEdgePanGestureRecognizer) -> Void) -> UIScreenEdgePanGestureRecognizer {

        let gesture = UIScreenEdgePanGestureRecognizer.fz.screenEdgePanGesture(edges: edges, closure: closure)

        base.addGestureRecognizer(gesture)

        return gesture
    }

    /// remove all UIScreenEdgePanGestureRecognizer
    public func removeAllScreenEdgePanGesture() {
        if let gestureRecognizers = base.gestureRecognizers {
            let gestures = gestureRecognizers.filter { (gesture: UIGestureRecognizer) -> Bool in
                return gesture is UIScreenEdgePanGestureRecognizer
            }

            for gesture in gestures {
                if let gesture = gesture as? UIScreenEdgePanGestureRecognizer {
                    removeScreenEdgePanGesture(gesture)
                }
            }
        }
    }

    /// remove UIScreenEdgePanGestureRecognizer
    ///
    /// - Parameter gesture: UIScreenEdgePanGestureRecognizer to remove
    public func removeScreenEdgePanGesture(_ gesture: UIScreenEdgePanGestureRecognizer) {
        base.removeGestureRecognizer(gesture)
    }
}
