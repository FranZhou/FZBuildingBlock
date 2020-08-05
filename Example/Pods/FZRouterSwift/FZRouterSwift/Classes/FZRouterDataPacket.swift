//
//  FZRouterDataPacket.swift
//  FZRouterSwift
//
//  Created by FranZhou on 2020/8/4.
//

import Foundation

/// Its purpose is to pass the parameter and receive the return value in the target-action call
open class FZRouterDataPacket: NSObject, FZRouterDataPacketProtocol {

    /// passing parameters into the target action
    @objc public var parameters: [String: Any]?

    /// receive return result
    @objc public var returnValue: Any?

    @objc required public init(parameters: [String: Any]?) {
        self.parameters = parameters

        super.init()
    }

}
