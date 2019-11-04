//
//  FZPermissionType.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/10/31.
//

import UIKit
import Contacts
import EventKit

/// location type
/// - locationAlways: 使用app的时候使用位置信息
/// - locationWhenInUse: 允许app一直使用位置信息
public enum FZPermissionLocationType: CustomStringConvertible {
    case always
    case whenInUse

    public var description: String {
        switch self {
        case .always:
            return "Always"
        case .whenInUse:
            return "WhenInUse"
        }
    }
}

public struct FZPermissionNotificationOptions: OptionSet{
    
    public typealias RawValue = Int

    public var rawValue: RawValue

    public init(rawValue: FZViewBorderLineSideType.RawValue) {
        self.rawValue = rawValue
    }
    
    public static var badge: FZPermissionNotificationOptions = FZPermissionNotificationOptions(rawValue: 1 << 0)

    public static var sound: FZPermissionNotificationOptions = FZPermissionNotificationOptions(rawValue: 1 << 1)

    public static var alert: FZPermissionNotificationOptions = FZPermissionNotificationOptions(rawValue: 1 << 2)

    public static var carPlay: FZPermissionNotificationOptions = FZPermissionNotificationOptions(rawValue: 1 << 3)

    @available(iOS 12.0, *)
    public static var criticalAlert: FZPermissionNotificationOptions = FZPermissionNotificationOptions(rawValue: 1 << 4)

    @available(iOS 12.0, *)
    public static var providesAppNotificationSettings: FZPermissionNotificationOptions = FZPermissionNotificationOptions(rawValue: 1 << 5)

    @available(iOS 12.0, *)
    public static var provisional: FZPermissionNotificationOptions = FZPermissionNotificationOptions(rawValue: 1 << 6)

    @available(iOS 13.0, *)
    public static var announcement: FZPermissionNotificationOptions = FZPermissionNotificationOptions(rawValue: 1 << 7)
}

// MARK: -

public enum FZPermissionType {

    @available(iOS, introduced: 2.0, deprecated: 9.0) case addressBook

    @available(iOS 9.0, *) case contacts(CNEntityType)

    case location(FZPermissionLocationType)

    case notification(FZPermissionNotificationOptions)

    case microphone

    case camera

    case photoLibrary

    case event(EKEntityType)

    case bluetooth

    case motion

    @available(iOS 10.0, *) case speechRecognizer

    @available(iOS 9.3, *) case mediaLibrary

    @available(iOS 10.0, *) case siri
}

extension FZPermissionType {

    var usageDescriptionKey: [String]? {
        switch self {
        case .addressBook:
            return ["NSContactsUsageDescription"]
        case .contacts:
            return ["NSContactsUsageDescription"]
        case .location(let locationType):
            switch locationType {
            case .always:
                return [/*"NSLocationAlwaysUsageDescription",*/ "NSLocationWhenInUseUsageDescription", "NSLocationAlwaysAndWhenInUseUsageDescription"]
            case .whenInUse:
                return ["NSLocationWhenInUseUsageDescription"]
            }
        case .notification(_):
            return nil
        case .microphone:
            return ["NSMicrophoneUsageDescription"]
        case .camera:
            return ["NSCameraUsageDescription"]
        case .photoLibrary:
            return ["NSPhotoLibraryUsageDescription"]
        case .event(let eventType):
            switch eventType {
            case .event:
                return ["NSCalendarsUsageDescription"]
            case .reminder:
                return ["NSRemindersUsageDescription"]
            @unknown default:
                return nil
            }
        case .bluetooth:
            return nil
        case .motion:
            return ["NSMotionUsageDescription"]
        case .speechRecognizer:
            return ["NSSpeechRecognitionUsageDescription"]
        case .mediaLibrary:
            return ["NSAppleMusicUsageDescription"]
        case .siri:
            return ["NSSiriUsageDescription"]
        }
    }

    var containsAllUsageDescriptionKeyInInfoPlist: Bool {
        return true
//        if let missingKeys = self.missingKeysInInfoPlist {
//            return missingKeys.count == 0
//        } else {
//            return true
//        }
    }

    var missingKeysInInfoPlist: [String]? {
        if let usageDescriptionKey = self.usageDescriptionKey {
            let missingKeys = usageDescriptionKey.filter { (descriptionKey) -> Bool in
                if let _ = Bundle.main.object(forInfoDictionaryKey: descriptionKey) {
                    return false
                } else {
                    return true
                }
            }
            return missingKeys
        } else {
            return nil
        }
    }

    var missingKeysDescription: String? {
        if let missingKeys = self.missingKeysInInfoPlist {
            return "\(missingKeys.joined(separator: ", "))"
        }
        return nil
    }

}
