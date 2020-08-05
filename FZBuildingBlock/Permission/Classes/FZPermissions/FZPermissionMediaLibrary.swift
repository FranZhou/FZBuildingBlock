//
//  FZPermissionMediaLibrary.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/11/20.
//

import Foundation
import MediaPlayer

@available(iOS 9.3, *)
public class FZPermissionMediaLibrary: NSObject {

    public static let shared = FZPermissionMediaLibrary()

    public var status: FZPermissionStatus {
        let status = MPMediaLibrary.authorizationStatus()

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

    public func requestMediaLibraryPermission(callback: @escaping FZPermission.FZPermissionCallBack) {
        guard FZPermissionType.mediaLibrary.containsAllUsageDescriptionKeyInInfoPlist else {
            callback(.disabled("WARNING: \(FZPermissionType.mediaLibrary.missingKeysDescription ?? "") not found in Info.plist"))
            return
        }

        if status == .authorized {
            callback(.authorized)
        } else {
            MPMediaLibrary.requestAuthorization({ [weak self](status: MPMediaLibraryAuthorizationStatus) in
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
