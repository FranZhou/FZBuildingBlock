//
//  FZRouterExecuterProtocol.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/31.
//

import Foundation

@objc public protocol FZRouterExecuterProtocol: NSObjectProtocol {

    /// could execute router, you can choose which routerModel to execute
    ///
    /// - Parameters:
    ///   - url: routerURL string
    ///   - router: FZRouter instance
    /// - Returns: return the router could be executed, return nil means couldn't execute
    @objc func couldExecute(withRouterURL url: String, router: FZRouter) -> FZRouterModelProtocol?

    /// Parameters passed by router
    ///
    /// - Parameters:
    ///   - url: routerURL string
    ///   - parameters: Extra parameters passed in from outside
    ///   - routerModel: the router could be executed
    ///   - router: FZRouter instance
    /// - Returns: Parameters passed by router
    @objc func passingParameters(withRouterURL url: String, extra parameters: [String: Any]?, routerModel: FZRouterModelProtocol, router: FZRouter) -> [String: Any]?

}
