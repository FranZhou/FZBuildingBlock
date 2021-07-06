//
//  FZRouterExecuterProtocol.swift
//  FZRouterSwift
//
//  Created by FranZhou on 2020/8/4.
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

// MARK: - default implementation
extension FZRouterExecuterProtocol {

    public func couldExecute(withRouterURL url: String, router: FZRouter) -> FZRouterModelProtocol? {
        let manager = router.routerManager

        // get routerkey from url. then get routerModel
        guard let routerModel = manager.router(withRouterURL: url)
            else {
                return nil
        }
        return routerModel
    }

    public func passingParameters(withRouterURL url: String, extra parameters: [String: Any]?, routerModel: FZRouterModelProtocol, router: FZRouter) -> [String: Any]? {

        // get parameters from url
        var totalParameters: [String: Any] = [:]

        // extraParameters will cover urlParameters when they have same key
        if let extraParameters = parameters {
            totalParameters = totalParameters.merging(extraParameters, uniquingKeysWith: { (_: Any, extraValue: Any) -> Any in
                return extraValue
            })
        }

        return totalParameters
    }

}
