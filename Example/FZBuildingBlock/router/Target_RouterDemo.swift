//
//  Target_RouterDemo.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/9/2.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import FZBuildingBlock

@objc(Target_RouterDemo)
class Target_RouterDemo: NSObject {

    @objc class func testRouterAction(_ dataPacket: FZRouterDataPacket) {

        if let params = dataPacket.parameters {
            print(params.description)
        }

        dataPacket.targetActionReturnValue = "result"

    }
    
    @objc class func urlRouter(_ dataPacket: FZRouterDataPacket) {
        if let params = dataPacket.parameters {
            print(params.description)
        }

        dataPacket.targetActionReturnValue = "urlRouter"

    }

}
