//
//  FZContacts.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/10/31.
//

import UIKit
import Contacts

@available(iOS 9.0, *)
public class FZContacts {
    
    static let contactsUsageDescription = "NSContactsUsageDescription"

    public static let shared = FZContacts()

    func transformType(for type: FZPermissionContactsType) -> CNEntityType {
        var entityType: CNEntityType = .contacts
        switch type {
        case .contacts:
            entityType = .contacts
        }
        return entityType
    }

    public func status(for type: FZPermissionContactsType) -> FZPermissionStatus {
        let entityType = transformType(for: type)
        let status = CNContactStore.authorizationStatus(for: entityType)

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

    public func requestContactsPermission(for type: FZPermissionContactsType, callback: @escaping FZPermissionCallBack) {
        var contactsKey = FZContacts.contactsUsageDescription
        switch type {
        case .contacts:
            contactsKey = FZContacts.contactsUsageDescription
        }

        guard let _ = Bundle.main.object(forInfoDictionaryKey: contactsKey) else {
            callback(.disabled("WARNING: \(contactsKey) not found in Info.plist"))
            return
        }
        
        if status(for: type) == .authorized {
            callback(.authorized)
        } else {
            let entityType = transformType(for: type)
            CNContactStore().requestAccess(for: entityType) { [weak self](_, _) in
                guard let `self` = self else {
                    return
                }
                callback(self.status(for: type))
            }
        }
    }

}
