//
//  FZPermissionSiri.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/11/20.
//

import Foundation
import Intents

@available(iOS 10.0, *)
public class FZPermissionSiri: NSObject {

    public static let shared = FZPermissionSiri()

    public var status: FZPermissionStatus {
        let status = INPreferences.siriAuthorizationStatus()

        switch status {
        case .authorized:
            return .authorized
        case .denied:
            return .denied
        case .restricted:
            return .restricted
        case .notDetermined:
            return .notDetermined
        @unknown default:
            return .disabled("unknown ABAddressBook authorization Status : \(status)")
        }
    }

    public func requestSiriPermission(callback: @escaping FZPermissionCallBack) {
        guard FZPermissionType.siri.containsAllUsageDescriptionKeyInInfoPlist else {
            callback(.disabled("WARNING: \(FZPermissionType.siri.missingKeysDescription ?? "") not found in Info.plist"))
            return
        }

        if status == .authorized {
            callback(.authorized)
        } else {
            INPreferences.requestSiriAuthorization({ [weak self](status: INSiriAuthorizationStatus) in
                guard let `self` = self else {
                    return
                }
                DispatchQueue.main.async {
                    callback(self.status)
                }
            })

        }

    }

}
