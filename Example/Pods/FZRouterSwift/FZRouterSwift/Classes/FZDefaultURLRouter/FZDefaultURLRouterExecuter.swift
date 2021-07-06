//
//  FZDefaultURLRouterExecuter.swift
//  FZRouterSwift
//
//  Created by FranZhou on 2020/8/4.
//

import Foundation

/// default FZRouterExecuterProtocol instance
open class FZDefaultURLRouterExecuter: NSObject {

    @objc public static let defaultExecuter = FZDefaultURLRouterExecuter()

}

extension FZDefaultURLRouterExecuter: FZRouterExecuterProtocol {

    public func couldExecute(withRouterURL url: String, router: FZRouter) -> FZRouterModelProtocol? {

        let manager = router.routerManager

        // get routerkey from url. then get routerModel
        guard let routerModel = manager.router(withRouterURL: url)
            else {
                return nil
        }

        if let routerModel = routerModel as? FZDefaultURLRouterModel,
           !routerModel.isLoad {
            // load routerModel
            FZDefaultURLRouterPlistLoader.defaultLoader.load(routerModel: routerModel)
        }

        return routerModel
    }

    public func passingParameters(withRouterURL url: String, extra parameters: [String: Any]?, routerModel: FZRouterModelProtocol, router: FZRouter) -> [String: Any]? {

        // get parameters from url
        var totalParameters: [String: Any] = [:]

        // parameters in url
        if let urlParameters = FZDefaultURLRouterUtil.urlParameters(withRouterURL: url) {
            totalParameters = totalParameters.merging(urlParameters, uniquingKeysWith: { (_: Any, urlValue: Any) -> Any in
                return urlValue
            })
        }

        // parameters other than url
        // extraParameters will cover urlParameters when they have same key
        if let extraParameters = parameters {
            totalParameters = totalParameters.merging(extraParameters, uniquingKeysWith: { (_: Any, extraValue: Any) -> Any in
                return extraValue
            })
        }

        return totalParameters
    }

}
