//
//  FZRouterManagerProtocol.swift
//  FZRouterSwift
//
//  Created by FranZhou on 2020/8/4.
//

import Foundation

@objc public protocol FZRouterManagerProtocol: NSObjectProtocol {

    /// add router
    ///
    /// - Parameter router: router to add
    @objc func add(router: FZRouterModelProtocol)

    /// add routers
    ///
    /// - Parameter routers: routers to add
    @objc func add(routers: [FZRouterModelProtocol])

    /// remove router
    ///
    /// - Parameter url: routerURL
    /// - Returns: FZRouterModelProtocol
    @discardableResult
    @objc func remove(WithRouterURL url: String) -> FZRouterModelProtocol?

    /// remove all router
    @objc func removeAllRouter()

    /// router for url
    ///
    /// - Parameter key: routerURL
    /// - Returns: FZRouterModelProtocol
    @objc func router(WithRouterURL url: String) -> FZRouterModelProtocol?

    /// get all router
    @objc func allRouters() -> [FZRouterModelProtocol]?

    /// updateOrSave target and selector for router url
    ///
    /// - Parameters:
    ///   - url: router url
    ///   - target: target
    ///   - selector: selector
    ///   - Returns: FZRouterModelProtocol
    @objc func updateOrSave(withRouterURL url: String, target: AnyObject, selector: Selector) -> FZRouterModelProtocol?

    /// updateOrSave targetActionBlock for router url
    ///
    /// - Parameters:
    ///   - url: router url
    ///   - targetActionBlock: argetActionBlock
    ///   - Returns: FZRouterModelProtocol
    @objc func updateOrSave(withRouterURL url: String, targetActionBlock: @escaping FZRouterModelProtocol.FZRouterModelTargetActionBlock) -> FZRouterModelProtocol?
}
