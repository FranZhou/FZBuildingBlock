//
//  FZPermissionMotion.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/11/20.
//

import Foundation
import CoreMotion

public class FZPermissionMotion: NSObject {

    public static let shared = FZPermissionMotion()

    private var beforeiOS11Status: FZPermissionStatus = .denied

    public var status: FZPermissionStatus {
        if #available(iOS 11.0, *) {
            let status = CMMotionActivityManager.authorizationStatus()

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
                return .disabled("unknown CMMotionActivityManager authorization Status : \(status)")
            }

        } else {
            // Fallback on earlier versions
            return beforeiOS11Status
        }

    }

    public func requestMotionPermission(callback: @escaping FZPermission.FZPermissionCallBack) {
        guard FZPermissionType.motion.containsAllUsageDescriptionKeyInInfoPlist else {
            callback(.disabled("WARNING: \(FZPermissionType.motion.missingKeysDescription ?? "") not found in Info.plist"))
            return
        }

        if status == .authorized {
            callback(.authorized)
        } else {
            let manager = CMMotionActivityManager()
            let now = Date()

            manager.queryActivityStarting(from: now, to: now, to: OperationQueue.main) { [weak self](_: [CMMotionActivity]?, error: Error?) in
                manager.stopActivityUpdates()

                guard let `self` = self else {
                    return
                }

                let status: FZPermissionStatus

                if  let error = error, error._code == Int(CMErrorMotionActivityNotAuthorized.rawValue) {
                    status = .denied
                } else {
                    status = .authorized
                }

                self.beforeiOS11Status = status
                DispatchQueue.main.async {
                    callback(self.status)
                }
            }
        }

    }

}
