//
//  FZDefaultURLRouterPlistLoader.swift
//  FZRouterSwift
//
//  Created by FranZhou on 2020/8/4.
//

import Foundation

open class FZDefaultURLRouterPlistLoader: NSObject {

    @objc public static let defaultLoader = FZDefaultURLRouterPlistLoader()

}

// MARK: - FZRouterLoaderProtocol
extension FZDefaultURLRouterPlistLoader: FZRouterLoaderProtocol {

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
        router.routerManager.removeAllRouter()
        urls.forEach { [weak self, weak router](url) in
            guard let `self` = self,
                let router = router else {
                    return
            }
            self.appendRouter(withRouterURL: url, router: router)
        }
    }

    public func appendRouter(withRouterURL url: String, router: FZRouter) {
        if let routerModel = routerModel(withRouterURL: url) {
            router.routerManager.add(router: routerModel)
        }
    }
}

// MARK: - fileprivate
extension FZDefaultURLRouterPlistLoader {

    /// 加载通过plist导入的路由
    /// - Parameter filePath: 路由文件路径
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

                                    // targetActions
                                    for targetAction in targetActionDicArray {

                                        // target
                                        if let targetActionDic = targetAction as? NSDictionary,
                                            let targetName = targetActionDic.object(forKey: "target") as? String,
                                            let actionDic = dictionary(forKey: "actions", in: targetActionDic) {

                                            // action
                                            for (_, action) in actionDic.enumerated() {
                                                if let actionKey = action.key as? String,
                                                    let actionValue = action.value as? String {

                                                    let routerURL = "\(scheme)://\(host)/\(serverPath)/\(actionKey)"
                                                    let selector = self.action(forName: actionValue)

                                                    // routerKey target selector
                                                    if let routerKey = FZDefaultURLRouterUtil.key(withRouterURL: routerURL) {

                                                        let routerModel = FZDefaultURLRouterModel(routerKey: routerKey, targetName: targetName, selector: selector)

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

    /// 加载url字符串路由
    /// - Parameter url: url string
    fileprivate func routerModel(withRouterURL url: String) -> FZRouterModelProtocol? {
        guard let routerURL = URL(string: url),
            let routerKey = FZDefaultURLRouterUtil.key(withRouterURL: url) else {
                return nil
        }

        let path = routerURL.relativePath
        let pathArray = path.split(separator: "/").filter { (substring) -> Bool in
            return substring != ""
        }

        if pathArray.count == 2 {
            let targetName = String(pathArray[0].first!).uppercased() + String(pathArray[0].dropFirst())
            let actionValue = String(pathArray[1])
            let selector = action(forName: actionValue)

            return FZDefaultURLRouterModel(routerKey: routerKey, targetName: targetName, selector: selector)
        }

        return nil
    }

}

// MARK: - internal
extension FZDefaultURLRouterPlistLoader {

    internal func dictionary(forKey key: Any, in dictionary: NSDictionary) -> NSDictionary? {
        return dictionary.object(forKey: key) as? NSDictionary
    }

    internal func array(forKey key: Any, in dictionary: NSDictionary) -> NSArray? {
        return dictionary.object(forKey: key) as? NSArray
    }

    internal func target(forName target: String) -> AnyClass? {
        if target.count > 0 {
            let targetName = "Target_\(target.first?.uppercased() ?? "")\(target.dropFirst())"
            return NSClassFromString(targetName)
        }
        return nil
    }

    internal func action(forName action: String) -> Selector {
        let selectorName = action + ":"
        return NSSelectorFromString(selectorName)
    }

    internal func load(routerModel: FZDefaultURLRouterModel) {
        if !routerModel.isLoad,
           let targetName = routerModel.targetName,
           let targetObject = self.target(forName: targetName) {
            routerModel.target = targetObject
        }
        routerModel.isLoad = true
    }
}
