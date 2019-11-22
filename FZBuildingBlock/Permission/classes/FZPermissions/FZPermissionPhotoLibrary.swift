//
//  FZPermissionPhotoLibrary.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/11/4.
//

import UIKit
import Photos

public class FZPermissionPhotoLibrary: NSObject {

    public static let shared = FZPermissionPhotoLibrary()

    public var status: FZPermissionStatus {
        let status = PHPhotoLibrary.authorizationStatus()

        switch status {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorized:
            return .authorized
        @unknown default:
            return .disabled("unkunown PHPhotoLibrary authorizationStatus \(status)")
        }
    }

    public func requestPhotoLibraryPermission(callback: @escaping FZPermissionCallBack) {
        guard FZPermissionType.photoLibrary.containsAllUsageDescriptionKeyInInfoPlist else {
            callback(.disabled("WARNING: \(FZPermissionType.photoLibrary.missingKeysDescription ?? "") not found in Info.plist"))
            return
        }

        if self.status == .authorized {
            callback(self.status)
        } else {
            PHPhotoLibrary.requestAuthorization { [weak self](_) in
                DispatchQueue.main.async {
                    guard let `self` = self else {
                        return
                    }
                    DispatchQueue.main.async {
                        callback(self.status)
                    }
                }
            }
        }
    }

}
