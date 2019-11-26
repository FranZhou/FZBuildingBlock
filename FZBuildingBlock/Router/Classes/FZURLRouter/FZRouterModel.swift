//
//  FZRouterModel.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/31.
//

import UIKit

/// FZRouter Info Model
open class FZRouterModel: NSObject, FZRouterModelProtocol {

    public let routerKey: String
    public var target: AnyObject
    public var selector: Selector

    /// FZRouterModel
    ///
    /// - Parameters:
    ///   - routerKey:  suggest scheme://host/serverPath/method
    ///   - target: router target
    ///   - selector: router selector
    @objc public init(routerKey: String, target: AnyObject, selector: Selector) {
        self.routerKey = routerKey
        self.target = target
        self.selector = selector
    }

    // MARK: -
    open override var hash: Int {
        return routerKey.hash
    }

    open override func isEqual(_ object: Any?) -> Bool {
        if let rhs = object as? FZRouterModel {
            return routerKey == rhs.routerKey
        }
        return false
    }

    static func == (lhs: FZRouterModel, rhs: FZRouterModel) -> Bool {
        return lhs.routerKey == rhs.routerKey
    }

}
