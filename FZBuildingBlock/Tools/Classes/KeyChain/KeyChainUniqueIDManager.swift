//
//  KeyChainUniqueIDManager.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/2/22.
//

import Foundation

/// 在keychain中 保存/获取 设备唯一标识号
public struct KeyChainUniqueIDManager {

    // 配置 keychain 标示符, 服务和账户名称
    public let serviceName: String
    public let accountName: String

    /*
     Specifying an access group to use with `KeychainPasswordItem` instances
     will create items shared accross both apps.
     
     For information on App ID prefixes, see:
     https://developer.apple.com/library/ios/documentation/General/Conceptual/DevPedia-CocoaCore/AppID.html
     and:
     https://developer.apple.com/library/ios/technotes/tn2311/_index.html
     */
    //    static let accessGroup = "[YOUR APP ID PREFIX].com.example.apple-samplecode.GenericKeychainShared"

    /*
     Not specifying an access group to use with `KeychainPasswordItem` instances
     will create items specific to each app.
     */
    public let accessGroup: String? = nil

    /// 唯一标识 ID, 没有的话自动创建一个
    public var uniqueID: String {
        let item = KeychainPasswordItem(service: serviceName, account: accountName, accessGroup: accessGroup)
        do {
            let uniqueId = try item.readPassword()
            return uniqueId
        } catch {
            print("\n--- warning: Could not read token ---")
        }

        let uuid = UUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased()
        do {
            try item.savePassword(uuid)
        } catch {
            print("\n--- warning: Could not save token ---")
        }
        return uuid
    }

    /// 唯一标识 ID, 使用传入的 key 存入钥匙串, 没有的话自动创建一个
    public func uniqueID(defaults: String?) -> String {

        let item = KeychainPasswordItem(service: serviceName, account: accountName, accessGroup: accessGroup)

        if let defaults = defaults {
            do {
                try item.savePassword(defaults)
            } catch {
                print("\n--- warning: Could not save token ---")
            }
            return defaults
        }

        do {
            let uniqueId = try item.readPassword()
            return uniqueId
        } catch {
            print("\n--- warning: Could not read token ---")
        }

        let uuid = UUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased()
        do {
            try item.savePassword(uuid)
        } catch {
            print("\n--- warning: Could not save token ---")
        }
        return uuid
    }
}
