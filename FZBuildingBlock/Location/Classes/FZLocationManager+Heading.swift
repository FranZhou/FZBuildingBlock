//
//  FZLocationManager+Heading.swift
//  FZBuildingBlock
//
//  Created by FranZhou on 2020/9/3.
//

import Foundation
import CoreLocation

// MARK: - Heading

/// Heading
extension FZLocationManager {

    /**
     *  headingAvailable
     *
     *  Discussion:
     *      Returns YES if the device supports the heading service, otherwise NO.
     */
    @available(iOS 4.0, *)
    public func headingAvailable() -> Bool {
        return CLLocationManager.headingAvailable()
    }

    /**
     *  headingFilter
     *
     *  Discussion:
     *      Specifies the minimum amount of change in degrees needed for a heading service update. Client will not
     *      be notified of updates less than the stated filter value. Pass in kCLHeadingFilterNone to be
     *      notified of all updates. By default, 1 degree is used.
     */
    @available(iOS 3.0, *)
    public var headingFilter: CLLocationDegrees {
        get {
            return locationManager.headingFilter
        }
        set {
            locationManager.headingFilter = newValue
        }
    }

    /**
     *  heading
     *
     *  Discussion:
     *      Returns the latest heading update received, or nil if none is available.
     */
    @available(iOS 4.0, *)
    public var heading: CLHeading? {
        get {
            return locationManager.heading
        }
    }

    /*
     *  headingOrientation
     *
     *  Discussion:
     *      Specifies a physical device orientation from which heading calculation should be referenced. By default,
     *      CLDeviceOrientationPortrait is used. CLDeviceOrientationUnknown, CLDeviceOrientationFaceUp, and
     *      CLDeviceOrientationFaceDown are ignored.
     *
     */
    @available(iOS 4.0, *)
    public var headingOrientation: CLDeviceOrientation {
        get {
            return locationManager.headingOrientation
        }
        set {
            locationManager.headingOrientation = newValue
        }
    }

    /**
     *  startUpdatingHeading
     *
     *  Discussion:
     *      Start updating heading.
     */
    @available(iOS 3.0, *)
    public func startUpdatingHeading() {
        if headingAvailable() {
            locationManager.startUpdatingHeading()
        } else {
            FZLocationConfiguration.locationLog?("CLLocationManager headingAvailable is unavailable, you can't startUpdatingHeading")
        }
    }

    /**
     *  stopUpdatingHeading
     *
     *  Discussion:
     *      Stop updating heading.
     */
    @available(iOS 3.0, *)
    public func stopUpdatingHeading() {
        locationManager.stopUpdatingHeading()
    }

    /**
     *  dismissHeadingCalibrationDisplay
     *
     *  Discussion:
     *      Dismiss the heading calibration immediately.
     */
    @available(iOS 3.0, *)
    public func dismissHeadingCalibrationDisplay() {
        locationManager.dismissHeadingCalibrationDisplay()
    }

}
