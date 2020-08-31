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
    public static let sharedManager: FZLocationManager = {
        let manager = FZLocationManager()
        return manager
    }()

    // MARK: - open

    // MARK: Location
    ///  用户定位，可供监听
    ///  locationManager:didUpdateLocations:
    open lazy var userLocation: FZObserver<FZLocation?> = FZObserver(wrappedValue: nil)

    /// 用户定位失败
    /// locationManager:didFailWithError:
    open lazy var userLocationFail: FZObserver<FZLocationError?> = FZObserver(wrappedValue: nil)

    /// 用户面朝的方向
    /// locationManager:didUpdateHeading:
    open lazy var userHeading: FZObserver<FZHeading?> = FZObserver(wrappedValue: nil)

    // MARK: BeaconRegion

    /// 检测到区域内的iBeacons
    /// locationManager:didRangeBeacons:inRegion:
    open lazy var userBeaconRegion: FZObserver<([FZBeacon], FZBeaconRegion)?>  = FZObserver(wrappedValue: nil)

    /// 区域检测iBeacons失败
    /// locationManager:rangingBeaconsDidFailForRegion:withError:
    open lazy var userBeaconRegionFail: FZObserver<(FZBeaconRegion, FZLocationError)?>  = FZObserver(wrappedValue: nil)

    /// 检测到区域内的iBeacons
    /// locationManager:didRangeBeacons:satisfyingConstraint:
    @available(iOS 13.0, *)
    open lazy var userBeaconConstraint: FZObserver<([FZBeacon], FZBeaconIdentityConstraint)?>  = FZObserver(wrappedValue: nil)

    /// 区域检测iBeacons失败
    /// locationManager:didFailRangingBeaconsForConstraint:error:
    @available(iOS 13.0, *)
    open lazy var userBeaconConstraintFail: FZObserver<(FZBeaconIdentityConstraint, FZLocationError)?>  = FZObserver(wrappedValue: nil)

    // MARK: Region

    /// 开启区域监控
    /// locationManager:didStartMonitoringForRegion:
    open lazy var userRegionMonitorStart: FZObserver<FZRegion?>  = FZObserver(wrappedValue: nil)

    /// 用户进入区域
    ///  locationManager:didEnterRegion:
    open lazy var userEnterRegion: FZObserver<FZRegion?>  = FZObserver(wrappedValue: nil)

    /// 用户离开区域
    /// locationManager:didExitRegion:
    open lazy var userExitRegion: FZObserver<FZRegion?>  = FZObserver(wrappedValue: nil)

    /// 用户区域状态
    /// locationManager:didDetermineState:forRegion:
    open lazy var userRegionState: FZObserver<(FZRegionState, FZRegion)?>  = FZObserver(wrappedValue: nil)

    /// 区域监控失败
    /// locationManager:monitoringDidFailForRegion:withError:
    open lazy var userRegionMonitorFail: FZObserver<(FZRegion?, FZLocationError)?>  = FZObserver(wrappedValue: nil)

    // MARK: - -

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
    open lazy var userVisit: FZObserver<FZVisit?> = FZObserver(wrappedValue: nil)

    // MARK: Location Manager

    /// CLLocationManager
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
    ///  init
    public override init() {
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

    open func startMonitoringSignificantLocationChanges(for region: FZRegion) {
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

    open func startRangingBeacons(in beaconRegion: FZBeaconRegion) {
        if isRangingAvailable() {
            locationManager.startRangingBeacons(in: beaconRegion.beaconRegion)
        }
    }

    open func stopRangingBeacons(in beaconRegion: FZBeaconRegion) {
        locationManager.stopRangingBeacons(in: beaconRegion.beaconRegion)
    }

    @available(iOS 13.0, *)
    open func startRangingBeacons(satisfying constraint: FZBeaconIdentityConstraint) {
        if isRangingAvailable() {
            locationManager.startRangingBeacons(satisfying: constraint.beaconIdentityConstraint)
        }
    }

    @available(iOS 13.0, *)
    open func stopRangingBeacons(satisfying constraint: FZBeaconIdentityConstraint) {
        locationManager.stopRangingBeacons(satisfying: constraint.beaconIdentityConstraint)
    }

    open func rangedRegions() -> Set<FZRegion> {
        var regions: [FZRegion] = []
        for region in locationManager.rangedRegions {
            regions.append(FZRegion(region: region))
        }
        return Set(regions)
    }

    @available(iOS 13.0, *)
    open func rangedBeaconConstraints() -> Set<FZBeaconIdentityConstraint> {
        var beaconConstraints: [FZBeaconIdentityConstraint] = []
        for beaconConstraint in locationManager.rangedBeaconConstraints {
            beaconConstraints.append(FZBeaconIdentityConstraint(beaconIdentityConstraint: beaconConstraint))
        }
        return Set(beaconConstraints)
    }
}

// MARK: - Monitoring For Region

/// Region
extension FZLocationManager {

    open func isMonitoringAvailableForClass(for regionClass: AnyClass) -> Bool {
        return CLLocationManager.isMonitoringAvailable(for: regionClass)
    }

    open func startMonitoring(for region: FZRegion, desiredAccuracy: CLLocationAccuracy? = nil) {
        if let desiredAccuracy = desiredAccuracy {
            locationManager.desiredAccuracy = desiredAccuracy
        }
        locationManager.startMonitoring(for: region.region)
    }

    open func stopMonitoring(for region: FZRegion) {
        locationManager.stopMonitoring(for: region.region)
    }

    open func requestState(for region: FZRegion) {
        locationManager.requestState(for: region.region)
    }

    open func monitoredRegions() -> Set<FZRegion> {
        var regions: [FZRegion] = []
        for region in locationManager.monitoredRegions {
            regions.append(FZRegion(region: region))
        }
        return Set(regions)
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
