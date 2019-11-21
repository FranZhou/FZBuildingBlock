//
//  FZPermissionNotification.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/11/1.
//

import UIKit
import UserNotifications

public class FZPermissionNotification: NSObject {
    
    public static let shared = FZPermissionNotification()
    
    public var status: FZPermissionStatus {
        if #available(iOS 10.0, *) {
            var notificationSettings: UNNotificationSettings?
            let semaphore = DispatchSemaphore(value: 0)
            
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                notificationSettings = settings
                semaphore.signal()
            }
            semaphore.wait()
            
            if let status = notificationSettings?.authorizationStatus {
                switch status {
                case .notDetermined:
                    return .notDetermined
                case .authorized:
                    return .authorized
                case .provisional:
                    return .authorized
                case .denied:
                    return .denied
                @unknown default:
                    return .disabled("unkunown UNNotificationSettings authorizationStatus \(status)")
                }
            } else {
                return .disabled("can't get UNNotificationSettings authorizationStatus")
            }
            
        } else {
            
            if let notificationSettings = UIApplication.shared.currentUserNotificationSettings {
                
                if notificationSettings.types.isEmpty {
                    return .disabled("empty UIApplication currentUserNotificationSettings")
                } else {
                    return .authorized
                }
                
            } else {
                return .disabled("can't get UIApplication currentUserNotificationSettings")
            }
        }
        
    }
    
    public func requestNotificationPermision(for type: FZPermissionNotificationOptions, callback: @escaping FZPermissionCallBack) {
        guard FZPermissionType.notification(type).containsAllUsageDescriptionKeyInInfoPlist else{
            callback(.disabled("WARNING: \(FZPermissionType.notification(type).missingKeysDescription ?? "") not found in Info.plist"))
            return
        }
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: self.transformToAuthorizationOptions(type)) { [weak self] (granted, error) in
                guard let `self` = self else {
                    return
                }
                DispatchQueue.main.async {
                    callback(self.status)
                }
            }
        } else {
            UIApplication.shared.registerUserNotificationSettings(self.transformToUserNotificationSettings(type))
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else {
                    return
                }
                callback(self.status)
            }
        }
        
        UIApplication.shared.registerForRemoteNotifications()
        
    }
    
}

extension FZPermissionNotification{
    
    @available(iOS 10.0, *)
    fileprivate func transformToAuthorizationOptions(_ type: FZPermissionNotificationOptions) -> UNAuthorizationOptions{
        var options: UNAuthorizationOptions = []
        
        if type.contains(.badge){
            options.insert(.badge)
        }
        
        if type.contains(.sound){
            options.insert(.sound)
        }
        
        if type.contains(.alert){
            options.insert(.alert)
        }
        
        if type.contains(.carPlay){
            options.insert(.carPlay)
        }
        
        if #available(iOS 12.0, *) {
            if type.contains(.criticalAlert){
                options.insert(.criticalAlert)
            }
        }
        
        if #available(iOS 12.0, *) {
            if type.contains(.providesAppNotificationSettings){
                options.insert(.providesAppNotificationSettings)
            }
        }
        
        if #available(iOS 12.0, *) {
            if type.contains(.provisional){
                options.insert(.provisional)
            }
        }
        
        if #available(iOS 13.0, *) {
            if type.contains(.announcement){
                options.insert(.announcement)
            }
        }
        
        return options
    }
    
    @available(iOS, introduced: 8.0, deprecated: 10.0)
    fileprivate func transformToUserNotificationSettings(_ type: FZPermissionNotificationOptions) -> UIUserNotificationSettings{
        
        var userType: UIUserNotificationType = []
        
        if type.contains(.badge){
            userType.insert(.badge)
        }
        
        if type.contains(.sound){
            userType.insert(.sound)
        }
        
        if type.contains(.alert){
            userType.insert(.alert)
        }
        
        return UIUserNotificationSettings(types: userType, categories: nil)
    }
}
