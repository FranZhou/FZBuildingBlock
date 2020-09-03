//
//  FZLocationManager+Authorization.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/28.
//

import Foundation
import CoreLocation

// MARK: - 定位权限

/// 权限判断
extension FZLocationManager {

    /**
     * 当前用户权限
     * authorizationStatus
     *
     *  Discussion:
     *      Returns the current authorization status of the calling application.
     */
    @available(iOS 4.2, *)
    public class func authorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }

    /// 是否开启了定位权限
    public class func checkAndRequestAuthorized() -> Bool {
        let status = authorizationStatus()
        switch  status {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .denied, .restricted:
            FZLocationConfiguration.locationAuthorizationAction?(status)
            return false
        case .notDetermined:
            FZLocationManager.default.request(authorizationType: FZLocationConfiguration.requestAuthorizationType)
            return false
        default:
            FZLocationConfiguration.locationAuthorizationAction?(status)
            return false
        }
    }

    /// 是否开启了 Always 定位权限
    public class func checkAndRequestAuthorizedAlways() -> Bool {
        let status = authorizationStatus()
        switch status {
        case .authorizedAlways:
            return true
        case .notDetermined:
            FZLocationManager.default.request(authorizationType: .always)
            return false
        default:
            FZLocationConfiguration.locationAuthorizationAction?(status)
            return false
        }
    }

    /// 是否开启了 WhenInUse 定位权限
    public class func checkAndRequestAuthorizedWhenInUse() -> Bool {
        let status = authorizationStatus()
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            return true
        case .notDetermined:
            FZLocationManager.default.request(authorizationType: .whenInUse)
            return false
        default:
            FZLocationConfiguration.locationAuthorizationAction?(status)
            return false
        }
    }

}

/// 请求权限
extension FZLocationManager {

    /// 请求定位权限
    public func request(authorizationType type: FZLocationManager.AuthorizationType) {
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
            FZLocationConfiguration.locationLog?("missing necessary configuration: \(missingKeys.joined(separator: ", "))")

            let controller = UIAlertController(title: "缺少配置信息", message: "info.plist文件缺少必要配置：\(missingKeys)", preferredStyle: UIAlertController.Style.alert)
            controller.addAction(UIAlertAction(title: "知道了", style: UIAlertAction.Style.default, handler: nil))
            UIApplication.shared.delegate?.window??.rootViewController?.present(controller, animated: true, completion: nil)
        } else {
            switch type {
            case .whenInUse:
                requestWhenInUseAuthorization()
            case .always:
                requestAlwaysAuthorization()
            }
        }
    }

    /*
     *  requestWhenInUseAuthorization
     *
     *  Discussion:
     *      When +authorizationStatus == kCLAuthorizationStatusNotDetermined,
     *      calling this method will trigger a prompt to request "when-in-use"
     *      authorization from the user.  Any authorization change as a result of
     *      the prompt will be reflected via the usual delegate callback:
     *      -locationManager:didChangeAuthorizationStatus:.
     *
     *      If possible, perform this call in response to direct user request for a
     *      location-based service so that the reason for the prompt will be clear,
     *      and the utility of a one-time grant is maximized.
     *
     *      If received, "when-in-use" authorization grants access to the user's
     *      location via any CoreLocation API as long as your app is being actively
     *      used by the user.  Typically this means your app must be in the
     *      foreground.  If you start a Continuous Background Location session (see
     *      -allowsBackgroundLocationUpdates), then CoreLocation will maintain
     *      visibility for your app as it enters the background.  This will enable
     *      your app to continue receiving location information even as another app
     *      enters the foreground.  Your app will remain visible in this way until
     *      location updates are stopped or your app is killed by the user.
     *
     *      When +authorizationStatus != kCLAuthorizationStatusNotDetermined, (ie
     *      generally after the first call) this method will do nothing.
     *
     *      If your app is not currently in use, this method will do nothing.
     *
     *      The NSLocationWhenInUseUsageDescription key must be specified in your
     *      Info.plist; otherwise, this method will do nothing, as your app will be
     *      assumed not to support WhenInUse authorization.
     */
    @available(iOS 8.0, *)
    public func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    /*
     *  requestAlwaysAuthorization
     *
     *  Discussion:
     *      When +authorizationStatus == kCLAuthorizationStatusNotDetermined,
     *      calling this method will start the process of requesting "always"
     *      authorization from the user.  Any authorization change as a result of
     *      the prompt will be reflected via the usual delegate callback:
     *      -locationManager:didChangeAuthorizationStatus:.
     *
     *      If possible, perform this call in response to direct user request for a
     *      location-based service so that the reason for the prompt will be clear,
     *      and the utility of a one-time grant is maximized.
     *
     *      If received, "always" authorization grants access to the user's location
     *      via any CLLocationManager API.  In addition, monitoring APIs may launch
     *      your app into the background when they detect an event.  Even if killed by
     *      the user, launch events triggered by monitoring APIs will cause a
     *      relaunch.
     *
     *      "Always" authorization presents a significant risk to user privacy, and
     *      as such requesting it is discouraged unless background launch behavior
     *      is genuinely required.  Do not call +requestAlwaysAuthorization unless
     *      you think users will thank you for doing so.
     *
     *      An application which currently has "when-in-use" authorization and has
     *      never before requested "always" authorization may use this method to
     *      request "always" authorization one time only.  Otherwise, if
     *      +authorizationStatus != kCLAuthorizationStatusNotDetermined, (ie
     *      generally after the first call) this method will do nothing.
     *
     *      If your app is not currently in use, this method will do nothing.
     *
     *      Both the NSLocationAlwaysAndWhenInUseUsageDescription and
     *      NSLocationWhenInUseUsageDescription keys must be specified in your
     *      Info.plist; otherwise, this method will do nothing, as your app will be
     *      assumed not to support Always authorization.
     */
    @available(iOS 8.0, *)
    public func requestAlwaysAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }

}
