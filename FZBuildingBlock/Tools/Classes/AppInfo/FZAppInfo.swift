//
//  FZAppInfo.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/21.
//

import Foundation

open class FZAppInfo {

    // bundle identifier
    class var bundleIdentifier: String {
        get {
            return Bundle.main.bundleIdentifier ?? ""
        }
    }

    // bundle display name
    class var bundleDisplayName: String {
        get {
            return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
        }
    }

    // bundle version
    class var bundleVersion: String {
        get {
            return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        }
    }

    // bundle build version
    class var bundleShortVersion: String {
        get {
            return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        }
    }

}
