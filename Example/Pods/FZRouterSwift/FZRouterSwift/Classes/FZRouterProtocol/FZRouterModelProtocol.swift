//
//  FZRouterModelProtocol.swift
//  FZRouterSwift
//
//  Created by FranZhou on 2020/8/4.
//

import Foundation

@objc public protocol FZRouterModelProtocol: NSObjectProtocol {

    typealias FZRouterModelTargetActionBlock = (_ dataPacket: FZRouterDataPacketProtocol) -> Void

    /// router key
    @objc var routerKey: String { get }

    /// NSClassFromString(targetName)
    @objc var target: AnyObject? { get set }

    /// NSStringFromSelector(method)
    @objc var selector: Selector? { get set }

    /// first call targetActionBlock, if targetActionBlock = nil, call target-selector
    @objc var targetActionBlock: FZRouterModelTargetActionBlock? { get set }

    /// init
    ///
    /// - Parameter routerKey: router key
    @objc init(routerKey: String)
}
