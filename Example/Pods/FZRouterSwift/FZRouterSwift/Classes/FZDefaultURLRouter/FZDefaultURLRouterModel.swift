//
//  FZDefaultURLRouterModel.swift
//  FZRouterSwift
//
//  Created by FranZhou on 2020/8/4.
//

import Foundation

/// FZRouter Info Model
open class FZDefaultURLRouterModel: NSObject, FZRouterModelProtocol {

    public let routerKey: String
    public var target: AnyObject?
    public var selector: Selector?
    public var targetActionBlock: FZRouterModelTargetActionBlock?

    /// FZRouterModel
    ///
    /// - Parameters:
    ///   - routerKey:  suggest scheme://host/serverPath/method
    ///   - target: router target
    ///   - selector: router selector

    /// FZRouterModel
    ///
    /// - Parameters:
    ///   - routerKey: suggest scheme://host/serverPath/method
    ///   - target:  router target
    ///   - selector: router selector
    ///   - targetActionBlock: router targetActionBlock
    @objc public init(routerKey: String, target: AnyObject? = nil, selector: Selector? = nil, targetActionBlock: FZRouterModelTargetActionBlock? = nil) {
        self.routerKey = routerKey
        self.target = target
        self.selector = selector
        self.targetActionBlock = targetActionBlock
        super.init()
    }

    public required init(routerKey: String) {
        self.routerKey = routerKey
        self.target = nil
        self.selector = nil
        self.targetActionBlock = nil
        super.init()
    }

    // MARK: -
    open override var hash: Int {
        return routerKey.hash
    }

    open override func isEqual(_ object: Any?) -> Bool {
        if let rhs = object as? FZDefaultURLRouterModel {
            return routerKey == rhs.routerKey
        }
        return false
    }

    static func == (lhs: FZDefaultURLRouterModel, rhs: FZDefaultURLRouterModel) -> Bool {
        return lhs.routerKey == rhs.routerKey
    }

}
