//
//  FZPermissionLocation.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/10/31.
//

import UIKit
import CoreLocation

public class FZPermissionLocation: NSObject {

    public static let shared = FZPermissionLocation()

    private var locationManagerArray: [FZPermissionLocationManager] = []

    public func status(for type: FZPermissionLocationType) -> FZPermissionStatus {
        guard CLLocationManager.locationServicesEnabled() else {
            return .disabled("CLLocationManager locationServicesEnabled is false")
        }

        let status = CLLocationManager.authorizationStatus()

        return FZPermissionLocationManager.transformStatus(for: type, status: status)

    }

    public func requestLocationPermision(for type: FZPermissionLocationType, callback: @escaping FZPermissionCallBack) {
        guard FZPermissionType.location(type).containsAllUsageDescriptionKeyInInfoPlist else{
            callback(.disabled("WARNING: \(FZPermissionType.location(type).missingKeysDescription ?? "") not found in Info.plist"))
            return
        }

        if self.status(for: type) == .authorized {
            callback(.authorized)
        } else {
            let locationManager = FZPermissionLocationManager.init(type: type) { [weak self](manager, status) in
                guard let `self` = self else {
                        return
                }

                if manager.type == type {
                    DispatchQueue.main.async {
                        callback(status)
                    }
                }

                DispatchQueue.main.async {
                    self.locationManagerArray.removeAll { $0 == manager }
                }
            }

            locationManagerArray.append(locationManager)
        }

    }
}

// MARK: - FZPermissionLocationManager
private class FZPermissionLocationManager: NSObject {

    typealias FZPermissionLocationManagerCallBack = (FZPermissionLocationManager, FZPermissionStatus) -> Void

    let type: FZPermissionLocationType
    let callback: FZPermissionLocationManagerCallBack

    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        return lm
    }()

    init(type: FZPermissionLocationType, callback: @escaping FZPermissionLocationManagerCallBack) {
        self.type = type
        self.callback = callback
        super.init()

        switch type {
        case .always:
            locationManager.requestAlwaysAuthorization()
        case .whenInUse:
            locationManager.requestWhenInUseAuthorization()
        }

    }

    static func transformStatus(for type: FZPermissionLocationType, status: CLAuthorizationStatus) -> FZPermissionStatus {
        switch status {
        case .denied:
            return .denied
        case .restricted:
            return .restricted
        case .notDetermined:
            return .notDetermined
        case .authorizedAlways:
            return .authorized
        case .authorizedWhenInUse:
            if type == .whenInUse {
                return .authorized
            } else {
                return .notDetermined
            }
        @unknown default:
            return .disabled("unknown CLLocationManager authorization Status : \(status)")
        }
    }

}

extension FZPermissionLocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        let permissionStatus = FZPermissionLocationManager.transformStatus(for: type, status: status)
        callback(self, permissionStatus)
    }

}
