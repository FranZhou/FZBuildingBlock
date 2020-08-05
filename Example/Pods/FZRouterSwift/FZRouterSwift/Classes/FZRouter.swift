//
//  FZRouter.swift
//  FZRouterSwift
//
//  Created by FranZhou on 2020/8/4.
//

import Foundation

/**
 case invalidRouterURL(String): 未知的路由
 case unableToExecuter(String, FZRouterModelProtocol): 无法执行的路由， target-sector and targetActionBlock 均未配置
 */
public enum FZRouterError: Error {
    case invalidRouterURL(String)
    case unableToExecuter(String, FZRouterModelProtocol)
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
        dataPacket.returnValue = "result"
    }
 }
 ```
 */
public final class FZRouter: NSObject {

    /// router instance
    @objc public static let defaultRouter = FZRouter()

    /// router manager，default is FZRouterManager.manager
    @objc public var routerManager: FZRouterManagerProtocol = FZDefaultURLRouterManager.defaultManager

    /// router loader，default is FZRouterPlistLoader.plistLoader
    @objc public var routerLoader: FZRouterLoaderProtocol = FZDefaultURLRouterPlistLoader.defaultLoader

    /// router execute filter，default is FZRouterExecute.execute
    @objc public var routerExecuter: FZRouterExecuterProtocol = FZDefaultURLRouterExecuter.defaultExecuter

    /// target-action result data packet
    @objc public var routerDataPacketClass: FZRouterDataPacketProtocol.Type = FZRouterDataPacket.self

}

// MARK: - loader
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

}

// MARK: - manager
extension FZRouter {

    @discardableResult
    @objc public func removeRouter(withRouterURL url: String) -> FZRouterModelProtocol? {
        return routerManager.remove(WithRouterURL: url)
    }

    @objc public func removeAllRouter() {
        routerManager.removeAllRouter()
    }

    @discardableResult
    @objc public func updateOrSave(withRouterURL url: String, target: AnyObject, selector: Selector) -> FZRouterModelProtocol? {
        return routerManager.updateOrSave(withRouterURL: url, target: target, selector: selector)
    }

    @discardableResult
    @objc public func updateOrSave(withRouterURL url: String, targetActionBlock: @escaping FZRouterModelProtocol.FZRouterModelTargetActionBlock) -> FZRouterModelProtocol? {
        return routerManager.updateOrSave(withRouterURL: url, targetActionBlock: targetActionBlock)
    }

}

// MARK: - routerExecuter
extension FZRouter {

    @objc public func  canExecuteRouter(withRouterURL url: String) -> Bool {
        if let routerModel = routerExecuter.couldExecute(withRouterURL: url, router: self) {
            if let _ = routerModel.targetActionBlock {
                return true
            } else if let target = routerModel.target,
                let selector = routerModel.selector {
                if target.responds(to: selector) {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        } else {
            return false
        }
    }

    @discardableResult
    @objc public func router(withRouterURL url: String, extraParameters params: [String: Any]? = nil) throws -> FZRouterDataPacketProtocol {
        // get router execute infomation
        if let routerModel = routerExecuter.couldExecute(withRouterURL: url, router: self) {
            // parameters
            let passingParameters = routerExecuter.passingParameters(withRouterURL: url, extra: params, routerModel: routerModel, router: self)
            // datapacket
            let dataPacket = routerDataPacketClass.init(parameters: passingParameters)

            if let targetActionBlock = routerModel.targetActionBlock {
                // targetActionBlock executer first
                targetActionBlock(dataPacket)
                return dataPacket
            } else if let target = routerModel.target,
                let selector = routerModel.selector {
                // if targetActionBlock = nil, executer with target and selector

                // test to execute
                if target.responds(to: selector) {
                    _ = target.perform(selector, with: dataPacket)
                    return dataPacket
                } else {
                    // target.responds(to: selector) can't execute
                    throw FZRouterError.unableToExecuter(url, routerModel)
                }
            } else {
                // none targetActionBlock and none target selector
                throw FZRouterError.unableToExecuter(url, routerModel)
            }
        } else {
            // invalid url
            throw FZRouterError.invalidRouterURL(url)
        }
    }

}
