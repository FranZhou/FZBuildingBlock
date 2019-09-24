//
//  FZRouterDataPacket.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/9/5.
//

import Foundation

/// Its purpose is to pass the parameter and receive the return value in the target-action call
public class FZRouterDataPacket: NSObject {

    /// passing parameters into the target action
    @objc public let parameters: [String: Any]?

    /// receive return result
    @objc public var targetActionReturnValue: Any?

    @objc public init(parameters: [String: Any]?) {
        self.parameters = parameters

        super.init()
    }

}
