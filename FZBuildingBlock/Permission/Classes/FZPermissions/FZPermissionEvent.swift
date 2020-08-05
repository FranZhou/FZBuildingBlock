//
//  FZPermissionEvent.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/11/4.
//

import UIKit
import EventKit

public class FZPermissionEvent: NSObject {

    public static let shared = FZPermissionEvent()

    public func status(for type: EKEntityType) -> FZPermissionStatus {
        let status = EKEventStore.authorizationStatus(for: type)

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
            return .disabled("unkunown EKEventStore authorizationStatus \(status)")
        }
    }

    public func requestEventPermision(for type: EKEntityType, callback: @escaping FZPermission.FZPermissionCallBack) {
        guard FZPermissionType.event(type).containsAllUsageDescriptionKeyInInfoPlist else {
            callback(.disabled("WARNING: \(FZPermissionType.event(type).missingKeysDescription ?? "") not found in Info.plist"))
            return
        }

        if self.status(for: type) == .authorized {
            callback(.authorized)
        } else {
            EKEventStore().requestAccess(to: type) { [weak self](_, _) in
                DispatchQueue.main.async {
                    guard let `self` = self else {
                        return
                    }
                    DispatchQueue.main.async {
                        callback(self.status(for: type))
                    }
                }
            }
        }

    }
}
