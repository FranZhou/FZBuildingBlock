//
//  FZRouterPlistLoader.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/8/31.
//

import Foundation

open class FZRouterPlistLoader: NSObject {

    @objc public static let defaultLoader = FZRouterPlistLoader()

}

extension FZRouterPlistLoader {

    fileprivate func dictionary(forKey key: Any, in dictionary: NSDictionary) -> NSDictionary? {
        return dictionary.object(forKey: key) as? NSDictionary
    }

    fileprivate func array(forKey key: Any, in dictionary: NSDictionary) -> NSArray? {
        return dictionary.object(forKey: key) as? NSArray
    }

    fileprivate func target(forName target: String) -> AnyClass? {
        if target.count > 0 {
            let targetName = "Target_\(target.first?.uppercased() ?? "")\(target.dropFirst())"
            return NSClassFromString(targetName)
        }
        return nil
    }

    fileprivate func action(forName action: String) -> Selector {
        let selectorName = action + ":"
        return NSSelectorFromString(selectorName)
    }
}

extension FZRouterPlistLoader: FZRouterLoaderProtocol {

    fileprivate func routerModel(withFilePath filePath: String) -> [FZRouterModelProtocol]? {

        var routerModelArray: [FZRouterModelProtocol]?

        if let plist = NSDictionary(contentsOfFile: filePath),
            let schemeArray = plist.allKeys as? [String] {

            // scheme
            for scheme in schemeArray {
                if let hostsDic = dictionary(forKey: scheme, in: plist),
                    let hostArray = hostsDic.allKeys as? [String] {

                    // host
                    for host in hostArray {
                        if let serverPathDic = dictionary(forKey: host, in: hostsDic),
                            let serverPathArray = serverPathDic.allKeys as? [String] {

                            // serverPath
                            for serverPath in serverPathArray {
                                if let targetActionDicArray = array(forKey: serverPath, in: serverPathDic) {

                                    // targetAction
                                    for targetAction in targetActionDicArray {

                                        // target
                                        if let targetActionDic = targetAction as? NSDictionary,
                                            let targetName = targetActionDic.object(forKey: "target") as? String,
                                            let targetObject = self.target(forName: targetName),
                                            let actionDic = dictionary(forKey: "actions", in: targetActionDic) {

                                            // action
                                            for (_, action) in actionDic.enumerated() {
                                                if let actionKey = action.key as? String,
                                                    let actionValue = action.value as? String {

                                                    let routerURL = "\(scheme)://\(host)/\(serverPath)/\(actionKey)"

                                                    let selector = self.action(forName: actionValue)

                                                    // routerKey target selector
                                                    if let routerKey = FZRouterURLUtil.key(withRouterURL: routerURL),
                                                        (targetObject as AnyObject).responds(to: selector) {

                                                        let routerModel = FZRouterModel(routerKey: routerKey, target: targetObject, selector: selector)

                                                        if routerModelArray == nil {
                                                            routerModelArray = []
                                                        }

                                                        routerModelArray?.append(routerModel)
                                                    }

                                                }
                                            }

                                        }
                                    }

                                }
                            }
                        }
                    }
                }
            }
        }

        return routerModelArray
    }

    public func loadRouter(withFilePath filePath: String, router: FZRouter) {
        router.routerManager.removeAllRouter()
        if let routerModeArray = routerModel(withFilePath: filePath) {
            router.routerManager.add(routers: routerModeArray)
        }
    }

    public func appendRouter(withFilePath filePath: String, router: FZRouter) {
        if let routerModeArray = routerModel(withFilePath: filePath) {
            router.routerManager.add(routers: routerModeArray)
        }
    }

    public func loadRouter(withRouterURLs urls: [String], router: FZRouter) {

    }

    public func appendRouter(withRouterURL url: String, router: FZRouter) {

    }

}
