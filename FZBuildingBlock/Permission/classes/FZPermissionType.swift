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

    case photos

    case event(FZPermissionEventType)

    case bluetooth

    case motion

    @available(iOS 10.0, *) case speechRecognizer

    @available(iOS 9.3, *) case mediaLibrary

    @available(iOS 10.0, *) case siri
}
