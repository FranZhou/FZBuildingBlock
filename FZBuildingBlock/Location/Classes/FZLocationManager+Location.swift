//
//  FZLocationManager+Location.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation
import CoreLocation

// MARK: - Location

/// 定位
extension FZLocationManager {

    /**
     *  locationServicesEnabled
     *
     *  Discussion:
     *      Determines whether the user has location services enabled.
     *      If NO, and you proceed to call other CoreLocation API, user will be prompted with the warning
     *      dialog. You may want to check this property and use location services only when explicitly requested by the user.
     */
    @available(iOS 4.0, *)
    public func locationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }

    /**
     *  location
     *
     *  Discussion:
     *      The last location received. Will be nil until a location has been received.
     */
    public var location: CLLocation? {
        get {
            return locationManager.location
        }
    }

    /**
     *  startUpdatingLocation
     *
     *  Discussion:
     *      Start updating locations.
     */
    public func startUpdatingLocation() {
        if locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        } else {
            FZLocationConfiguration.locationLog?("CLLocationManager locationServicesEnabled is unavailable, you can't startUpdatingLocation")
        }
    }

    /**
     *  stopUpdatingLocation
     *
     *  Discussion:
     *      Stop updating locations.
     */
    public func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    /**
     *  requestLocation
     *
     *  Discussion:
     *      Request a single location update.
     *
     *      The service will attempt to determine location with accuracy according
     *      to the desiredAccuracy property.  The location update will be delivered
     *      via the standard delegate callback, i.e. locationManager:didUpdateLocations:
     *
     *      If the best available location has lower accuracy, then it will be
     *      delivered via the standard delegate callback after timeout.
     *
     *      If no location can be determined, the locationManager:didFailWithError:
     *      delegate callback will be delivered with error location unknown.
     *
     *      There can only be one outstanding location request and this method can
     *      not be used concurrently with startUpdatingLocation or
     *      allowDeferredLocationUpdates.  Calling either of those methods will
     *      immediately cancel the location request.  The method
     *      stopUpdatingLocation can be used to explicitly cancel the request.
     */
    @available(iOS 9.0, *)
    public func requestLocation() {
        if locationServicesEnabled() {
            locationManager.requestLocation()
        } else {
            FZLocationConfiguration.locationLog?("CLLocationManager locationServicesEnabled is unavailable, you can't requestLocation")
        }
    }

}

// MARK: - Monitoring Location

/// 显著位置变化
extension FZLocationManager {

    /*
     *  significantLocationChangeMonitoringAvailable
     *
     *  Discussion:
     *      Returns YES if the device supports significant location change monitoring, otherwise NO.
     */
    @available(iOS 4.0, *)
    public func significantLocationChangeMonitoringAvailable() -> Bool {
        return CLLocationManager.significantLocationChangeMonitoringAvailable()
    }

    /**
     *  startMonitoringSignificantLocationChanges
     *
     *  Discussion:
     *      Start monitoring significant location changes.  The behavior of this service is not affected by the desiredAccuracy
     *      or distanceFilter properties.  Locations will be delivered through the same delegate callback as the standard
     *      location service.
     *
     */
    @available(iOS 4.0, *)
    public func startMonitoringSignificantLocationChanges() {
        if locationServicesEnabled() {
            locationManager.startMonitoringSignificantLocationChanges()
        } else {
            FZLocationConfiguration.locationLog?("CLLocationManager significantLocationChangeMonitoringAvailable is unavailable, you can't startMonitoringSignificantLocationChanges")
        }
    }

    /**
     *  stopMonitoringSignificantLocationChanges
     *
     *  Discussion:
     *      Stop monitoring significant location changes.
     *
     */
    @available(iOS 4.0, *)
    public func stopMonitoringSignificantLocationChanges() {
        locationManager.stopMonitoringSignificantLocationChanges()
    }

}

// MARK: - Normal Control

/// Normal  Controlit
extension FZLocationManager {

    /**
     *    allowDeferredLocationUpdatesUntilTraveled:timeout:
     *
     *    Discussion:
     *        Indicate that the application will allow the location manager to defer
     *        location updates until an exit criterion is met. This may allow the
     *        device to enter a low-power state in which updates are held for later
     *        delivery. Once an exit condition is met, the location manager will
     *        continue normal updates until this method is invoked again.
     *
     *        Exit conditions, distance and timeout, can be specified using the constants
     *        CLLocationDistanceMax and CLTimeIntervalMax, respectively, if you are
     *        trying to achieve an unlimited distance or timeout.
     *
     *        The CLLocationManagerDelegate will continue to receive normal updates as
     *        long as the application remains in the foreground. While the process is
     *        in the background, the device may be able to enter a low-power state for
     *        portions of the specified distance and time interval. While in this
     *        state, locations will be coalesced for later delivery.
     *
     *        Location updates will be deferred as much as is reasonable to save
     *        power. If another process is using location, the device may not enter a
     *        low-power state and instead updates will continue normally. Deferred
     *        updates may be interspersed with normal updates if the device exits and
     *        re-enters a low-power state.
     *
     *        All location updates, including deferred updates, will be delivered via
     *        the delegate callback locationManager:didUpdateLocations:
     *
     *        When deferred updates have ended, the manager will invoke the delegate
     *        callback locationManagerDidFinishDeferredUpdates:withError:. An error
     *        will be returned if the manager will not defer updates and the exit
     *        criteria have not been met.
     */
    @available(iOS, introduced: 6.0, deprecated: 13.0, message: "You can remove calls to this method")
    public func allowDeferredLocationUpdates(untilTraveled distance: CLLocationDistance, timeout: TimeInterval) {
        locationManager.allowDeferredLocationUpdates(untilTraveled: distance, timeout: timeout)
    }

    /**
     *    disallowDeferredLocationUpdates
     *
     *    Discussion:
     *        Disallow deferred location updates if previously enabled. Any outstanding
     *        updates will be sent and regular location updates will resume.
     */
    @available(iOS, introduced: 6.0, deprecated: 13.0, message: "You can remove calls to this method")
    public func disallowDeferredLocationUpdates() {
        locationManager.disallowDeferredLocationUpdates()
    }

    /**
     *  deferredLocationUpdatesAvailable
     *
     *  Discussion:
     *      Returns YES if the device supports deferred location updates, otherwise NO.
     */
    @available(iOS, introduced: 6.0, deprecated: 13.0, message: "You can remove calls to this method")
    public func deferredLocationUpdatesAvailable() -> Bool {
        return CLLocationManager.deferredLocationUpdatesAvailable()
    }

}
