//
//  FZPermissionMicrophone.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/11/4.
//

import UIKit
import AVFoundation

public class FZPermissionMicrophone: NSObject {
    
    public static let shared = FZPermissionMicrophone()
    
    public var status: FZPermissionStatus{
        let status = AVAudioSession.sharedInstance().recordPermission
        
        switch status {
        case .undetermined:
            return .notDetermined
        case .denied:
            return .denied
        case .granted:
            return .authorized
        @unknown default:
            return .disabled("unkunown AVAudioSession recordPermission \(status)")
        }
    }
    
    public func requestMicrophonePermission(callback: @escaping FZPermissionCallBack){
        if !FZPermissionType.microphone.containsAllUsageDescriptionKeyInInfoPlist {
            callback(.disabled("WARNING: \(FZPermissionType.microphone.missingKeysDescription ?? "") not found in Info.plist"))
            return
        }
        
        if self.status == .authorized {
            callback(self.status)
        }else{
            AVAudioSession.sharedInstance().requestRecordPermission { [weak self](_) in
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
