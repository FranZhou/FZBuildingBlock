//
//  FZPermissionStatus.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/10/31.
//

import UIKit

/// permission status
/// - authorized: 用户已经允许授权
/// - denied: 用户授权不允许
/// - restricted: 未授权，且用户无法更新，如家长控制情况下
/// - notDetermined: 用户还没授权过
/// - disabled(String): disabled with message
public enum FZPermissionStatus {
    case authorized
    case denied
    case restricted
    case notDetermined
    case disabled(String)
}

extension FZPermissionStatus: Equatable {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.description == rhs.description
    }

}

extension FZPermissionStatus: CustomStringConvertible {

    public var description: String {
        switch self {
        case .authorized:
            return "Authorized"
        case .denied:
            return "Denied"
        case .restricted:
            return "Restricted"
        case .notDetermined:
            return "Not Determined"
        case .disabled(let message):
            return "disabled(\(message))"
        }
    }
}
