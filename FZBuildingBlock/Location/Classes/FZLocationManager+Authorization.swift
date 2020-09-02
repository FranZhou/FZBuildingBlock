//
//  FZLocationManager+Authorization.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/28.
//

import Foundation
import CoreLocation

// MARK: - 定位权限
extension FZLocationManager {

    /// 当前用户权限
    open var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }

    /// 是否开启了定位权限
    open var checkAndOpenAuthorized: Bool {
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .denied, .restricted:
            FZLocationConfiguration.locationAuthorizationAction?(authorizationStatus)
            return false
        case .notDetermined:
            request(authorizationType: FZLocationConfiguration.requestAuthorizationType)
            return false
        default:
            FZLocationConfiguration.locationAuthorizationAction?(authorizationStatus)
            return false
        }
    }

    /// 是否开启了 Always 定位权限
    open var checkAndOpenAuthorizedAlways: Bool {
        switch authorizationStatus {
        case .authorizedAlways:
            return true
        case .notDetermined:
            request(authorizationType: .always)
            return false
        default:
            FZLocationConfiguration.locationAuthorizationAction?(authorizationStatus)
            return false
        }
    }

    /// 是否开启了 WhenInUse 定位权限
    open var checkAndOpenAuthorizedWhenInUse: Bool {
        switch authorizationStatus {
        case .authorizedWhenInUse:
            return true
        case .notDetermined:
            request(authorizationType: .whenInUse)
            return false
        default:
            FZLocationConfiguration.locationAuthorizationAction?(authorizationStatus)
            return false
        }
    }

    /// 请求定位权限
    open func request(authorizationType type: FZLocationManager.AuthorizationType) {
        var usageDescriptionKey: [String] = []

        switch type {
        case .whenInUse:
            usageDescriptionKey.append("NSLocationWhenInUseUsageDescription")
        case .always:
            usageDescriptionKey.append("NSLocationWhenInUseUsageDescription")
            if #available(iOS 11.0, *) {
                usageDescriptionKey.append("NSLocationAlwaysAndWhenInUseUsageDescription")
            } else {
                usageDescriptionKey.append("NSLocationAlwaysUsageDescription")
            }
        }

        let missingKeys = usageDescriptionKey.filter { (descriptionKey) -> Bool in
            if let _ = Bundle.main.object(forInfoDictionaryKey: descriptionKey) {
                return false
            } else {
                return true
            }
        }

        if missingKeys.count > 0 {
            let controller = UIAlertController(title: "缺少配置信息", message: "info.plist文件缺少必要配置：\(missingKeys)", preferredStyle: UIAlertController.Style.alert)
            controller.addAction(UIAlertAction(title: "知道了", style: UIAlertAction.Style.default, handler: nil))
            UIApplication.shared.delegate?.window??.rootViewController?.present(controller, animated: true, completion: nil)
        } else {
            switch type {
            case .whenInUse:
                locationManager.requestWhenInUseAuthorization()
            case .always:
                locationManager.requestAlwaysAuthorization()
            }
        }
    }

}
