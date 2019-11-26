//
//  FZPermissionCamera.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/11/4.
//

import UIKit
import AVFoundation

public class FZPermissionCamera: NSObject {

    public static let shared = FZPermissionCamera()

    public var status: FZPermissionStatus {
        let status = AVCaptureDevice.authorizationStatus(for: .audio)

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
            return .disabled("unkunown AVCaptureDevice authorizationStatus \(status)")
        }
    }

    public func requestCameraPermission(callback: @escaping FZPermissionCallBack) {
        guard FZPermissionType.camera.containsAllUsageDescriptionKeyInInfoPlist else {
            callback(.disabled("WARNING: \(FZPermissionType.camera.missingKeysDescription ?? "") not found in Info.plist"))
            return
        }

        if self.status == .authorized {
            callback(self.status)
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { [weak self](_) in
                DispatchQueue.main.async {
                    guard let `self` = self else {
                        return
                    }
                    DispatchQueue.main.async {
                        callback(self.status)
                    }
                }
            })
        }
    }

}
