//
//  FZPermissionType.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/10/31.
//

import UIKit
import EventKit

/// location type
/// - locationAlways: 使用app的时候使用位置信息
/// - locationWhenInUse: 允许app一直使用位置信息
public enum FZPermissionLocationType: CustomStringConvertible {
    case locationAlways
    case locationWhenInUse

    public var description: String {
        switch self {
        case .locationAlways:
            return "LocationAlways"
        case .locationWhenInUse:
            return "LocationWhenInUse"
        }
    }
}

/// event type，对应 EKEntityType
/// - event: 日历事件
/// - reminder: 提醒事项
public enum FZPermissionEventType: CustomStringConvertible {
    case event
    case reminder

    public var description: String {
        switch self {
        case .event:
            return "Event"
        case .reminder:
            return "Reminder"
        }
    }
}

/// contacts type， 对应CNEntityType
/// - contacts: The user's contacts.
public enum FZPermissionContactsType: CustomStringConvertible {
    case contacts

    public var description: String {
        switch self {
        case .contacts:
            return "Contacts"
        }
    }
}

// MARK: -

public enum FZPermissionType {

    @available(iOS, introduced: 2.0, deprecated: 9.0) case addressBook

    @available(iOS 9.0, *) case contacts(FZPermissionContactsType)

    case location(FZPermissionLocationType)

    case notifications(UIUserNotificationSettings)

    case microphone

    case camera

    case photoLibrary

    case event(FZPermissionEventType)

    case bluetooth

    case motion

    @available(iOS 10.0, *) case speechRecognizer

    @available(iOS 9.3, *) case mediaLibrary

    @available(iOS 10.0, *) case siri
}

extension FZPermissionType{
    
    var usageDescriptionKey: [String]?{
        switch self {
        case .addressBook:
            return ["NSContactsUsageDescription"]
        case .contacts(_):
            return ["NSContactsUsageDescription"]
        case .location(let locationType):
            switch locationType {
            case .locationAlways:
                return ["NSLocationAlwaysUsageDescription", "NSLocationWhenInUseUsageDescription", "NSLocationAlwaysAndWhenInUseUsageDescription"]
            case .locationWhenInUse:
                return ["NSLocationWhenInUseUsageDescription"]
            }
        case .notifications(_):
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
    
    var containsAllUsageDescriptionKeyInInfoPlist: Bool{
        if let missingKeys = self.missingKeysInInfoPlist{
            return missingKeys.count == 0
        }else{
            return true
        }
    }
    
    var missingKeysInInfoPlist: [String]?{
        if let usageDescriptionKey = self.usageDescriptionKey {
            let missingKeys = usageDescriptionKey.filter { (descriptionKey) -> Bool in
                if let _ = Bundle.main.object(forInfoDictionaryKey: descriptionKey){
                    return false
                }else{
                    return true
                }
            }
            return missingKeys
        }else{
            return nil
        }
    }
    
    var missingKeysDescription: String?{
        if let missingKeys = self.missingKeysInInfoPlist{
            return "\(missingKeys.joined(separator: ", "))"
        }
        return nil
    }
    
}
