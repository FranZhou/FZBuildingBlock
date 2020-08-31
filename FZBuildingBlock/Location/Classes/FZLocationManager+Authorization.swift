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
        switch type {
        case .whenInUse:
            locationManager.requestWhenInUseAuthorization()
        case .always:
            locationManager.requestAlwaysAuthorization()
        }
    }

}
