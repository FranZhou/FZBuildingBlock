//
//  FZLocationManager.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/8/28.
//

import UIKit
import CoreLocation
import FZObserver
import FZWeakProxy

/// 定位数据监听
public final class FZLocationManager: NSObject {

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

    // MARK: - public

    // MARK: Location
    ///  用户定位，可供监听
    ///  locationManager:didUpdateLocations:
    public lazy var userLocation: FZObserver<(FZWeakProxy<FZLocationManager>, CLLocation)?> = FZObserver(wrappedValue: nil)

    /// 用户定位失败
    /// locationManager:didFailWithError:
    public lazy var userLocationFail: FZObserver<(FZWeakProxy<FZLocationManager>, FZLocationError)?> = FZObserver(wrappedValue: nil)

    /// 用户面朝的方向
    /// locationManager:didUpdateHeading:
    public lazy var userHeading: FZObserver<(FZWeakProxy<FZLocationManager>, CLHeading)?> = FZObserver(wrappedValue: nil)

    // MARK: BeaconRegion

    /// 检测到区域内的iBeacons
    /// locationManager:didRangeBeacons:inRegion:
    public lazy var userBeaconRegion: FZObserver<(FZWeakProxy<FZLocationManager>, [CLBeacon], CLBeaconRegion)?>  = FZObserver(wrappedValue: nil)

    /// 区域检测iBeacons失败
    /// locationManager:rangingBeaconsDidFailForRegion:withError:
    public lazy var userBeaconRegionFail: FZObserver<(FZWeakProxy<FZLocationManager>, CLBeaconRegion, FZLocationError)?>  = FZObserver(wrappedValue: nil)

    /// 检测到区域内的iBeacons
    /// locationManager:didRangeBeacons:satisfyingConstraint:
    @available(iOS 13.0, *)
    public lazy var userBeaconConstraint: FZObserver<(FZWeakProxy<FZLocationManager>, [CLBeacon], CLBeaconIdentityConstraint)?>  = FZObserver(wrappedValue: nil)

    /// 区域检测iBeacons失败
    /// locationManager:didFailRangingBeaconsForConstraint:error:
    @available(iOS 13.0, *)
    public lazy var userBeaconConstraintFail: FZObserver<(FZWeakProxy<FZLocationManager>, CLBeaconIdentityConstraint, FZLocationError)?>  = FZObserver(wrappedValue: nil)

    // MARK: Region

    /// 开启区域监控
    /// locationManager:didStartMonitoringForRegion:
    public lazy var userRegionMonitorStart: FZObserver<(FZWeakProxy<FZLocationManager>, CLRegion)?>  = FZObserver(wrappedValue: nil)

    /// 用户进入区域
    ///  locationManager:didEnterRegion:
    public lazy var userEnterRegion: FZObserver<(FZWeakProxy<FZLocationManager>, CLRegion)?>  = FZObserver(wrappedValue: nil)

    /// 用户离开区域
    /// locationManager:didExitRegion:
    public lazy var userExitRegion: FZObserver<(FZWeakProxy<FZLocationManager>, CLRegion)?>  = FZObserver(wrappedValue: nil)

    /// 用户区域状态
    /// locationManager:didDetermineState:forRegion:
    public lazy var userRegionState: FZObserver<(FZWeakProxy<FZLocationManager>, CLRegionState, CLRegion)?>  = FZObserver(wrappedValue: nil)

    /// 区域监控失败
    /// locationManager:monitoringDidFailForRegion:withError:
    public lazy var userRegionMonitorFail: FZObserver<(FZWeakProxy<FZLocationManager>, CLRegion?, FZLocationError)?>  = FZObserver(wrappedValue: nil)

    // MARK: status
    /// 定位授权状态
    public lazy var userAuthorization: FZObserver<(FZWeakProxy<FZLocationManager>, CLAuthorizationStatus)?>  = FZObserver(wrappedValue: nil)

    // MARK: Pause/Resume/Deferred

    /// 停止位置更新
    /// locationManagerDidPauseLocationUpdates
    public lazy var userLocationPause: FZObserver<FZWeakProxy<FZLocationManager>?> = FZObserver(wrappedValue: nil)

    /// 重新开始定位
    /// locationManagerDidResumeLocationUpdates
    public lazy var userLocationResume: FZObserver<FZWeakProxy<FZLocationManager>?> = FZObserver(wrappedValue: nil)

    /// 完成了推迟更新
    /// locationManager:didFinishDeferredUpdatesWithError:
    public lazy var userLocationDeferred: FZObserver<(FZWeakProxy<FZLocationManager>, FZLocationError?)?> = FZObserver(wrappedValue: nil)

    // MARK: Visit

    /// 用户访问
    public lazy var userVisit: FZObserver<(FZWeakProxy<FZLocationManager>, CLVisit)?> = FZObserver(wrappedValue: nil)

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
    public private(set) lazy var locationManager: CLLocationManager = {
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

// MARK: - CLLocationManager normal
extension FZLocationManager {

    /**
     *    activityType
     *
     *  Discussion:
     *        Specifies the type of user activity. Currently affects behavior such as
     *        the determination of when location updates may be automatically paused.
     *        By default, CLActivityTypeOther is used.
     */
    @available(iOS 6.0, *)
    public var activityType: CLActivityType {
        get {
            return locationManager.activityType
        }
        set {
            locationManager.activityType = newValue
        }
    }

    /**
     *  distanceFilter
     *
     *  Discussion:
     *      Specifies the minimum update distance in meters. Client will not be notified of movements of less
     *      than the stated value, unless the accuracy has improved. Pass in kCLDistanceFilterNone to be
     *      notified of all movements. By default, kCLDistanceFilterNone is used.
     */
    public var distanceFilter: CLLocationDistance {
        get {
            return locationManager.distanceFilter
        }
        set {
            locationManager.distanceFilter = newValue
        }
    }

    /**
     *  desiredAccuracy
     *
     *  Discussion:
     *      The desired location accuracy. The location service will try its best to achieve
     *      your desired accuracy. However, it is not guaranteed. To optimize
     *      power performance, be sure to specify an appropriate accuracy for your usage scenario (eg,
     *      use a large accuracy value when only a coarse location is needed). Use kCLLocationAccuracyBest to
     *      achieve the best possible accuracy. Use kCLLocationAccuracyBestForNavigation for navigation.
     *      The default value varies by platform.
     */
    public var desiredAccuracy: CLLocationAccuracy {
        get {
            return locationManager.desiredAccuracy
        }
        set {
            locationManager.desiredAccuracy = newValue
        }
    }

    /**
     *  pausesLocationUpdatesAutomatically
     *
     *  Discussion:
     *        Specifies that location updates may automatically be paused when possible.
     *        By default, this is YES for applications linked against iOS 6.0 or later.
     */
    @available(iOS 6.0, *)
    public var pausesLocationUpdatesAutomatically: Bool {
        get {
            return locationManager.pausesLocationUpdatesAutomatically
        }
        set {
            locationManager.pausesLocationUpdatesAutomatically = newValue
        }
    }

    /**
     *  allowsBackgroundLocationUpdates
     *
     *  Discussion:
     *      By default, this is NO for applications linked against iOS 9.0 or later,
     *      regardless of minimum deployment target.
     *
     *      With UIBackgroundModes set to include "location" in Info.plist, you must
     *      also set this property to YES at runtime whenever calling
     *      -startUpdatingLocation with the intent to continue in the background.
     *
     *      Setting this property to YES when UIBackgroundModes does not include
     *      "location" is a fatal error.
     *
     *      Resetting this property to NO is equivalent to omitting "location" from
     *      the UIBackgroundModes value.  Access to location is still permitted
     *      whenever the application is running (ie not suspended), and has
     *      sufficient authorization (ie it has WhenInUse authorization and is in
     *      use, or it has Always authorization).  However, the app will still be
     *      subject to the usual task suspension rules.
     *
     *      See -requestWhenInUseAuthorization and -requestAlwaysAuthorization for
     *      more details on possible authorization values.
     */
    @available(iOS 9.0, *)
    public var allowsBackgroundLocationUpdates: Bool {
        get {
            return locationManager.allowsBackgroundLocationUpdates
        }
        set {
            locationManager.allowsBackgroundLocationUpdates = newValue
        }
    }

    /**
     *  showsBackgroundLocationIndicator
     *
     *  Discussion:
     *      Specifies that an indicator be shown when the app makes use of continuous
     *      background location updates.  Starting continuous background location
     *      updates requires the app to set UIBackgroundModes to include "location"
     *      and to set the property allowsBackgroundLocationUpdates to YES before
     *      calling -startUpdatingLocation with the intent to continue in the
     *      background.
     *
     *      Note that this property only applies to apps with Always authorization.
     *      For apps with WhenInUse authorization, the indicator is always shown when
     *      using continuous background location updates in order to maintain user
     *      visibility and that the app is still in use.
     *
     *      The default value of this property is NO.
     */
    @available(iOS 11.0, *)
    public var showsBackgroundLocationIndicator: Bool {
        get {
            return locationManager.showsBackgroundLocationIndicator
        }
        set {
            locationManager.showsBackgroundLocationIndicator = newValue
        }
    }

    /**
     *  maximumRegionMonitoringDistance
     *
     *  Discussion:
     *       the maximum region size, in terms of a distance from a central point, that the framework can support.
     *       Attempts to register a region larger than this will generate a kCLErrorRegionMonitoringFailure.
     *       This value may vary based on the hardware features of the device, as well as on dynamically changing resource constraints.
     */
    @available(iOS 4.0, *)
    public var maximumRegionMonitoringDistance: CLLocationDistance {
        get {
            return locationManager.maximumRegionMonitoringDistance
        }
    }

}
