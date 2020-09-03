//
//  FZLocationManager+Visit.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation
import CoreLocation

// MARK: - Visit

/// Visit
extension FZLocationManager {

    /**
     *  startMonitoringVisits
     *
     *  Discussion:
     *    Begin monitoring for visits.  All CLLLocationManagers allocated by your
     *    application, both current and future, will deliver detected visits to
     *    their delegates.  This will continue until -stopMonitoringVisits is sent
     *    to any such CLLocationManager, even across application relaunch events.
     *
     *    Detected visits are sent to the delegate's -locationManager:didVisit:
     *    method.
     */
    @available(iOS 8.0, *)
    public func startMonitoringVisits() {
        locationManager.startMonitoringVisits()
    }

    /**
     *  stopMonitoringVisits
     *
     *  Discussion:
     *    Stop monitoring for visits.  To resume visit monitoring, send
     *    -startMonitoringVisits.
     *
     *    Note that stopping and starting are asynchronous operations and may not
     *    immediately reflect in delegate callback patterns.
     */
    @available(iOS 8.0, *)
    public func stopMonitoringVisits() {
        locationManager.stopMonitoringVisits()
    }

}
