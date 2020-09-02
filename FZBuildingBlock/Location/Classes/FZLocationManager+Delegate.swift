//
//  FZLocationManager+Delegate.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/28.
//

import Foundation
import CoreLocation

// MARK: - CLLocationManagerDelegate
extension FZLocationManager: CLLocationManagerDelegate {

    // MARK: - location

    /**
     *  位置更新
     *  locationManager:didUpdateLocations:
     *
     *  Discussion:
     *    Invoked when new locations are available.  Required for delivery of
     *    deferred locations.  If implemented, updates will
     *    not be delivered to locationManager:didUpdateToLocation:fromLocation:
     *
     *    locations is an array of CLLocation objects in chronological order.
     */
    @available(iOS 6.0, *)
    open func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        userLocation.wrappedValue = location
    }

    // MARK: - Location Error

    /**
     *  定位失败
     *  locationManager:didFailWithError:
     *
     *  Discussion:
     *    Invoked when an error has occurred. Error types are defined in "CLError.h".
     */
    @available(iOS 2.0, *)
    open func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        userLocationFail.wrappedValue = FZLocationError(error: error)
    }

    // MARK: - heading

    /**
     *  方向的更新
     *  locationManager:didUpdateHeading:
     *
     *  Discussion:
     *    Invoked when a new heading is available.
     */
    @available(iOS 3.0, *)
    open func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        userHeading.wrappedValue = newHeading
    }

    /**
     *  用于判断是否显示方向的校对,返回yes的时候，将会校对正确之后才会停止，或者dismissheadingcalibrationdisplay方法解除。
     *  locationManagerShouldDisplayHeadingCalibration:
     *
     *  Discussion:
     *    Invoked when a new heading is available. Return YES to display heading calibration info. The display
     *    will remain until heading is calibrated, unless dismissed early via dismissHeadingCalibrationDisplay.
     */
    @available(iOS 3.0, *)
    open func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return FZLocationConfiguration.shouldDisplayHeadingCalibration
    }

    // MARK: - BeaconRegion

    /*
     *  locationManager:didRangeBeacons:inRegion:
     *
     *  Discussion:
     *    Invoked when a new set of beacons are available in the specified region.
     *    beacons is an array of CLBeacon objects.
     *    If beacons is empty, it may be assumed no beacons that match the specified region are nearby.
     *    Similarly if a specific beacon no longer appears in beacons, it may be assumed the beacon is no longer received
     *    by the device.
     */
    @available(iOS, introduced: 7.0, deprecated: 13.0)
    open func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        userBeaconRegion.wrappedValue = (beacons, region)
    }

    /*
     *  locationManager:rangingBeaconsDidFailForRegion:withError:
     *
     *  Discussion:
     *    Invoked when an error has occurred ranging beacons in a region. Error types are defined in "CLError.h".
     */
    @available(iOS, introduced: 7.0, deprecated: 13.0)
    open func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        userBeaconRegionFail.wrappedValue = (region, FZLocationError(error: error))
    }

    // MARK: - BeaconRegion for iOS 13

    /// locationManager:didRangeBeacons:satisfyingConstraint:
    @available(iOS 13.0, *)
    open func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        userBeaconConstraint.wrappedValue = (beacons, beaconConstraint)
    }

    /// locationManager:didFailRangingBeaconsForConstraint:error:
    @available(iOS 13.0, *)
    open func locationManager(_ manager: CLLocationManager, didFailRangingFor beaconConstraint: CLBeaconIdentityConstraint, error: Error) {
        userBeaconConstraintFail.wrappedValue = (beaconConstraint, FZLocationError(error: error))
    }

    // MARK: - Monitoring For Region

    /**
     *  开始监控某个区域时调用
     *  locationManager:didStartMonitoringForRegion:
     *
     *  Discussion:
     *    Invoked when a monitoring for a region started successfully.
     */
    @available(iOS 5.0, *)
    open func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        userRegionMonitorStart.wrappedValue = region
    }

    /**
     *  进入监控区域时调用
     *  locationManager:didEnterRegion:
     *
     *  Discussion:
     *    Invoked when the user enters a monitored region.  This callback will be invoked for every allocated
     *    CLLocationManager instance with a non-nil delegate that implements this method.
     */
    @available(iOS 4.0, *)
    open func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        userEnterRegion.wrappedValue = region
    }

    /**
     *  离开监控区域时调用
     *  locationManager:didExitRegion:
     *
     *  Discussion:
     *    Invoked when the user exits a monitored region.  This callback will be invoked for every allocated
     *    CLLocationManager instance with a non-nil delegate that implements this method.
     */
    @available(iOS 4.0, *)
    open func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        userExitRegion.wrappedValue = region
    }

    /**
     *  区域监控失败
     *  locationManager:monitoringDidFailForRegion:withError:
     *
     *  Discussion:
     *    Invoked when a region monitoring error has occurred. Error types are defined in "CLError.h".
     */
    @available(iOS 4.0, *)
    open func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        userRegionMonitorFail.wrappedValue = (region, FZLocationError(error: error))
    }

    /**
     *  获取当前位置在某个区域的状态：在区域内还是区域
     *  使用方法requestStateForRegion获取某个区域状态时调用
     *
     *  locationManager:didDetermineState:forRegion:
     *
     *  Discussion:
     *    Invoked when there's a state transition for a monitored region or in response to a request for state via a
     *    a call to requestStateForRegion:.
     */
    @available(iOS 7.0, *)
    open func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        userRegionState.wrappedValue = (state, region)
    }

    // MARK: -

    /**
     *  改变授权的状态
     *  locationManager:didChangeAuthorizationStatus:
     *
     *  Discussion:
     *    Invoked when the authorization status changes for this application.
     */
    @available(iOS 4.2, *)
    open func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        FZLocationConfiguration.locationAuthorizationAction?(status)
        userAuthorization.wrappedValue = status
    }

    // MARK: -

    /**
     *  已经停止位置的更新
     *  Discussion:
     *    Invoked when location updates are automatically paused.
     */
    @available(iOS 6.0, *)
    open func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        let value = userLocationPause.wrappedValue
        userLocationPause.wrappedValue = value + 1
    }

    /**
     *  位置定位重新开始定位位置的更新
     *  Discussion:
     *    Invoked when location updates are automatically resumed.
     *
     *    In the event that your application is terminated while suspended, you will
     *      not receive this notification.
     */
    @available(iOS 6.0, *)
    open func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        let value = userLocationResume.wrappedValue
        userLocationResume.wrappedValue = value + 1
    }

    /**
     *  已经完成了推迟的更新
     *  locationManager:didFinishDeferredUpdatesWithError:
     *
     *  Discussion:
     *    Invoked when deferred updates will no longer be delivered. Stopping
     *    location, disallowing deferred updates, and meeting a specified criterion
     *    are all possible reasons for finishing deferred updates.
     *
     *    An error will be returned if deferred updates end before the specified
     *    criteria are met (see CLError), otherwise error will be nil.
     */
    @available(iOS 6.0, *)
    open func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        var finishDeferred = true
        var _error: FZLocationError?
        if let error = error {
            finishDeferred = false
            _error = FZLocationError(error: error)
        }
        userLocationDeferred.wrappedValue = (finishDeferred, _error)
    }

    // MARK: - Visit

    /**
     *  已经访问过的位置，就会调用这个表示已经访问过，这个在栅栏或者定位区域都是使用到的
     *  locationManager:didVisit:
     *
     *  Discussion:
     *    Invoked when the CLLocationManager determines that the device has visited
     *    a location, if visit monitoring is currently started (possibly from a
     *    prior launch).
     */
    @available(iOS 8.0, *)
    open func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        userVisit.wrappedValue = visit
    }

}
