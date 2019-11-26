//
//  FZRouterModelProtocol.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/2.
//

import Foundation

@objc public protocol FZRouterModelProtocol: NSObjectProtocol {

    /// router key
    @objc var routerKey: String { get }

    /// NSClassFromString(targetName)
    @objc var target: AnyObject { get set }

    /// NSStringFromSelector(method)
    @objc var selector: Selector { get set }
}
