//
//  FZDefaultURLRouterManager.swift
//  FZRouterSwift
//
//  Created by FranZhou on 2020/8/4.
//

import Foundation

open class FZDefaultURLRouterManager: NSObject {

    @objc public static let defaultManager = FZDefaultURLRouterManager()

    private var routerMapper: [String: FZRouterModelProtocol] = [:]

}

extension FZDefaultURLRouterManager: FZRouterManagerProtocol {

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

    public func remove(withRouterURL url: String) -> FZRouterModelProtocol? {
        if let routerKey = FZDefaultURLRouterUtil.key(withRouterURL: url) {
            return routerMapper.removeValue(forKey: routerKey)
        }
        return nil
    }

    public func removeAllRouter() {
        routerMapper.removeAll()
    }

    public func router(withRouterURL url: String) -> FZRouterModelProtocol? {
        if let routerKey = FZDefaultURLRouterUtil.key(withRouterURL: url) {
            return routerMapper[routerKey]
        }
        return nil
    }

    public func allRouters() -> [FZRouterModelProtocol]? {
        return routerMapper.map({ (keyValue: (key: String, value: FZRouterModelProtocol)) -> FZRouterModelProtocol in
            return keyValue.value
        })
    }

    public func updateOrSave(withRouterURL url: String, target: AnyObject, selector: Selector) -> FZRouterModelProtocol? {
        if let routerKey = FZDefaultURLRouterUtil.key(withRouterURL: url) {
            if let routerModel = routerMapper[routerKey] {
                routerModel.target = target
                routerModel.selector = selector

                self.add(router: routerModel)
                return routerModel
            } else {
                let routerModel = FZDefaultURLRouterModel(routerKey: routerKey, target: target, selector: selector)
                self.add(router: routerModel)

                return routerModel
            }
        }
        return nil
    }

    public func updateOrSave(withRouterURL url: String, targetActionBlock: @escaping (FZRouterDataPacketProtocol) -> Void) -> FZRouterModelProtocol? {
        if let routerKey = FZDefaultURLRouterUtil.key(withRouterURL: url) {
            if let routerModel = routerMapper[routerKey] {
                routerModel.targetActionBlock = targetActionBlock

                self.add(router: routerModel)
                return routerModel
            } else {
                let routerModel = FZDefaultURLRouterModel(routerKey: routerKey, targetActionBlock: targetActionBlock)
                self.add(router: routerModel)

                return routerModel
            }
        }
        return nil
    }

}
