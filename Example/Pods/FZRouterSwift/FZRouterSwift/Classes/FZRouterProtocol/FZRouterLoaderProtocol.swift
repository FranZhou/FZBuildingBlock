//
//  FZRouterLoaderProtocol.swift
//  FZRouterSwift
//
//  Created by FranZhou on 2020/8/4.
//

import Foundation

/// FZRouter load protocol
@objc public protocol FZRouterLoaderProtocol: NSObjectProtocol {

    /// load router with file
    ///
    /// - Parameters:
    ///   - filePath: filePath
    ///   - router: FZRouter instance
    @objc func loadRouter(withFilePath filePath: String, router: FZRouter)

    /// append router with file
    ///
    /// - Parameters:
    ///   - filePath: filePath
    ///   - router: FZRouter instance
    @objc func appendRouter(withFilePath filePath: String, router: FZRouter)

    /// load router with urls
    ///
    /// - Parameters:
    ///   - urls: url array
    ///   - router: FZRouter instance
    @objc func loadRouter(withRouterURLs urls: [String], router: FZRouter)

    /// remove router with url
    ///
    /// - Parameters:
    ///   - url: url string
    ///   - router: FZRouter instance
    @objc func appendRouter(withRouterURL url: String, router: FZRouter)

}
