//
//  FZPermissionContacts.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/10/31.
//

import UIKit
import Contacts

@available(iOS 9.0, *)
public class FZPermissionContacts: NSObject {

    public static let shared = FZPermissionContacts()

    public func status(for type: CNEntityType) -> FZPermissionStatus {
        let status = CNContactStore.authorizationStatus(for: type)

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
            return .disabled("unknown CNContactStore authorization Status : \(status)")
        }
    }

    public func requestContactsPermission(for type: CNEntityType, callback: @escaping FZPermissionCallBack) {
        guard FZPermissionType.contacts(type).containsAllUsageDescriptionKeyInInfoPlist else{
            callback(.disabled("WARNING: \(FZPermissionType.contacts(type).missingKeysDescription ?? "") not found in Info.plist"))
            return
        }

        if status(for: type) == .authorized {
            callback(.authorized)
        } else {
            CNContactStore().requestAccess(for: type) { [weak self](_, _) in
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
