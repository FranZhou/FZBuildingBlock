//
//  FZRouter.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/31.
//

import UIKit

public enum FZRouterError: Error {
    case unknownRouterURL(String)
    case unableToPerform(AnyObject, Selector)
}

// MARK: -

/**
 The routing implementation object must inherit NSObject.
 The method that responds to the target-action must identify @objc, and accept an argument of type FZRouterDataPacket
 
 ```
 @objc(Target_RouterDemo)
 class Target_RouterDemo: NSObject {
    @objc class func testRouterAction(_ dataPacket: FZRouterDataPacket) {
        if let params = dataPacket.parameters {
            print(params.description)
        }
        dataPacket.targetActionReturnValue = "result"
    }
 }
 ```
 */
open class FZRouter: NSObject {

    /// router instance
    @objc public static let defaultRouter = FZRouter()

    /// router manager，default is FZRouterManager.manager
    @objc public var routerManager: FZRouterManagerProtocol = FZRouterManager.defaultManager

    /// router loader，default is FZRouterPlistLoader.plistLoader
    @objc public var routerLoader: FZRouterLoaderProtocol = FZRouterPlistLoader.defaultLoader

    /// router execute filter，default is FZRouterExecute.execute
    @objc public var routerExecuter: FZRouterExecuterProtocol = FZRouterExecute.defaultExecuter

}

// MARK: - loader & manager
extension FZRouter {

    @objc public func loadRouter(withFilePath filePath: String) {
        routerLoader.loadRouter(withFilePath: filePath, router: self)
    }

    @objc public func appendRouter(withFilePath filePath: String) {
        routerLoader.appendRouter(withFilePath: filePath, router: self)
    }

    @objc public func loadRouter(withRouterURLs urls: [String]) {
        routerLoader.loadRouter(withRouterURLs: urls, router: self)
    }

    @objc public func appendRouter(withRouterURL url: String) {
        routerLoader.appendRouter(withRouterURL: url, router: self)
    }

    @objc public func removeRouter(withRouterURL url: String) {
        routerManager.remove(WithRouterURL: url)
    }

    @objc public func removeAllRouter() {
        routerManager.removeAllRouter()
    }

    @objc func change(WithRouterURL url: String, target: AnyObject, selector: Selector) {
        _ = routerManager.change(WithRouterURL: url, target: target, selector: selector)
    }

}

// MARK: - routerExecuter
extension FZRouter {

    @discardableResult
    @objc public func router(withRouterURL url: String, extraParameters params: [String: Any]? = nil) throws -> FZRouterDataPacket {
        // get router execute infomation
        if let routerModel = routerExecuter.couldExecute(withRouterURL: url, router: self) {
            let target = routerModel.target
            let selector = routerModel.selector

            if target.responds(to: selector) {

                let passingParameters = routerExecuter.passingParameters(withRouterURL: url, extra: params, routerModel: routerModel, router: self)
                let dataPacket = FZRouterDataPacket(parameters: passingParameters)

                _ = target.perform(selector, with: dataPacket)

                return dataPacket

            } else {
                throw FZRouterError.unableToPerform(target, selector)
            }
        }

        throw FZRouterError.unknownRouterURL(url)
    }

}
