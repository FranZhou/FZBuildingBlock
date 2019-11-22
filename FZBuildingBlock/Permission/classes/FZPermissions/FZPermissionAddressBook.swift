//
//  FZPermissionAddressBook.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/10/31.
//

import UIKit
import AddressBook

///
@available(iOS, introduced: 2.0, deprecated: 9.0)
public class FZPermissionAddressBook: NSObject {

    public static let shared = FZPermissionAddressBook()

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
        guard FZPermissionType.addressBook.containsAllUsageDescriptionKeyInInfoPlist else {
            callback(.disabled("WARNING: \(FZPermissionType.addressBook.missingKeysDescription ?? "") not found in Info.plist"))
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
                DispatchQueue.main.async {
                    callback(self.status)
                }
            }
        }

    }

}
