//
//  FZAddressBook.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/10/31.
//

import UIKit
import AddressBook

///
@available(iOS, introduced: 2.0, deprecated: 9.0)
public class FZAddressBook {

    static let contactsUsageDescription = "NSContactsUsageDescription"
    
    public static let shared = FZAddressBook()

    public var status: FZPermissionStatus {
        let status = ABAddressBookGetAuthorizationStatus()

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

    public func requestAddressBookPermission(callback: @escaping FZPermissionCallBack) {
        let contactsKey = FZAddressBook.contactsUsageDescription
        guard let _ = Bundle.main.object(forInfoDictionaryKey: contactsKey) else {
            callback(.disabled("WARNING: \(contactsKey) not found in Info.plist"))
            return
        }
        
        if status == .authorized {
            callback(.authorized)
        } else {
            let addressBook = ABAddressBookCreate().takeRetainedValue()
            ABAddressBookRequestAccessWithCompletion(addressBook) { [weak self](_, _) in
                guard let `self` = self else {
                    return
                }
                callback(self.status)
            }
        }

    }

}
