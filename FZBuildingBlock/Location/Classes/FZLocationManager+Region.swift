//
//  FZLocationManager+Region.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation
import CoreLocation

// MARK: - BeaconRegion

/// BeaconRegion
extension FZLocationManager {

    /**
     *  isRangingAvailable
     *
     *  Discussion:
     *      Determines whether the device supports ranging.
     *      If NO, all attempts to range beacons will fail.
     */
    @available(iOS 7.0, *)
    public func isRangingAvailable() -> Bool {
        return CLLocationManager.isRangingAvailable()
    }

    /*
     *  rangedRegions
     *
     *  Discussion:
     *       Retrieve a set of objects representing the regions for which this location manager is actively providing ranging.
     */
    @available(iOS, introduced: 7.0, deprecated: 13.0, message: "Use -rangedBeaconConstraints")
    public var rangedRegions: Set<CLRegion> {
        get {
            return locationManager.rangedRegions
        }
    }

    /*
     *  rangedBeaconConstraints
     *
     *  Discussion:
     *      Retrieve a set of beacon constraints for which this location manager is actively providing ranging.
     */
    @available(iOS 13.0, *)
    public var rangedBeaconConstraints: Set<CLBeaconIdentityConstraint> {
        get {
            return locationManager.rangedBeaconConstraints
        }
    }

    /**
     *  startRangingBeaconsInRegion:
     *
     *  Discussion:
     *      Start calculating ranges for beacons in the specified region.
     */
    @available(iOS, introduced: 7.0, deprecated: 13.0, message: "Use -startRangingBeaconsSatisfyingConstraint:")
    public func startRangingBeacons(in region: CLBeaconRegion) {
        if isRangingAvailable() {
            locationManager.startRangingBeacons(in: region)
        } else {
            FZLocationConfiguration.locationLog?("CLLocationManager isRangingAvailable is unavailable, you can't startRangingBeacons")
        }
    }

    /**
     *  stopRangingBeaconsInRegion:
     *
     *  Discussion:
     *      Stop calculating ranges for the specified region.
     */
    @available(iOS, introduced: 7.0, deprecated: 13.0, message: "Use -stopRangingBeaconsSatisfyingConstraint:")
    public func stopRangingBeacons(in region: CLBeaconRegion) {
        locationManager.stopRangingBeacons(in: region)
    }

    /**
     *  startRangingBeaconsSatisfyingConstraint:
     *
     *  Discussion:
     *      Start producing ranging measurements for beacons that satisfy
     *      the provided constraint.  Ranging will continue until you pass
     *      an equivalent constraint to stopRangingBeaconsSatisfyingConstraint:.
     */
    @available(iOS 13.0, *)
    public func startRangingBeacons(satisfying constraint: CLBeaconIdentityConstraint) {
        if isRangingAvailable() {
            locationManager.startRangingBeacons(satisfying: constraint)
        } else {
            FZLocationConfiguration.locationLog?("CLLocationManager isRangingAvailable is unavailable, you can't startRangingBeacons")
        }
    }

    /**
     *  stopRangingBeaconsSatisfyingConstraint:
     *
     *  Discussion:
     *      Stop an earlier beacon ranging request.  See startRangingBeaconsSatisfyingConstraint:.
     */
    @available(iOS 13.0, *)
    public func stopRangingBeacons(satisfying constraint: CLBeaconIdentityConstraint) {
        locationManager.stopRangingBeacons(satisfying: constraint)
    }

}

// MARK: - Monitoring For Region

/// Region
extension FZLocationManager {

    /**
     *  isMonitoringAvailableForClass:
     *
     *  Discussion:
     *      Determines whether the device supports monitoring for the specified type of region.
     *      If NO, all attempts to monitor the specified type of region will fail.
     */
    @available(iOS 7.0, *)
    public func isMonitoringAvailableForClass(for regionClass: AnyClass) -> Bool {
        return CLLocationManager.isMonitoringAvailable(for: regionClass)
    }

    /**
     *  monitoredRegions
     *
     *  Discussion:
     *       Retrieve a set of objects for the regions that are currently being monitored.  If any location manager
     *       has been instructed to monitor a region, during this or previous launches of your application, it will
     *       be present in this set.
     */
    @available(iOS 4.0, *)
    public var monitoredRegions: Set<CLRegion> {
        get {
            return locationManager.monitoredRegions
        }
    }

    /**
     *  startMonitoringForRegion:
     *
     *  Discussion:
     *      Start monitoring the specified region.
     *
     *      If a region of the same type with the same identifier is already being monitored for this application,
     *      it will be removed from monitoring. For circular regions, the region monitoring service will prioritize
     *      regions by their size, favoring smaller regions over larger regions.
     *
     *      This is done asynchronously and may not be immediately reflected in monitoredRegions.
     */
    @available(iOS 5.0, *)
    public func startMonitoring(for region: CLRegion) {
        locationManager.startMonitoring(for: region)
    }

    /**
     *  stopMonitoringForRegion:
     *
     *  Discussion:
     *      Stop monitoring the specified region.  It is valid to call stopMonitoringForRegion: for a region that was registered
     *      for monitoring with a different location manager object, during this or previous launches of your application.
     *
     *      This is done asynchronously and may not be immediately reflected in monitoredRegions.
     */
    @available(iOS 4.0, *)
    public func stopMonitoring(for region: CLRegion) {
        locationManager.stopMonitoring(for: region)
    }

    /**
     *  requestStateForRegion:
     *
     *  Discussion:
     *      Asynchronously retrieve the cached state of the specified region. The state is returned to the delegate via
     *      locationManager:didDetermineState:forRegion:.
     */
    @available(iOS 7.0, *)
    public func requestState(for region: CLRegion) {
        locationManager.requestState(for: region)
    }

}
