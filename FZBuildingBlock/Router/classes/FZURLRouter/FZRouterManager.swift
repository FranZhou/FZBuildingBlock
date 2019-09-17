//
//  FZRouterManager.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/31.
//

import UIKit

open class FZRouterManager: NSObject {

    @objc public static let defaultManager = FZRouterManager()

    private var routerMapper: [String: FZRouterModelProtocol] = [:]

}

extension FZRouterManager: FZRouterManagerProtocol {

    public func add(router: FZRouterModelProtocol) {
        routerMapper[router.routerKey] = router
    }

    public func add(routers: [FZRouterModelProtocol]) {
        routers.forEach { [weak self](routerModel: FZRouterModelProtocol) in
            guard let `self` = self
                else {
                    return
            }

            self.add(router: routerModel)
        }
    }

    public func remove(WithRouterURL url: String) -> FZRouterModelProtocol? {
        if let routerKey = FZRouterURLUtil.key(withRouterURL: url) {
            return routerMapper.removeValue(forKey: routerKey)
        }
        return nil
    }

    public func removeAllRouter() {
        routerMapper.removeAll()
    }

    public func router(WithRouterURL url: String) -> FZRouterModelProtocol? {
        if let routerKey = FZRouterURLUtil.key(withRouterURL: url) {
            return routerMapper[routerKey]
        }
        return nil
    }

    public func allRouters() -> [FZRouterModelProtocol]? {
        return routerMapper.map({ (keyValue: (key: String, value: FZRouterModelProtocol)) -> FZRouterModelProtocol in
            return keyValue.value
        })
    }

    public func change(WithRouterURL url: String, target: AnyObject, selector: Selector) -> FZRouterModelProtocol? {
        if let routerKey = FZRouterURLUtil.key(withRouterURL: url) {
            if let routerModel = routerMapper[routerKey] {
                routerModel.target = target
                routerModel.selector = selector

                self.add(router: routerModel)
                return routerModel
            } else {
                let routerModel = FZRouterModel(routerKey: routerKey, target: target, selector: selector)
                self.add(router: routerModel)

                return routerModel
            }
        }
        return nil
    }

}
