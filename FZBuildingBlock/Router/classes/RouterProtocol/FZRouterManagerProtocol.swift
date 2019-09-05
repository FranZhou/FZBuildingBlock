//
//  FZRouterManagerProtocol.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/31.
//

import Foundation

@objc public protocol FZRouterManagerProtocol: NSObjectProtocol{
    
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
    /// - Returns: FZRouterModel
    @discardableResult
    @objc func remove(WithRouterURL url: String) -> FZRouterModelProtocol?
    
    /// remove all router
    @objc func removeAllRouter()
    
    /// router for url
    ///
    /// - Parameter key: routerURL
    /// - Returns: FZRouterModel
    @objc func router(WithRouterURL url: String) -> FZRouterModelProtocol?
    
    /// get all router
    @objc func allRouters() -> [FZRouterModelProtocol]?
    
}

