//
//  UINavigationItem+Indicator.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/29.
//

import Foundation

private struct FZUINavigationItemIndicatorAssociatedKey {
    static var positionAssociatedKeys: UnsafeRawPointer = UnsafeRawPointer(bitPattern: "FZUINavigationItemIndicatorAssociatedKey_positionAssociatedKeys".hashValue)!

    static var itemsAssociatedKeys: UnsafeRawPointer = UnsafeRawPointer(bitPattern: "FZUINavigationItemIndicatorAssociatedKey_itemsAssociatedKeys".hashValue)!

    static var titleAssociatedKeys: UnsafeRawPointer = UnsafeRawPointer(bitPattern: "FZUINavigationItemIndicatorAssociatedKey_titleAssociatedKeys".hashValue)!
}

extension FZBuildingBlockWrapper where Base: UINavigationItem {

    public enum FZUINavigationItemIndicatorPosition: UInt8 {
        case left = 0
        case center
        case right
    }

    /// indicator position
    fileprivate var indicatorPosition: FZUINavigationItemIndicatorPosition? {
        get {
            if let position = objc_getAssociatedObject(base, FZUINavigationItemIndicatorAssociatedKey.positionAssociatedKeys) as? FZUINavigationItemIndicatorPosition {
                return position
            }
            return nil
        }
        set {
            objc_setAssociatedObject(base, FZUINavigationItemIndicatorAssociatedKey.positionAssociatedKeys, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// when indicator position is left or right，keep leftBarButtonItems or rightBarButtonItems
    fileprivate var positionItmes: [UIBarButtonItem]? {
        get {
            if let items = objc_getAssociatedObject(base, FZUINavigationItemIndicatorAssociatedKey.itemsAssociatedKeys) as? [UIBarButtonItem] {
                return items
            }
            return nil
        }
        set {
            objc_setAssociatedObject(base, FZUINavigationItemIndicatorAssociatedKey.itemsAssociatedKeys, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    // when indicator position is center, keep (title, titleView)
    fileprivate var positionCenterTitle:(title: String?, titleView: UIView?)? {
        get {
            if let title = objc_getAssociatedObject(base, FZUINavigationItemIndicatorAssociatedKey.titleAssociatedKeys) as? (title: String?, titleView: UIView?) {
                return title
            }
            return nil
        }
        set {
            objc_setAssociatedObject(base, FZUINavigationItemIndicatorAssociatedKey.titleAssociatedKeys, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// show indicator
    /// at the same time，just one indicator showed on UINavigationItem
    ///
    /// - Parameters:
    ///   - position: position
    ///   - style: indicator style, default = .white
    public mutating func showIndicator(position: FZUINavigationItemIndicatorPosition, style: UIActivityIndicatorView.Style = .white) {

        // reset UINavigationItem
        hideIndicator()

        indicatorPosition = position
        let indicator = UIActivityIndicatorView(style: style)

        switch position {
        case .left:
            positionItmes = base.leftBarButtonItems
            base.leftBarButtonItem = UIBarButtonItem(customView: indicator)
        case .center:
            positionCenterTitle = (base.title, base.titleView)
            base.title = nil
            base.titleView = indicator
        case .right:
            positionItmes = base.rightBarButtonItems
            base.rightBarButtonItem = UIBarButtonItem(customView: indicator)
        }

        indicator.startAnimating()
    }

    /// hide indicator
    /// at the same time，just one indicator showed on UINavigationItem
    public mutating func hideIndicator() {
        // reset origin
        if let position = indicatorPosition {
            let items = positionItmes
            let title = positionCenterTitle

            switch position {
            case .left:
                // remove indicator
                base.setLeftBarButtonItems(nil, animated: false)
                // set origin leftBarButtonItems
                base.setLeftBarButtonItems(items, animated: false)
            case .center:
                // remove indicator
                base.title = nil
                base.titleView = nil
                // set origin title titleView
                base.title = title?.title
                base.titleView = title?.titleView
                break
            case .right:
                // remove indicator
                base.setRightBarButtonItems(nil, animated: false)
                // set origin leftBarButtonItems
                base.setRightBarButtonItems(items, animated: false)
            }
        }

        // clear stored data
        indicatorPosition = nil
        positionItmes = nil
        positionCenterTitle = nil
    }

}
