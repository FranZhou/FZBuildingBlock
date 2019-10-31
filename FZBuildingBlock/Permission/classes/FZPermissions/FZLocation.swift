//
//  FZLocation.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2019/10/31.
//

import UIKit
import CoreLocation

public class FZLocation {

    static let locationWhenInUseUsageDescription = "NSLocationWhenInUseUsageDescription"
    static let locationAlwaysUsageDescription    = "NSLocationAlwaysUsageDescription"

    public static let shared = FZLocation()

    private var locationManagerArray: [FZLocationManager] = []

    public func status(for type: FZPermissionLocationType) -> FZPermissionStatus {
        guard CLLocationManager.locationServicesEnabled() else {
            return .disabled("CLLocationManager locationServicesEnabled is false")
        }

        let status = CLLocationManager.authorizationStatus()

        return FZLocationManager.transformStatus(for: type, status: status)

    }

    public func requestLocationPermision(for type: FZPermissionLocationType, callback: @escaping FZPermissionCallBack) {
        var locationKey = FZLocation.locationWhenInUseUsageDescription
        switch type {
        case .locationAlways:
            locationKey = FZLocation.locationAlwaysUsageDescription
        case .locationWhenInUse:
            locationKey = FZLocation.locationWhenInUseUsageDescription
        }

        guard let _ = Bundle.main.object(forInfoDictionaryKey: locationKey) else {
            callback(.disabled("WARNING: \(locationKey) not found in Info.plist"))
            return
        }

        if self.status(for: type) == .authorized {
            callback(.authorized)
        } else {
            let locationManager = FZLocationManager.init(type: type) { [weak self](manager, status) in
                guard let `self` = self else {
                        return
                }

                if manager.type == type {
                    callback(status)
                }

                DispatchQueue.main.async { [weak self] in
                    self?.locationManagerArray.removeAll { $0 == manager }
                }
            }

            locationManagerArray.append(locationManager)
        }

    }
}

// MARK: - FZLocationManager
private class FZLocationManager: NSObject {

    typealias FZLocationManagerCallBack = (FZLocationManager, FZPermissionStatus) -> Void

    let type: FZPermissionLocationType
    let callback: FZLocationManagerCallBack

    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        return lm
    }()

    init(type: FZPermissionLocationType, callback: @escaping FZLocationManagerCallBack) {
        self.type = type
        self.callback = callback
        super.init()

        switch type {
        case .locationAlways:
            locationManager.requestAlwaysAuthorization()
        case .locationWhenInUse:
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
            if type == .locationWhenInUse {
                return .authorized
            } else {
                return .notDetermined
            }
        @unknown default:
            return .disabled("unknown CLLocationManager authorization Status : \(status)")
        }
    }

}

extension FZLocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        let permissionStatus = FZLocationManager.transformStatus(for: type, status: status)
        callback(self, permissionStatus)
    }

}
