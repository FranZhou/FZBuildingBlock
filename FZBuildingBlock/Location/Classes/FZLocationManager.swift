//
//  FZLocationManager.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/28.
//

import UIKit
import CoreLocation
import FZObserver

/// 定位数据监听
open class FZLocationManager: NSObject {

    /// 请求定位权限类型
    public enum AuthorizationType {
        case whenInUse
        case always
    }

    // MARK: - static
    /// singleton
    public static let `default`: FZLocationManager = {
        let manager = FZLocationManager()
        return manager
    }()

    // MARK: - open

    // MARK: Location
    ///  用户定位，可供监听
    ///  locationManager:didUpdateLocations:
    open lazy var userLocation: FZObserver<CLLocation?> = FZObserver(wrappedValue: nil)

    /// 用户定位失败
    /// locationManager:didFailWithError:
    open lazy var userLocationFail: FZObserver<FZLocationError?> = FZObserver(wrappedValue: nil)

    /// 用户面朝的方向
    /// locationManager:didUpdateHeading:
    open lazy var userHeading: FZObserver<CLHeading?> = FZObserver(wrappedValue: nil)

    // MARK: BeaconRegion

    /// 检测到区域内的iBeacons
    /// locationManager:didRangeBeacons:inRegion:
    open lazy var userBeaconRegion: FZObserver<([CLBeacon], CLBeaconRegion)?>  = FZObserver(wrappedValue: nil)

    /// 区域检测iBeacons失败
    /// locationManager:rangingBeaconsDidFailForRegion:withError:
    open lazy var userBeaconRegionFail: FZObserver<(CLBeaconRegion, FZLocationError)?>  = FZObserver(wrappedValue: nil)

    /// 检测到区域内的iBeacons
    /// locationManager:didRangeBeacons:satisfyingConstraint:
    @available(iOS 13.0, *)
    open lazy var userBeaconConstraint: FZObserver<([CLBeacon], CLBeaconIdentityConstraint)?>  = FZObserver(wrappedValue: nil)

    /// 区域检测iBeacons失败
    /// locationManager:didFailRangingBeaconsForConstraint:error:
    @available(iOS 13.0, *)
    open lazy var userBeaconConstraintFail: FZObserver<(CLBeaconIdentityConstraint, FZLocationError)?>  = FZObserver(wrappedValue: nil)

    // MARK: Region

    /// 开启区域监控
    /// locationManager:didStartMonitoringForRegion:
    open lazy var userRegionMonitorStart: FZObserver<CLRegion?>  = FZObserver(wrappedValue: nil)

    /// 用户进入区域
    ///  locationManager:didEnterRegion:
    open lazy var userEnterRegion: FZObserver<CLRegion?>  = FZObserver(wrappedValue: nil)

    /// 用户离开区域
    /// locationManager:didExitRegion:
    open lazy var userExitRegion: FZObserver<CLRegion?>  = FZObserver(wrappedValue: nil)

    /// 用户区域状态
    /// locationManager:didDetermineState:forRegion:
    open lazy var userRegionState: FZObserver<(CLRegionState, CLRegion)?>  = FZObserver(wrappedValue: nil)

    /// 区域监控失败
    /// locationManager:monitoringDidFailForRegion:withError:
    open lazy var userRegionMonitorFail: FZObserver<(CLRegion?, FZLocationError)?>  = FZObserver(wrappedValue: nil)

    // MARK: status
    /// 定位授权状态
    open lazy var userAuthorization: FZObserver<CLAuthorizationStatus>  = FZObserver(wrappedValue: CLLocationManager.authorizationStatus())

    // MARK: Pause/Resume/Deferred

    /// 停止位置更新
    /// locationManagerDidPauseLocationUpdates
    open lazy var userLocationPause: FZObserver<Int> = FZObserver(wrappedValue: 0)

    /// 重新开始定位
    /// locationManagerDidResumeLocationUpdates
    open lazy var userLocationResume: FZObserver<Int> = FZObserver(wrappedValue: 0)

    /// 完成了推迟更新
    /// locationManager:didFinishDeferredUpdatesWithError:
    open lazy var userLocationDeferred: FZObserver<(Bool, FZLocationError?)?> = FZObserver(wrappedValue: nil)

    // MARK: Visit

    /// 用户访问
    open lazy var userVisit: FZObserver<CLVisit?> = FZObserver(wrappedValue: nil)

    // MARK: Location Manager

    /// CLLocationManager
    ///
    /// ```
    ///  distanceFilter = kCLDistanceFilterNone
    ///  desiredAccuracy = kCLLocationAccuracyBest
    ///  allowsBackgroundLocationUpdates = true
    ///  pausesLocationUpdatesAutomatically = false
    ///  headingFilter = kCLHeadingFilterNone
    /// ```
    open lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.distanceFilter = kCLDistanceFilterNone
        lm.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 9.0, *) {
            lm.allowsBackgroundLocationUpdates = true
        }
        lm.pausesLocationUpdatesAutomatically = false
        lm.headingFilter = kCLHeadingFilterNone
        return lm
    }()

    // MARK: - init
    /// init
    private override init() {
        super.init()
        locationManager.delegate = self
        request(authorizationType: FZLocationConfiguration.requestAuthorizationType)
    }

}

// MARK: - Location

/// 定位
extension FZLocationManager {

    @available(iOS 9.0, *)
    open func requestLocation() {
        locationManager.requestLocation()
    }

    open func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    open func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    open func startMonitoringSignificantLocationChanges() {
        locationManager.startMonitoringSignificantLocationChanges()
    }

    open func startMonitoringSignificantLocationChanges(for region: CLRegion) {
        locationManager.startMonitoringSignificantLocationChanges()
    }

}

// MARK: - Heading

/// Heading
extension FZLocationManager {

    open func headingAvailable() -> Bool {
        return CLLocationManager.headingAvailable()
    }

    open func startUpdatingHeading() {
        if headingAvailable() {
            locationManager.startUpdatingHeading()
        }
    }

    open func stopUpdatingHeading() {
        locationManager.stopUpdatingHeading()
    }

    open func dismissHeadingCalibrationDisplay() {
        locationManager.dismissHeadingCalibrationDisplay()
    }

}

// MARK: - BeaconRegion

/// BeaconRegion
extension FZLocationManager {

    open func isRangingAvailable() -> Bool {
        return CLLocationManager.isRangingAvailable()
    }

    open func startRangingBeacons(in beaconRegion: CLBeaconRegion) {
        if isRangingAvailable() {
            locationManager.startRangingBeacons(in: beaconRegion)
        }
    }

    open func stopRangingBeacons(in beaconRegion: CLBeaconRegion) {
        locationManager.stopRangingBeacons(in: beaconRegion)
    }

    @available(iOS 13.0, *)
    open func startRangingBeacons(satisfying constraint: CLBeaconIdentityConstraint) {
        if isRangingAvailable() {
            locationManager.startRangingBeacons(satisfying: constraint)
        }
    }

    @available(iOS 13.0, *)
    open func stopRangingBeacons(satisfying constraint: CLBeaconIdentityConstraint) {
        locationManager.stopRangingBeacons(satisfying: constraint)
    }

    open func rangedRegions() -> Set<CLRegion> {
        return locationManager.rangedRegions
    }

    @available(iOS 13.0, *)
    open func rangedBeaconConstraints() -> Set<CLBeaconIdentityConstraint> {
        return locationManager.rangedBeaconConstraints
    }
}

// MARK: - Monitoring For Region

/// Region
extension FZLocationManager {

    open func isMonitoringAvailableForClass(for regionClass: AnyClass) -> Bool {
        return CLLocationManager.isMonitoringAvailable(for: regionClass)
    }

    open func startMonitoring(for region: CLRegion, desiredAccuracy: CLLocationAccuracy? = nil) {
        if let desiredAccuracy = desiredAccuracy {
            locationManager.desiredAccuracy = desiredAccuracy
        }
        locationManager.startMonitoring(for: region)
    }

    open func stopMonitoring(for region: CLRegion) {
        locationManager.stopMonitoring(for: region)
    }

    open func requestState(for region: CLRegion) {
        locationManager.requestState(for: region)
    }

    open func monitoredRegions() -> Set<CLRegion> {
        return locationManager.monitoredRegions
    }

}

// MARK: - Normal Control

/// Normal  Controlit
extension FZLocationManager {

    open func deferredLocationUpdatesAvailable() -> Bool {
        return CLLocationManager.deferredLocationUpdatesAvailable()
    }

    open func allowDeferredLocationUpdates(untilTraveled distance: CLLocationDistance, timeout: TimeInterval) {
        locationManager.allowDeferredLocationUpdates(untilTraveled: distance, timeout: timeout)
    }

    open func disallowDeferredLocationUpdates() {
        locationManager.disallowDeferredLocationUpdates()
    }

}

// MARK: - Visit

/// Visit
extension FZLocationManager {

    open func startMonitoringVisits() {
        locationManager.startMonitoringVisits()
    }

    open func stopMonitoringVisits() {
        locationManager.stopMonitoringVisits()
    }

}
