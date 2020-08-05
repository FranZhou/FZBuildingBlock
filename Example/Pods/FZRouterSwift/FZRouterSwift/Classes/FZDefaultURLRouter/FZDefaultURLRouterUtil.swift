//
//  FZDefaultURLRouterUtil.swift
//  FZRouterSwift
//
//  Created by FranZhou on 2020/8/4.
//

import Foundation

open class FZDefaultURLRouterUtil: NSObject {

    @objc public class func key(withRouterURL url: String) -> String? {
        guard let routerURL = URL(string: url),
            let scheme = routerURL.scheme,
            let host = routerURL.host
            else {
                return nil
        }

        let path = routerURL.relativePath

        return "\(scheme)://\(host)\(path)"
    }

    @objc public class func urlParameters(withRouterURL url: String) -> [String: AnyObject]? {
        guard let routerURL = URL(string: url),
            let urlComponents = NSURLComponents(url: routerURL, resolvingAgainstBaseURL: false)
            else {
                return nil
        }

        if let queryItems = urlComponents.queryItems {
            // Parameters can be obtained directly in the url
            var queryParameters: [String: AnyObject] = [:]

            queryItems.forEach { (item: URLQueryItem) in
                queryParameters[item.name] = item.value as AnyObject
            }

            return queryParameters

        } else {
            // Parameters cannot be retrieved directly from the url
            // You need to determine for yourself whether the parameter really exists

            let urlArray = url.components(separatedBy: "?")
            if urlArray.count == 2,
                let urlParametersString = urlArray.last {

                var queryParameters: [String: AnyObject] = [:]

                urlParametersString.components(separatedBy: "&").forEach { (keyValueString: String) in
                    let keyValueArray = keyValueString.components(separatedBy: "=")
                    if keyValueArray.count == 2 {
                        queryParameters[keyValueArray[0]] = keyValueArray[1] as AnyObject
                    }
                }

                return queryParameters
            }

        }

        // There are really no parameters in the url
        return nil
    }
}
