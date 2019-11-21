//
//  FZPermission.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/10/31.
//

import UIKit

public typealias FZPermissionCallBack = (FZPermissionStatus) -> Void

open class FZPermission: NSObject {
    
    public class func requestPermission(for type: FZPermissionType, callback: @escaping FZPermissionCallBack){
        switch type {
        case .addressBook:
            FZPermissionAddressBook.shared.requestAddressBookPermission(callback: callback)
        case .contacts(let entityType):
            if #available(iOS 9.0, *) {
                FZPermissionContacts.shared.requestContactsPermission(for: entityType, callback: callback)
            }else{
                callback(.disabled("FZPermissionType.contacts available iOS 9.0"))
            }
        case .location(let locationType):
            FZPermissionLocation.shared.requestLocationPermision(for: locationType, callback: callback)
        case .microphone:
            FZPermissionMicrophone.shared.requestMicrophonePermission(callback: callback)
        case .camera:
            FZPermissionCamera.shared.requestCameraPermission(callback: callback)
        case .photoLibrary:
            FZPermissionPhotoLibrary.shared.requestPhotoLibraryPermission(callback: callback)
        case .event(let entityType):
            FZPermissionEvent.shared.requestEventPermision(for: entityType, callback: callback)
        case .bluetooth:
            FZPermissionBluetooth.shared.requestBluetoothPermission(callback: callback)
        case .motion:
            FZPermissionMotion.shared.requestMotionPermission(callback: callback)
        case .speechRecognizer:
            if #available(iOS 10.0, *) {
                FZPermissionSpeechRecognizer.shared.requestSpeechRecognizerPermission(callback: callback)
            } else {
                callback(.disabled("FZPermissionType.speechRecognizer available iOS 10.0"))
            }
        case .mediaLibrary:
            if #available(iOS 9.3, *) {
                FZPermissionMediaLibrary.shared.requestMediaLibraryPermission(callback: callback)
            } else {
                callback(.disabled("FZPermissionType.mediaLibrary available iOS 9.3"))
            }
        case .siri:
            if #available(iOS 10.0, *) {
                FZPermissionSiri.shared.requestSiriPermission(callback: callback)
            } else {
                callback(.disabled("FZPermissionType.siri available iOS 10.0"))
            }
        default:
            callback(.disabled("unknown FZPermissionType: \(type)"))
        }
    }
    
}
