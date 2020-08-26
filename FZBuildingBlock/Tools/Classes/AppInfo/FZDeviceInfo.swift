//
//  FZDeviceInfo.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/21.
//

import Foundation

open class FZDeviceInfo {

    // e.g. "My iPhone"
    class var name: String {
        get {
            return UIDevice.current.name
        }
    }

    // e.g. @"iPhone", @"iPod touch"
    class var model: String {
        get {
            return UIDevice.current.model
        }
    }

    // localized version of model
    class var localizedModel: String {
        get {
            return UIDevice.current.localizedModel
        }
    }

    // e.g. @"iOS"
    class var systemName: String {
        get {
            return UIDevice.current.systemName
        }
    }

    // e.g. @"4.0"
    class var systemVersion: String {
        get {
            return UIDevice.current.systemVersion
        }
    }

}
