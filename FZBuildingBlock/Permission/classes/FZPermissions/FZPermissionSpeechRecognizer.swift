//
//  FZPermissionSpeechRecognizer.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/11/20.
//

import Foundation
import Speech

@available(iOS 10.0, *)
public class FZPermissionSpeechRecognizer: NSObject {

    public static let shared = FZPermissionSpeechRecognizer()

    public var status: FZPermissionStatus {
        let status = SFSpeechRecognizer.authorizationStatus()

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

    public func requestSpeechRecognizerPermission(callback: @escaping FZPermissionCallBack) {
        guard FZPermissionType.speechRecognizer.containsAllUsageDescriptionKeyInInfoPlist else{
            callback(.disabled("WARNING: \(FZPermissionType.speechRecognizer.missingKeysDescription ?? "") not found in Info.plist"))
            return
        }

        if status == .authorized {
            callback(.authorized)
        } else {
            SFSpeechRecognizer.requestAuthorization { [weak self](status: SFSpeechRecognizerAuthorizationStatus) in
                guard let `self` = self else{
                    return
                }
                DispatchQueue.main.async {
                    callback(self.status)
                }
            }
        }

    }

}
