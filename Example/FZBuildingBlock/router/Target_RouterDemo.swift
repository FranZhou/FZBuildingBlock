//
//  Target_RouterDemo.swift
//  FZBuildingBlock_Example
//
//  Created by FranZhou on 2019/9/2.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import FZRouterSwift

@objc(Target_RouterDemo)
class Target_RouterDemo: NSObject {

    @objc class func testRouterAction(_ dataPacket: FZRouterDataPacketProtocol) {

        if let params = dataPacket.parameters {
            print(params.description)
        }

        dataPacket.returnValue = "result"

    }

    @objc class func urlRouter(_ dataPacket: FZRouterDataPacketProtocol) {
        if let params = dataPacket.parameters {
            print(params.description)
        }

        dataPacket.returnValue = "urlRouter"

    }

}
