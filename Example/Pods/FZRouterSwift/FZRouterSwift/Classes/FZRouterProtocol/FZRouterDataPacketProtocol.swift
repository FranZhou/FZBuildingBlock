//
//  FZRouterDataPacketProtocol.swift
//  FZRouterSwift
//
//  Created by FranZhou on 2020/8/4.
//

import Foundation

/// FZRouter passing to executor and receive result
@objc public protocol FZRouterDataPacketProtocol: NSObjectProtocol {

    /// passing parameters into the target action
    @objc var parameters: [String: Any]? { get set }

    /// receive return result
    @objc var returnValue: Any? { get set }

    /// init
    ///
    /// - Parameter parameters: parameters
    @objc init(parameters: [String: Any]?)
}
